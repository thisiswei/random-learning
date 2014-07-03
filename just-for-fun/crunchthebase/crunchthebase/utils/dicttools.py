import operator
import re

def normalize(s):
    """
    @param str: s
    @return: str
    """
    if not s:
        return s
    s = s.replace('&amp;', '&')
    s = s.replace('&nbsp;', ' ')
    s = s.strip().lower()
    return s

ARRAY_ACCESSOR = re.compile(r'(.*)\[(.*?)\]')
def get_dotted(data, field, default=None, delimiter='.',
        do_normalize=False,
        ):
    """
    Get a nested subfield inside data using Mongo style dotted notation
    notation. For example:
        data = {'a': 1, 'b': {'c': 2, 'd': {'e': 3}}}
        get_dotted_field(data, 'b.d.e') => 3

    Also allows array accessors:
        foo[@bla=3].bar: Choose the element in foo, whose attribute bla equals 3
        foo[3].bar: Choose index 3 in the foo array.

    Note that it is type insensitive, i.e. in comparisions '3' and 3 will
    evaluate to the same.
    """
    components = field.split(delimiter)
    components.reverse()
    while components and isinstance(data, dict):
        component = components.pop()
        accessor = None
        match = re.match(ARRAY_ACCESSOR, component)
        if match:
            component = match.group(1)
            accessor = match.group(2)
        data = data.get(component)
        if accessor:
            # Dict accessor
            if "@" in accessor:
                params = {}
                for pairs in accessor.split('@')[1:]:
                    params[pairs.split('=')[0]] = pairs.split('=')[1]
                # Kind of hacky, but let's handle the case where this should
                # be a list, but turns out a dict, such as in Gap's case.
                data = data if isinstance(data, list) else [data]
                for item in data:
                    for key, value in params.items():
                        if do_normalize:
                            val1 = normalize(str(item[key]))
                            val2 = normalize(str(value))
                        else:
                            val1 = str(item[key])
                            val2 = str(value)
                        if val1 != val2:
                            break
                    # If we iterated over all the params, and did not break
                    # then we are good.
                    else:
                        data=item
                        break

            # List accessor
            elif "*" in accessor:
                cur_fields = delimiter.join(components[::-1])
                return [get_dotted(d, cur_fields) for d in data]
            else:
                data = operator.getitem(data, int(accessor))

    # If there are components left, the final dest wasn't reached.
    if components or data == None:
        return default
    return data
