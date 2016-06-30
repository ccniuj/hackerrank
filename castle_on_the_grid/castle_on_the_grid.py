inputs = []
for line in open('input.txt', 'r') :
    inputs.append(line.strip())
maps = []
n = int(inputs.pop(0))
for _ in range(n) :
    maps.append(inputs.pop(0))
ix, iy, gx, gy = [ int(x) for x in inputs.pop(0).split() ]

dt = [[None]*n for _ in range(n)]
dt[ix][iy] = 0
q = []
q.append([ix, iy])
while len(q)>0 :
    cx, cy = q.pop(0)
    d = dt[cx][cy]
    i = 1
    while cx+i<n and maps[cx+i][cy]=='.' :
        if dt[cx+i][cy] is None :
            dt[cx+i][cy] = d + 1
            q.append([cx+i, cy])
        i += 1
    
    j = 1
    while cx-j>=0 and maps[cx-j][cy]=='.' :
        if dt[cx-j][cy] is None :
            dt[cx-j][cy] = d + 1
            q.append([cx-j, cy])
        j += 1
    
    k = 1
    while cy+k<n and maps[cx][cy+k]=='.' :
        if dt[cx][cy+k] is None :
            dt[cx][cy+k] = d + 1
            q.append([cx, cy+k])
        k += 1
    
    l = 1
    while cy-l>=0 and maps[cx][cy-l]=='.' :
        if dt[cx][cy-l] is None :
            dt[cx][cy-l] = d + 1
            q.append([cx, cy-l])
        l += 1
print(dt[gx][gy])
