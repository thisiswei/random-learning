#!/usr/bin/env python
#
# Copyright 2009 Facebook
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

"""
A slightly modified, cleaner, version of the Tornado options parser,
that is non-Tornado specific (beaufour)

A command line parsing module that lets modules define their own options.

Each module defines its own options, e.g.::

    from tornado.options import define, options

    define("mysql_host", default="127.0.0.1:3306", help="Main user DB")
    define("memcache_hosts", default="127.0.0.1:11011", multiple=True,
           help="Main user memcache servers")

    def connect():
        db = database.Connection(options.mysql_host)
        ...

The main() method of your application does not need to be aware of all of
the options used throughout your program; they are all automatically loaded
when the modules are loaded. Your main() method can parse the command line
or parse a config file with::

    import tornado.options
    tornado.options.parse_config_file("/etc/server.conf")
    tornado.options.parse_command_line()

Command line formats are what you would expect ("--myoption=myvalue").
Config files are just Python files. Global names become options, e.g.::

    myoption = "myvalue"
    myotheroption = "myothervalue"

We support datetimes, timedeltas, ints, and floats (just pass a 'type'
kwarg to define). We also accept multi-value options. See the documentation
for define() below.
"""

import datetime
import logging
import os
import re
import sys

FLOAT_PATTERN = r'[-+]?(?:\d+(?:\.\d*)?|\.\d+)(?:[eE][-+]?\d+)?'

TIMEDELTA_PATTERN = re.compile(
    r'\s*(%s)\s*(\w*)\s*' % FLOAT_PATTERN, re.IGNORECASE)

TIMEDELTA_ABBREVS = [
    ('hours', ['h']),
    ('minutes', ['m', 'min']),
    ('seconds', ['s', 'sec']),
    ('milliseconds', ['ms']),
    ('microseconds', ['us']),
    ('days', ['d']),
    ('weeks', ['w']),
]

TIMEDELTA_ABBREV_DICT = dict(
        (abbrev, full) for full, abbrevs in TIMEDELTA_ABBREVS
        for abbrev in abbrevs)

FILE_PATHS =  [
                "/etc/chartbeat/%s",
                os.path.expanduser("~/.chartbeat/%s"),
               ]
"""Where to look for configuration files"""

def define(name, default=None, type=str, help=None, metavar=None,
    enum=None,
    required=False,
    multiple=False,
    ):
    """Defines a new command line option.

    If type is given (one of str, float, int, datetime, or timedelta),
    we parse the command line arguments based on the given type. If
    multiple is True, we accept comma-separated values, and the option
    value is always a list.

    For multi-value integers, we also accept the syntax x:y, which
    turns into range(x, y) - very useful for long integer ranges.

    help and metavar are used to construct the automatically generated
    command line help string. The help message is formatted like::

       --name=METAVAR      help string

    Command line option names must be unique globally. They can be parsed
    from the command line with parse_command_line() or parsed from a
    config file with parse_config_file.
    """
    if enum:
        help = help or "possible values: %s" % ', '.join(enum)
    if name in options:
        logging.info('overriding option with name %s' % name)
    frame = sys._getframe(0)
    options_file = frame.f_code.co_filename
    file_name = frame.f_back.f_code.co_filename
    if file_name == options_file: file_name = ""
    options[name] = _Option(name, file_name=file_name, default=default,
                            type=type, help=help, metavar=metavar,
                            enum=enum,
                            required=required,
                            multiple=multiple)


def parse_command_line(args=None):
    """Parses all options given on the command line.

    We return all command line arguments that are not options as a list.
    """
    if args is None: args = sys.argv
    remaining = []
    for i in xrange(1, len(args)):
        # All things after the last option are command line arguments
        if not args[i].startswith("-"):
            remaining = args[i:]
            break
        if args[i] == "--":
            remaining = args[i+1:]
            break
        arg = args[i].lstrip("-")
        name, equals, value = arg.partition("=")
        name = name.replace('-', '_')
        if not name in options:
            print_help()
            raise Error('Unrecognized command line option: %r' % name)
        option = options[name]
        if not equals:
            if option.type == bool:
                value = "true"
            else:
                raise Error('Option %r requires a value' % name)
        value = option.parse(value)
        if option.enum and (value not in option.enum):
            print_help()
            raise Error('Invalid value: {value}. Possible values are: {values}'.format(value=value, values=', '.join(option.enum)))

    if options.help:
        print_help()
        sys.exit(0)

    for name, option in options.items():
        if option.required and option.value() == None:
            print_help()
            raise Error("Field '{name}' is required".format(name=name))

    if 'act' in options and (not options.act and options.console):
        logging.info('dry-run, --act=True to enable actions')
    return remaining


def parse_config_file(path):
    """Parses and loads the Python config file at the given path."""
    config = {}
    execfile(path, config, config)
    for name in config:
        if name in options:
            options[name].set(config[name])


