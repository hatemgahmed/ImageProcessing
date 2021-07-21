import cv2
import numpy as np
import math

# reading image as array
image = cv2.imread('mandrill.jpg')
# converting BGR image to YCbCr and spliting
imgYCC = cv2.cvtColor(image, cv2.COLOR_BGR2YCR_CB)
y, cr, cb = cv2.split(imgYCC)
# show image
# cv2.imshow('RGB', image)
# cv2.imshow('YCbCr', imgYCC)
#               row                 col
# print("Image Size:"+str(len(image))+"x"+str(len(image[0])))
# cv2.imshow('Y', y)

# cv2.imshow('Cr', cr)
# Sampling Cr
crCopy = []
# looping on the cr
for i in range(0, len(cr)):
    row = []
    for j in range(0, len(cr[i]), 2):
        # Copying each column after the other
        row.append(cr[i][j])
    crCopy.append(row)
# converting the 2d list back to a 2d array
cr = np.array(crCopy)
# print("New Resolution of Cr & Cb:"+str(len(cr[0]))+"x"+str(len(cr)))
# cv2.imshow('NewCr', cr)

# cv2.imshow('Cb', cb)
# Sampling Cb

cbCopy = []
# looping on the cb
for i in range(0, len(cb)):
    row = []
    for j in range(0, len(cb[i]), 2):
        # Copying each column after the other
        row.append(cb[i][j])
    cbCopy.append(row)
# converting the 2d list back to a 2d array
cb = np.array(cbCopy)
# cv2.imshow('NewCb', cb)

# cv2.imwrite("yNew.jpg", y)
# cv2.imwrite("crNew.jpg", cr)
# cv2.imwrite("cbNew.jpg", cb)

# Question 2


