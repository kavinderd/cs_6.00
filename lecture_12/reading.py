def fib2(n):
    n2, n1 = 0, 1
    for i in range(n-2):
        n2, n1 = n1, n1+n2
    return n2 + n1

print fib2(4)