def print_help(file=sys.stdout, raw_args=None):
    """
    Prints all the command line options to stdout.

    @param file: (optional) File to write to, defaults to stdout
    @param raw_args: (optional) String with raw args to print in help too
    """
    extra = ''
    if raw_args:
        extra = ' %s' % raw_args
    print >> file, "Usage: %s [OPTIONS]%s" % (sys.argv[0], extra)
    print >> file, ""
    print >> file, "Options:"
    by_file = {}
    for option in options.itervalues():
        by_file.setdefault(option.file_name, []).append(option)

    for filename, o in sorted(by_file.items()):
        o.sort(key=lambda option: option.name)
        for option in o:
            prefix = option.name
            if option.metavar:
                prefix += "=" + option.metavar

            additional_txt = ""
            if option.default != None:
                additional_txt = " [default: %s]" % (option.default)
            if option.required:
                additional_txt += " [required]"

            print >> file, ("  --%-30s %s%s" %
                (prefix, option.help or "", additional_txt))
    print >> file

def read_options(name, required=None):
    """
    Reads options from config file, and overrides from command line
    """
    if not 'debug' in options.keys():
        define("debug", default=False, type=bool, help="Turn debug on/off")

    locations = [f % 'global.conf' for f in FILE_PATHS]
    filename = "%s.conf" % name
    locations += [f % filename for f in FILE_PATHS]
    for f in locations:
        if os.path.isfile(f):
            #logging.debug("Reading config options from %s", f)
            parse_config_file(f)

    parse_command_line()

    if required:
        for option in required:
            if not options[option].value():
                logging.error("Missing required config: %s", option)
                return False

    return True

class _Options(dict):
    """Our global program options, an dictionary with object-like access."""
    def __init__(self, lenient=False):
        self._lenient = lenient

    @classmethod
    def instance(cls):
        if not hasattr(cls, "_instance"):
            cls._instance = cls()
        return cls._instance

    def __getattr__(self, name):
        if isinstance(self.get(name), _Option):
            return self[name].value()
        if self._lenient:
            return None
        raise AttributeError("Unrecognized option %r" % name)


class _Option(object):
    def __init__(self, name, default=None, type=str, help=None, metavar=None,
                 multiple=False, file_name=None,
                 enum=None,
                 required=False,
                 ):
        if default is None and multiple:
            default = []
        self.name = name
        self.type = type
        self.help = help
        self.metavar = metavar
        self.multiple = multiple
        self.file_name = file_name
        self.default = default
        self._value = None
        self.enum = enum
        self.required = required

    def value(self):
        return self.default if self._value is None else self._value

    def parse(self, value):
        _parse = {
            datetime.datetime: self._parse_datetime,
            datetime.timedelta: parse_timedelta,
            bool: self._parse_bool,
            str: self._parse_string,
        }.get(self.type, self.type)
        if self.multiple:
            self._value = []
            for part in value.split(","):
                if self.type in (int, long):
                    # allow ranges of the form X:Y (inclusive at both ends)
                    lo, _, hi = part.partition(":")
                    lo = _parse(lo)
                    hi = _parse(hi) if hi else lo
                    self._value.extend(range(lo, hi+1))
                else:
                    self._value.append(_parse(part))
        else:
            self._value = _parse(value)
        return self.value()

    def set(self, value):
        if self.multiple:
            if not isinstance(value, list):
                raise Error("Option %r is required to be a list of %s" %
                            (self.name, self.type.__name__))
            for item in value:
                if item != None and not isinstance(item, self.type):
                    raise Error("Option %r is required to be a list of %s" %
                                (self.name, self.type.__name__))
        else:
            if value != None and not isinstance(value, self.type):
                raise Error("Option %r is required to be a %s" %
                            (self.name, self.type.__name__))
        self._value = value

    # Supported date/time formats in our options
    _DATETIME_FORMATS = [
        "%a %b %d %H:%M:%S %Y",
        "%Y-%m-%d %H:%M:%S",
        "%Y-%m-%d %H:%M",
        "%Y-%m-%dT%H:%M",
        "%Y%m%d %H:%M:%S",
        "%Y%m%d %H:%M",
        "%Y-%m-%d",
        "%Y%m%d",
        "%H:%M:%S",
        "%H:%M",
    ]

    def _parse_datetime(self, value):
        for format in self._DATETIME_FORMATS:
            try:
                return datetime.datetime.strptime(value, format)
            except ValueError:
                pass
        raise Error('Unrecognized date/time format: %r' % value)




    def _parse_bool(self, value):
        return value.lower() not in ("false", "0", "f")

    def _parse_string(self, value):
        return value.decode("utf-8")


class Error(Exception):
    pass

options = _Options.instance()

# Default options
define("help", type=bool, help="show this help information")
define("console", default=False, type=bool)
define("loglevel", default='info')
define("log_file")
define("enable_stats", type=bool,
    help='whether to create a stats file for logging. Only takes effect if log_file has been specified')

def options_to_dict(options):
    options_dict = {}
    for key, value in options.items():
        options_dict[key] = value.value()
    return options_dict

def parse_timedelta(value):
    try:
        sum = datetime.timedelta()
        start = 0
        while start < len(value):
            m = TIMEDELTA_PATTERN.match(value, start)
            if not m:
                raise Exception()
            num = float(m.group(1))
            units = m.group(2) or 'seconds'
            units = TIMEDELTA_ABBREV_DICT.get(units, units)
            sum += datetime.timedelta(**{units: num})
            start = m.end()
        return sum
    except:
        raise
