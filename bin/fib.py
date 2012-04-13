#! /usr/bin/env python

import os
import sys
import getopt
import time


def usage(message):
    if message != "":
        print message
    print "calc recursive fib"
    print "usage:",sys.argv[0].split(os.sep)[-1]
    print "\t-n --number     print fib(n) (default 30)"
    print "\t-r --recursive  recursive function"
    print "\t-f --for        for loop"
    print "\t-h --help       print this message"

def parse_opt(argv):
    n = 30
    recursive = True
    try:
        opts, args = getopt.getopt(argv, "n:rfh", ["number=", "recursive", "for", "help"])
    except getopt.GetoptError:
        usage("GetoptError")
        sys.exit(2)
    for o, a in opts:
        if o in ("-h", "--help"):
            usage("")
            sys.exit(0)
        if o in ("-n", "--number"):
            try:
                n = int(a)
            except ValueError:
                usage("ValueError -n option")
                sys.exit(1)
        if o in ("-f", "--for"):
            recursive = False
        if o in ("-r", "--recursive"):
            recursive = True

    return n, recursive


def for_fib(n):
    fib = range(n+1)
    for i in range(n+1):
        if i == 0:
            fib[i] = 0
        elif i == 1:
            fib[i] = 1
        else:
            fib[i] = fib[i-1]+fib[i-2]
    return fib[i]

def recursive_fib(n):
    if n==0 or n==1:
        return n
    return recursive_fib(n-1) + recursive_fib(n-2)

def main():
    n,recursive = parse_opt(sys.argv[1:])
    print "fib(%d) = " % n, 
    sys.stdout.flush()

    start = 0
    fib = 0
    if recursive:
        start = time.time()
        fib = recursive_fib(n)
        end = time.time()
    else:
        start = time.time()
        fib = for_fib(n)
        end = time.time()
    print fib
    sec = (end-start)
    ms = sec * 1000
    us = ms * 1000
    print "sec\tms\tus"
    print "%d\t%d\t%d" % (sec, ms, us)

    start = time.time()
    end = time.time()
    print "time.time takes", (end-start)*1000*1000, "us"


if __name__ == "__main__":
    main()
