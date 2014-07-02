def p1(path):
    file_ = open(path)
    for line in file_.readlines():
        line = line.strip().split(',')
        max_ =  _calc(map(int, line))
        print max_

def _calc(seq):
    candidates = [ sub[:i+1]
                   for sub in [seq[j:] for j in range(len(seq)-1)]
                   for i in range(2, len(sub))
                  ]
    return max(map(sum, candidates))

def main():
    define('path',
            help="run it with --path=p1.txt",
            default='p1.txt')
    parse_command_line()
    p1(options.path)

if __name__ == "__main__":
    from cmdline import define
    from cmdline import options
    from cmdline import parse_command_line
    exit(main())
