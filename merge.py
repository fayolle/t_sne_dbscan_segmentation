eps = 1e-5

# point with normals
f = open('test_model.xyz')

# point with label
f2 = open('test_model_label.xyzl')

# merged output
f3 = open('test_model_normal_label.xyz', 'w')

# header of f2
num_lines = f2.readline()
print(num_lines)

for line in f:
    line2 = f2.readline()
    line = line.strip().split()
    line2 = line2.strip().split()
    x, y, z = float(line[0]), float(line[1]), float(line[2])
    x2,y2,z2 = float(line2[0]), float(line2[1]), float(line2[2])

    if (abs(x-x2)>eps) or (abs(y-y2)>eps) or (abs(z-z2)>eps):
        continue
    
    nx, ny, nz = float(line[3]), float(line[4]), float(line[5])
    label = int(line2[3])

    f3.write(str(x)+' '+str(y)+' '+str(z)+' '+str(nx)+' '+str(ny)+' '+str(nz)+' '+str(label)+'\n')


f.close()
f2.close()
f3.close()
