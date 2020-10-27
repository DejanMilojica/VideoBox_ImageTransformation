import cv2
import numpy as np
import os

WIDTH = 640
HEIGHT = 480

def rgb_hex565(r, g, b):
    return ((int(r / 255 * 31) << 11) | (int(g / 255 * 63) << 5) | (int(b / 255 * 31))) # magic, don't ask

def resize(image):
    dim = (WIDTH, HEIGHT)
    return cv2.resize(image, dim, interpolation = cv2.INTER_AREA)

path = 'test.jpg' # path to input image
output = 'test.h'   # path to output txt file

f = open(output, 'w+')
f.write('uint16_t array[{}][{}]={{'.format(HEIGHT, WIDTH))
f.close()

im_original = cv2.imread(path, -1)
(h, w, d) = im_original.shape

if h != HEIGHT and w != WIDTH:
    im_original = resize(im_original)

b = im_original.reshape(-1, d)
result = np.zeros(len(b))
for i, triplet in enumerate(b):
    result[i] = rgb_hex565(triplet[2], triplet[1], triplet[0])

with open(output, 'ab') as f:
    np.savetxt(f, np.array(result), newline=',', fmt='%d')

# format ending > remove last character(comma) and add '};'
with open(output, 'rb+') as filehandle:
    filehandle.seek(-1, os.SEEK_END)
    filehandle.truncate()

with open(output, 'ab') as f:
    f.write(b'};')
