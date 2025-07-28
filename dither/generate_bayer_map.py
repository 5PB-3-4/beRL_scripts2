import numpy as np
import cv2

dither_map = np.zeros((1,1), np.float32)
dither_map_N = 4

for N in range(dither_map_N):
    conc1 = np.hstack((4*dither_map  , 4.*dither_map+2))
    conc2 = np.hstack((4*dither_map+3, 4.*dither_map+1))
    dither_map = np.vstack((conc1, conc2))

    im_map = dither_map.astype(np.uint8)
    im_map = cv2.cvtColor(im_map, cv2.COLOR_GRAY2BGR)

cv2.imwrite(f"bayer_map_{2**dither_map_N}x{2**dither_map_N}.png", im_map)
