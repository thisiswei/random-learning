def p2(path):
    file_ = open(path)
    for line in file_.readlines():
        line = line.strip().split()[::-1]
        print reduce(_helper, line, [])[0]

def _helper(aux, expr):
    if expr.isdigit():
        aux.append(int(expr))
        return aux
    e1 = aux.pop()
    e2 = aux.pop()
    new_expr = (e2 * e1 if expr == '*' else
                e2 / e2 if expr == '/' else
                e2 + e1)
    aux.append(new_expr)
    return aux

def main():
    define('path', help="run it with --path=p2.txt")
    parse_command_line()
    p2(options.path)

if __name__ == "__main__":
    from cmdline import define
    from cmdline import options
    from cmdline import parse_command_line
    exit(main())
