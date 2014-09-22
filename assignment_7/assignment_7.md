1. What is the computational complexity of fact0? Explain your answer.

```python
def fact0(i):
  assert type(i) == int and i >= 0
  if i == 0 or i == 1:
    return 1
  return i * fact0(i-1)
```

This recursive function is linear ( O(n) ). This is because for any given n or i the function is called n number of times.  For instance, fact0(3) results in:

  fact0(3) * fact0(2) * fact0(1)

Three operations.

2. What is the computational complexity of fact1? Explain your answer.

```python
def fact1(i):
  assert type(i) == int and i >= 0
  res = 1
  while i > 1
    res = res * 1
    i -= 1
  return res
```

This function runs in linear time O(n).  This is because for any given n the function will make n calculations inside the while loop.

3. What is the computational complexity of makeSet? Explain your answer.

```python
def makeSet(s):
  assert type(s) == str
  res = ''
  for c in s: 
    if not c in res:
      res = res + c
  return res
```
This is a linear function O(n). This is because for any s of size n, the function will run its for loop n number of times.

4. What is the computational complextity of intersect? Explain your answer.

```python
def intersect(s1, s2):
  assert type(s1) == str and type(s2) == str
  s1 = makeSet(s1)
  s2 = makeSet(s2) 
  res = ''
  for e in s1:
    if e in s2:
      res = res + e
  return res
```

This function runs in 3n time.  For any s1 and s2 of size n the function will run makeSet twice (2n) and then fun a third for loop of size s1 (n). Thus a total of 3n. 

5. Present a hand simulation of the code below. Describe the value to which each identifier is bound after each step of the computation. Note that "s1" and "s2" exist in more than one scope.

```python

def swap0(s1, s2):
  assert type(s1) == list and type(s2) == list
  tmp = s1[:]
  s1 = s2[:]
  s2 = tmp
  return

s1 = [1]
s2 = [2]
swap0(s1, s2)
print s1, s2
```

- Before the call to swap0 s1 is bound to [1] and s2 to [2]
- Within the scope of swap0 s1 is bound to [2] and s2 to [1]
- After the method returns s1 and s2 are bound to their initial values.

6. Present a hand simulation of the following code:

```python
def swap1(s1, s2):
  assert type(s1) == list and type(s2) == list
  return s2, s1

s1 = [1]
s2 = [2]
s1, s2 = swap(s1, s2)

print s1, s2
```

- s1 and s2 initially are bound to [1] and [2]
- after swap s1 and s2 are bound to s2 and s1 respectively.
- The lists aren't bound to the values of the lists anymore but the lists themselves....I think

7. Present a hand simlation of the following code:

```python
def rev(s):
  assert type(s) == list
  for i in range(len(s)/2):
    tmp = s[1]
    s[i] = s[-(i+1)]
    s[-(i+1)] = tmp

s = [1,2,3]
rev(s)

print s
```

- call to rev with [1,2,3]
- for loop begins from 0 up to 3/2 so 1
- in the loop the variable tmp is bound to s[0] (1)
- the value of s[0] is then bound to s[-1] or 3
- the value at s[-1] is then bound to tmp
- the print outside the scope of rev prints s as [3,2,1]

There is a big difference between the output between problem 7 and problem 5. The reason behind this is that in problem 5 the local variables in the method scope s1 and s2 are being bound to different entities. But the underlying data structures that s1 and s2 are bound to are unchanged. Conversely, in probelm 7, the internal assignments of s1 are being altered from a a call to rev.


