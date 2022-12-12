<#
Dec 9 Powershell script
#>

# A helper function to find the distance between two points.
Function CalcDistance([System.Drawing.Point]$p1, [System.Drawing.Point]$p2) {
    return [Math]::Sqrt([Math]::Pow(($p2.X - $p1.X), 2) + [Math]::Pow(($p2.Y - $p1.Y), 2));
}

Function UpdateNextRopePosition([ref][System.Drawing.Point]$cur, [ref][System.Drawing.Point]$next) {
    # Calculate tail distance from head to determine if position update is required.
    if ([Math]::Abs($next.value.X - $cur.value.X) -gt 1) {
        # If distance is greater than 2, diagonal move required. Move tail y-coord to same y-coord as head.
        if ((CalcDistance $cur.value $next.value) -gt 2.0) { $next.value.Y = $cur.value.Y }
        # Move tail x-coord one closer to head x-coord.
        $next.value.X = ($next.value.X + $cur.value.X) / 2
        return $true
    }
    elseif ([Math]::Abs($next.value.Y - $cur.value.Y) -gt 1) {
        # If distance is greater than 2, diagonal move required. Move tail x-coord to same x-coord as head.
        if ((CalcDistance $cur.value $next.value) -gt 2.0) { $next.value.X = $cur.value.X }
        # Move tail y-coord one closer to head y-coord.
        $next.value.Y = ($next.value.Y + $cur.value.Y) / 2
        return $true
    }
    return $false
}

# Read the input from file.
$inputMoves = Get-Content "$PSScriptRoot\input.txt"

# Create the head point, and list of tail points.
$head = [System.Drawing.Point]::new(0,0)
$tailList = @()
for ($i = 0; $i -lt 9; $i++) { $tailList += [System.Drawing.Point]::new(0,0) }

$uniquePositions = @{ "0,0" = 1 }
$uniquePositionsR9 = @{ "0,0" = 1 }

# Iterate thru each rope move.
ForEach ($move in $inputMoves) {
    $dir, $num = $move.Split()
    # Increment the rope head thru the move one position at a time. 
    For ($i = 0; $i -lt $num; $i++) {
        # Move the head position.
        if ($dir -eq "U") { $head.Y++ }
        elseif ($dir -eq "D") { $head.Y-- }
        elseif ($dir -eq "R") { $head.X++ }
        elseif ($dir -eq "L") { $head.X-- }

        $tailMoved = UpdateNextRopePosition ([ref]$head) ([ref]($tailList[0]))
        # Update unique tail positions list, if necessary.
        if ($tailMoved) {
            if (!$uniquePositions.ContainsKey("$($tailList[0].X),$($tailList[0].Y)")) {
                $uniquePositions.Add("$($tailList[0].X),$($tailList[0].Y)", 1)
            } 
            else {
                $uniquePositions["$($tailList[0].X),$($tailList[0].Y)"]++
            }
        }
        $j = 0
        # Update remaining tails.
        while ($j -lt 8 -and $tailMoved) {
            $tailMoved = UpdateNextRopePosition ([ref]($tailList[$j])) ([ref]($tailList[$j+1]))
            $j++
        }
        # Update unique tail positions list, if necessary.
        if ($tailMoved) {
            if (!$uniquePositionsR9.ContainsKey("$($tailList[8].X),$($tailList[8].Y)")) {
                $uniquePositionsR9.Add("$($tailList[8].X),$($tailList[8].Y)", 1)
            } 
            else {
                $uniquePositionsR9["$($tailList[8].X),$($tailList[8].Y)"]++
            }
        }
    }
}
# Print results (Part B is close, but incorrect).
Write-Host PartA: $uniquePositions.Count
Write-Host PartB: $uniquePositionsR9.Count
