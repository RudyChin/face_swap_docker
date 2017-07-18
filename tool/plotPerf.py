# This is a script to draw the performance breakdown chart
# for Face Swap
#
# To use this script, you have to generate log first.
#
# 1. Make DEBUG=1 in
#     `face_swap/face_swap/face_swap.cpp`
#     `face_swap/face_swap/cnn_3dmm_expr.cpp`
# 2. Run face swap and redirect output, e.g. `python py_face_swap/pytest.py 0 > perf.log`
# 3. Run this script with perf.log, e.g. `python plotPerf.py perf.log perf.png`
#

import matplotlib.pyplot as plt
import numpy as np
import sys

fd = []
lmd = []
seg = []
coef = []
pose = []
sampleMesh = []
swap = []
expr = []
with open(sys.argv[1]) as f:
    for line in f:
        num = [int(s) for s in line.split() if s.isdigit()]
        if 'Face detection: ' in line:
            fd.append(num[0])
        elif 'Landmark detection: ' in line:
            lmd.append(num[0])
        elif 'Segmentation: ' in line:
            seg.append(num[0])
        elif 'Coef: ' in line:
            coef.append(num[0])
        elif 'Expr: ' in line:
            expr.append(num[0])
        elif 'Pose: ' in line:
            pose.append(num[0])
        elif 'sampleMesh: ' in line:
            sampleMesh.append(num[0])
        elif 'swap: ' in line:
            swap.append(num[0])

col = 8

if expr:
    coef = np.array(coef) + np.array(expr)
        
cmap = plt.get_cmap('Set1')
colors = [cmap(i) for i in np.linspace(0, 1, col)]
data = [np.mean(fd), np.mean(lmd), np.mean(seg), np.mean(coef), np.mean(pose), np.mean(sampleMesh), np.mean(swap)]
total = np.sum(np.array(data))
data.extend([total])
plt.figure(figsize=(9,6))

for i in range(col):
    plt.bar(i+0.1, data[i], color=colors[i])
plt.xticks([i+0.5 for i in range(col)], ['Face Dect.', 'Landmark', 'Seg.', 'Coef', 'Pose', 'sampleMesh', 'swap', 'Total'])
plt.ylabel('time (ms)')
plt.ylim([0, 4500])
plt.savefig(sys.argv[2])

