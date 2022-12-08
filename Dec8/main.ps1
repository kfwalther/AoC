<#
Dec 7 Python script
#>

class Forest {
    [Int[,]]$TreeGrid
    [uint]$rNum
    [uint]$cNum

    [Void] PopulateFromText([string[]]$forestTxt) {
        $this.rNum = $forestTxt.Length
        $this.cNum = $forestTxt[0].Length
        $this.TreeGrid = New-Object 'uint[,]' $this.rNum,$this.cNum
        # Populate the new grid using the text input.
        For ($r = 0; $r -lt $this.rNum; $r++) {
            For ($c = 0; $c -lt $this.cNum; $c++) {
                $this.TreeGrid[$r,$c] = [uint]::Parse($forestTxt[$r].ToCharArray()[$c])
            }
        }
    }

    # Check up, down, left, and right to determine current tree's visibility.
    [bool] DetermineVisibility([uint]$row, [uint]$col) {
        $upVis = $true
        $downVis = $true
        $rightVis = $true
        $leftVis = $true
        # Look in current row and column for taller trees.
        # Check down
        For ($r = $row + 1; $r -lt $this.rNum; $r++) {
            If ($this.TreeGrid[$row,$col] -le $this.TreeGrid[$r,$col]) {
                $downVis = $false
                break
            }
        }
        If ($downVis) {return $true}
        # Check up
        For ($r = $row - 1; $r -ge 0; $r--) {
            If ($this.TreeGrid[$row,$col] -le $this.TreeGrid[$r,$col]) {
                $upVis = $false
                break
            }
        }
        If ($upVis) {return $true}
        # Check right
        For ($c = $col + 1; $c -lt $this.cNum; $c++) {
            If ($this.TreeGrid[$row,$col] -le $this.TreeGrid[$row,$c]) {
                $rightVis = $false
                break
            }
        }
        If ($rightVis) {return $true}
        # Check left
        For ($c = $col - 1; $c -ge 0; $c--) {
            If ($this.TreeGrid[$row,$col] -le $this.TreeGrid[$row,$c]) {
                $leftVis = $false
                break
            }
        }
        If ($leftVis) {return $true}
        # Not visible in any direction.
    	return $false
    }

    # Count the number of visible trees in the forest.
    [uint] FindNumberVisibleTrees() {
        $totalVisible = 0;
        # Iterate thru entire forest.
        For ($r = 0; $r -lt $this.rNum; $r++) {
            For ($c = 0; $c -lt $this.cNum; $c++) {
                # If on an edge, definitely visible.
                If (($r -eq 0) -or ($c -eq 0) -or ($r -eq $this.rNum - 1) -or ($c -eq $this.cNum - 1)) {
                    $totalVisible++
                }
                # If inner tree, find visibility.
                ElseIf ($this.DetermineVisibility($r, $c)) {
                    $totalVisible++
                }
            }
        }
        return $totalVisible
    }

    # Calculate the scenic score for current tree.
    [uint] DetermineTreeScenicScore([uint]$row, [uint]$col) {
        $up = 0
        $down = 0
        $right = 0
        $left = 0
        # Look in all directions for taller trees.
        # Check down
        For ($r = $row + 1; $r -lt $this.rNum; $r++) {
            If ($this.TreeGrid[$row,$col] -le $this.TreeGrid[$r,$col]) {
                $down = $r - $row
                break
            }
        }
        If ($down -eq 0) {$down = $this.rNum - $row - 1}
        # Check up
        For ($r = $row - 1; $r -ge 0; $r--) {
            If ($this.TreeGrid[$row,$col] -le $this.TreeGrid[$r,$col]) {
                $up = $row - $r
                break
            }
        }
        If ($up -eq 0) {$up = $row}
        # Check right
        For ($c = $col + 1; $c -lt $this.cNum; $c++) {
            If ($this.TreeGrid[$row,$col] -le $this.TreeGrid[$row,$c]) {
                $right = $c - $col
                break
            }
        }
        If ($right -eq 0) {$right = $this.cNum - $col - 1}
        # Check left
        For ($c = $col - 1; $c -ge 0; $c--) {
            If ($this.TreeGrid[$row,$col] -le $this.TreeGrid[$row,$c]) {
                $left = $col - $c
                break
            }
        }
        If ($left -eq 0) {$left = $col}
        # Return the calculated scenic score
    	return ($up * $down * $right * $left)
    }

    # Find the max scenic score in the forest.
    [uint] FindMaxScenicScore() {
        $max = 0;
        # Iterate thru entire forest (skipping edges).
        For ($r = 1; $r -lt $this.rNum - 1; $r++) {
            For ($c = 1; $c -lt $this.cNum - 1; $c++) {
                $curScore = $this.DetermineTreeScenicScore($r, $c)
                # Update new max if necessary.
                If ($curScore -gt $max) {$max = $curScore}
            }
        }
        return $max
    }
}

# Read the input from file.
$forestTxt = Get-Content "$PSScriptRoot\input.txt"
# Create a new Forest object and populate the tree grid using the input text.
$forest = New-Object Forest
$forest.PopulateFromText($forestTxt)
# Find the number of visible trees in the forest.
Write-Host PartA: $forest.FindNumberVisibleTrees()
# Find the tree with the max scenic score.
Write-Host PartB: $forest.FindMaxScenicScore()
