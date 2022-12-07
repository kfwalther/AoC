'''
Dec 7 Python script
'''

import bisect

# Open file for reading.
with open('input.txt', 'r') as f:
    totals100k = 0
    curDirTotal = 0
    sizeStack = []
    dirSizeList = []
    inStr = f.readlines()
    for line in inStr:
        # If we navigate thru a directory...
        if line.startswith('$ cd'):
            # Navigated to parent, check child directory size, and add it to parent.
            if '..' in line:
                if sizeStack[-1] < 100000:
                    totals100k += sizeStack[-1]
                # Add the child dir's total to parent dir total, then pop the child. They're out!
                dirSizeList.append(sizeStack[-1])
                if (len(sizeStack) > 1):
                    sizeStack[-2] += sizeStack[-1]
                sizeStack.pop()
            else:
                # Add current dir to back of list (with size of 0).
                sizeStack.append(0)
        elif line[0].isdigit():
            # Found a file. Grab it's size and add it to the current dirs total.
            sizeStack[-1] += int(line.split()[0])

    # Navigate back to root of directory tree to process any remaining dirs.
    while (len(sizeStack) > 0):
        if sizeStack[-1] < 100000:
            totals100k += sizeStack[-1]
        # Add the child dir's total to parent dir total, then pop the child. They're out!
        dirSizeList.append(sizeStack[-1])
        if (len(sizeStack) > 1):
            sizeStack[-2] += sizeStack[-1]
        sizeStack.pop()
    
    # Sort the directory sizes, then find the first that, if deleted, yields 30M of free space.
    dirSizeList.sort()
    neededFreeSpace = 30000000 - (70000000 - dirSizeList[-1])
    targetIdx = bisect.bisect_left(dirSizeList, neededFreeSpace)
    targetSize = 0 if targetIdx == len(dirSizeList) else dirSizeList[targetIdx]

    print('Part A: ' + str(totals100k))
    print('Part B: ' + str(targetSize))
