import heapq
inputs = []
for line in open('input.txt', 'r'):
    inputs.append(line.strip())
n, k = map(int, inputs.pop(0).split())
s = list(map(int, inputs.pop(0).split()))
m = 0
heapq.heapify(s)
t = 0
while len(s)>1 and s[0]<k:
    m = heapq.heappop(s) + 2 * heapq.heappop(s)
    heapq.heappush(s, m)
    t += 1
print(t) if len(s)>1 or m>=k else print(-1)