def makeDivisibleBy8(channel):
    # getting the next number divisible by 8
    newWidth = (len(channel)//8)*8 + 8 if len(channel) % 8 > 0 else 0
    newLength = (len(channel[0])//8)*8 + 8 if len(channel) % 8 > 0 else 0
    # initializing the array to contain 0's, so when the array is filled,
    # 0's will be padded
    newChannel = np.zeros((newWidth, newLength))
    for i in range(0, len(channel)):
        for j in range(0, len(channel[0])):
            newChannel[i][j] = channel[i][j]
    return newChannel


def undersampling8x8(channel):
    channel = makeDivisibleBy8(channel)
    # newWidth = len(channel)//8
    # newLength = len(channel[0])//8
    # newChannel = np.zeros((newWidth, newLength))
    newChannel = []
    # The aim is to have a 2d array containing an 8x8 block in each cell (4d array)
    # each 8 rows
    for i in range(0, len(channel), 8):
        row = []
        # each 8 cols
        for j in range(0, len(channel[0]), 8):
            # The next loops can be concluded in this pseudo instruction
            # newChannel[i//8][j//8] = channel[i:i+8][j:j+8]

            # initializing the block
            block = []
            for k in range(i, i+8):
                # initializing a row in this block
                blockRow = []
                for l in range(j, j+8):
                    # putting 8 elements in the row
                    blockRow.append(channel[k][l])
                # putting 8 rows in the block
                block.append(blockRow)
            # putting the 8x8 block as a cell in a row of the bigger array
            row.append(block)
        # putting this row in the Array
        newChannel.append(row)
    return newChannel


newY = undersampling8x8(y)
newCr = undersampling8x8(cr)
newCb = undersampling8x8(cb)

# print(newY[0][0])
# print(newY[1][1])


# start of milestone 1

# 3

def alpha(n):
    if(n == 0):
        return math.sqrt(1/8)
    else:
        return math.sqrt(2/8)


def cosTransformBlock(EightbyEightBlock):
    #getting width and height of 8x8 block
    width,height=EightbyEightBlock.shape[0],EightbyEightBlock.shape[1]
    #initializing new matrix with same dimensions as 8x8 block    
    #dct_mat=np.zeros((width,height))
    dct_mat=np.zeros((8,8))
    test=np.asarray(EightbyEightBlock)
    #print(EightbyEightBlock.shape[1])
    #looping over 8x8 block, calculating alpha and dct values for each pixel
    for i in range(0, test.shape[0]):
        for j in range(0,test.shape[1]):
            if i==0:
                alpha=math.sqrt(1/width)
            else:
                alpha=math.sqrt(2/width)
            dctValue=alpha*(math.cos((((2*j)+1)*math.pi*i) / (2*width) ))
            
            #inserting each dct value into dct matrix             
            dct_mat[i][j]=dctValue
        #multiplying the dct matrix by the 8x8 block

    dctAnswer=test.dot(dct_mat.transpose())
    dctStep1 = dct_mat.dot(dctAnswer)
        #multiplying the result by the transpose of the dct matrix 


    return dctStep1

def cosTransform(channel):
    out = []
    for i in channel:
        row = []
        for j in i:
            # block = []
            # Perform Cos Transform on Each block
            # for u in range(0, 8):
            #     blockRow = []
            #     for v in range(0, 8):

            #         # now calculating CT for each cell in the block
            #         cell = 0
            #         for x in range(0, 8):
            #             for y in range(0, 8):
            #                 cell += j[x][y]*math.cos(
            #                     (2*x+1)*math.pi*u/(2*8))*math.cos(
            #                         (2*y+1)*math.pi*v/(2*8))
            #         cell *= alpha(u)*alpha(v)

            #         blockRow.append(cell)
            #     block.append(blockRow)
            block=cosTransformBlock(np.array(j))
            row.append(block)
        out.append(row)
    return out

# 4 Quantization
quantizationMatrix = [
    [16, 11, 10, 16, 24, 40, 51, 61],
    [12, 12, 14, 19, 26, 58, 60, 55],
    [14, 13, 16, 24, 40, 57, 69, 56],
    [14, 17, 22, 29, 51, 87, 80, 62],
    [18, 22, 37, 56, 68, 109, 103, 77],
    [24, 35, 55, 64, 81, 104, 113, 92],
    [49, 64, 78, 87, 103, 121, 120, 101],
    [72, 92, 95, 98, 112, 100, 103, 99]
]


def quantize8x8(channel, quantizationMatrix):
    for i in channel:
        for j in i:
            for k in range(0, 8):
                for l in range(0, 8):
                    j[k][l] = round(((j[k][l]) / quantizationMatrix[k][l]))
    return channel


ctY = cosTransform(newY)
ctY = quantize8x8(ctY, quantizationMatrix)
ctCr = cosTransform(newCr)
ctCr = quantize8x8(ctCr, quantizationMatrix)
ctCb = cosTransform(newCb)
ctCb = quantize8x8(ctCb, quantizationMatrix)

def merge(channel1,channel2,channel3):
    return imgYCC

# fof = open("DCTY.txt", "w+")
# for i in ctY:
#     for j in i:
#         fof.write(str(j)+"\n")
# fof.close()


# Ass2

# ctCr,ctCb,ctY

# inverseQuantization


def getDimentions(channel):
    return str(len(channel))+"x"+str(len(channel[0]))


def inverseQuantize8x8(quantizedChannel, quantizationMatrix):
    for i in quantizedChannel:
        for j in i:
            for k in range(0, 8):
                for l in range(0, 8):
                    j[k][l] = (j[k][l]) * quantizationMatrix[k][l]
    return quantizedChannel


ctCb = inverseQuantize8x8(ctCb, quantizationMatrix)
ctCr = inverseQuantize8x8(ctCr, quantizationMatrix)
ctY = inverseQuantize8x8(ctY, quantizationMatrix)
# IDCT
print("inverseQuantize")
print(ctCr[0][0])
print(ctY[0][0])
print("\n")



def idct1D(vector):
    output = []
    for i in range(len(vector)):
        sum = 0
        for j in range(len(vector)):
            sum += (math.sqrt(1/2) if j == 0 else 1) * \
                vector[j] * math.cos((2*math.pi * (j + 1)) /
                                     (2.0*len(vector)) * i)
        output.append(math.sqrt(2.0/len(vector)) * sum)
    return output


def transpose(matrix):
    output = []
    for i in range(len(matrix[0])):
        newRow = []
        for j in range(len(matrix)):
            newRow.append(matrix[j][i])
        output.append(newRow)
    return output


def inverseCosTransform(block):
    outputR = []
    output = []
    for i in range(len(block)):
        outputR.append(idct1D(block[i]) )  # Apply on Rows
    outputR = transpose(outputR)
    for i in range(len(outputR)):
        output.append(idct1D(outputR[i]) ) # Apply on Rows
    return transpose(output)

def inverseDCT(inverseQuantized8x8): 
    #getting width and height of 8x8 block
    width,height=inverseQuantized8x8.shape[0],inverseQuantized8x8.shape[1]
    #initializing new matrix with same dimensions as 8x8 block    
    #dct_mat=np.zeros((width,height))
    dct_mat=np.zeros((8,8))
    test=np.asarray(inverseQuantized8x8)
    #print(inverseQuantized8x8.shape[1])
    #looping over 8x8 block, calculating alpha and dct values for each pixel
    for i in range(0, test.shape[0]):
        for j in range(0,test.shape[1]):
            if i==0:
                alpha=math.sqrt(1/width)
            else:
                alpha=math.sqrt(2/width)
            dctValue=alpha*(math.cos((((2*j)+1)*math.pi*i) / (2*width) ))
            
            #inserting each dct value into dct matrix             
            dct_mat[i][j]=dctValue
        #multiplying the dct matrix by the 8x8 block

        dctAnswer=test.dot(dct_mat.transpose())
    dctStep1 = dct_mat.dot(dctAnswer)

    invDctStep1=test.dot(dct_mat)
    invDct = dct_mat.transpose().dot(invDctStep1)
        #multiplying the result by the transpose of the dct matrix 


    return invDct     

def recoverChannel(channel):
    output = []
    for row in channel:
        blockRow = [[], [], [], [], [], [], [], []]
        for block in row:
            idct = inverseDCT(block)
            # idct=block
            for i in range(0, len(idct)):  # each row in the block
                blockRow[i].extend(idct[i])

        for i in blockRow:  # Append each completed row
            output.append(i)

    return output


print(inverseDCT(ctY[0][0]))
print(inverseDCT(ctCr[0][0]))
# print(inverseCosTransform(ctCb[0][0]))

recoveredY = recoverChannel(ctY)
recoveredCr = recoverChannel(ctCr)
recoveredCb = recoverChannel(ctCb)

# upsampling


def upsample(channel):
    output = []
    for i in channel:
        row = []
        for j in i:  # Repeating the element twice
            row.append(j)
            row.append(j)
        output.append(row)
    return output


recoveredCr = upsample(recoveredCr)
recoveredCb = upsample(recoveredCb)


# Getting Y to have the same width as Cr and Cb
for i in range(len(recoveredCr)):
    while(len(recoveredY[i]) < len(recoveredCr[i])):
        recoveredY[i].append(0)

recoveredCr = np.asarray(recoveredCr, dtype=np.uint8)
recoveredCb = np.asarray(recoveredCb, dtype=np.uint8)
recoveredY = np.asarray(recoveredY, dtype=np.uint8)


# print(getDimentions(recoveredY))
# print(getDimentions(recoveredCb))
# print(getDimentions(recoveredCr))


# merging
merged_channels = cv2.merge((recoveredY, recoveredCr, recoveredCb))
# merged_channels=merge(recoveredY,recoveredCr,recoveredCb)

# Convert to RGB
final_image = cv2.cvtColor(merged_channels, cv2.COLOR_YCrCb2BGR)

# Write the img
cv2.imwrite("finalImg.jpg", final_image)

# display
cv2.imshow('Final Image', final_image)
# cv2.imshow('Upsampled Cr',recoveredCr)
# cv2.imshow('Y', recoveredY)


cv2.waitKey(0)
