<#
.DESCRIPTION
Test PS script for Day 3- Kevin Walther
#>

# Define a function to find the intersection of the rucksack halves.
Function FindIntersection2 {
    param([string] $l, [string] $r)
    ForEach ($lc in $l.ToCharArray()) {
        ForEach ($rc in $r.ToCharArray()) {
            # Case-sensitive compare.
            if ($lc -ceq $rc) {
                $intersect = ($lc -cmatch "[A-Z]") ? [byte][char]$lc - 38 : [byte][char]$lc - 96
                $intersect
                return
            }
        }
    }
}

# Define a function to find the intersection of 3-rucksack sets.
Function FindIntersection3 {
    param([string] $first, [string] $second, [string] $third)
    ForEach ($f in $first.ToCharArray()) {
        ForEach ($s in $second.ToCharArray()) {
            # Case-sensitive compare.
            if ($f -ceq $s) {
                ForEach ($t in $third.ToCharArray()) {
                    if ($t -ceq $s) {
                        # Found 3-way intersection.
                        $intersect = ($t -cmatch "[A-Z]") ? [byte][char]$t - 38 : [byte][char]$t - 96
                        $intersect
                        return
                    }
                }
            }
        }
    }
}

# Read the input file contents.
$rucksackList = Get-Content "$PSScriptRoot\input.txt"
$totalPriorityA = 0
$totalPriorityB = 0

# Iterate thru each rucksack.
ForEach ($rucksack in $rucksackList) {
    $rLen = $rucksack.Length
    $left = $rucksack.Substring(0,$rLen/2)
    $right = $rucksack.Substring($rLen/2,$rLen/2)
    # Find the intersection of the two halves, and return its rank.
    $totalPriorityA += FindIntersection2 $left $right
}

# Iterate thru the rucksacks 3 at a time.
For ($i = 0; $i -lt $rucksackList.Length; $i += 3) {
    $totalPriorityB += FindIntersection3 $rucksackList[$i] $rucksackList[$i+1] $rucksackList[$i+2] 
}

# Print Part A and B results.
Write-Host "Part A: $totalPriorityA"
Write-Host "Part B: $totalPriorityB"

