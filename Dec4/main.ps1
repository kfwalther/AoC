<#
.DESCRIPTION
Test PS script for Day 4 - Kevin Walther
Find the number of pairs in which one range fully contains the other.
#>

# Determine if one range fully envelopes the other range.
Function HasFullRangeOverlap {
    param([string] $l, [string] $r)
    # Get values from pairs.
    $ll, $lr = $l.Split('-')
    $rl, $rr = $r.Split('-')
    # Get range sizes.
    $lSize = [int]$lr - [int]$ll
    $rSize = [int]$rr - [int]$rl
    # Figure out if left or right is larger range.
    if ($lSize -gt $rSize) {
        # Check right range fits fully within left range.
        if (([int]$ll -le [int]$rl) -AND ([int]$lr -ge [int]$rr)) {
            return 1
        }
    } elseif ($rSize -gt $lSize) {
        # Check left range fits fully within right range.
        if (([int]$rl -le [int]$ll) -AND ([int]$rr -ge [int]$lr)) {
            return 1
        }
    } else {
        # Ranges are equal size.
        if ([int]$ll -eq [int]$rl) {
            return 1
        }
    }
    return 0
}

# Determine if the ranges have any overlap.
Function HasAnyOverlap {
    param([string] $l, [string] $r)
    # Get values from pairs.
    $ll, $lr = $l.Split('-')
    $rl, $rr = $r.Split('-')
    # Check for any overlap.
    if ((([int]$ll -lt [int]$rl) -AND ([int]$lr -lt [int]$rl)) -OR 
            (([int]$ll -gt [int]$rr) -AND ([int]$lr -gt [int]$rr))) {
        return 0
    }
    return 1
}

# Read the input file contents.
$pairList = Get-Content "$PSScriptRoot\input.txt"
$totalPairsA = 0
$totalPairsB = 0

# Iterate thru each rucksack.
ForEach ($pair in $pairList) {
    # Get each value in the pair.
    $l, $r = $pair.Split(',')
    $totalPairsA += HasFullRangeOverlap $l $r
    $totalPairsB += HasAnyOverlap $l $r
}

# Print Part A and B results.
Write-Host "Part A: $totalPairsA"
Write-Host "Part B: $totalPairsB"
