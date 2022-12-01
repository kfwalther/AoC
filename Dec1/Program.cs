
public class TestExe {

    public static void Main(String[] args)
    {
        // Read the elf calorie input file.
        string inCals = File.ReadAllText(@"D:\workspace\AoC\Dec1\input1.txt");

        List<uint> totals = new List<uint>();
        uint curTotal = 0;
        // Iterate through each line of the input file.
        foreach (string line in inCals.Split(Environment.NewLine))
        {
            // If break is encountered, add current total to final list.
            if (string.IsNullOrEmpty(line))
            {
                // Add current total to list.
                totals.Add(curTotal);
                curTotal = 0;
            }
            else
            {
                // Add current item to current total.
                curTotal += uint.Parse(line);
            }
        }
        // Add the last total to the list.
        totals.Add(curTotal);

        // Order the calorie counts largest to smallest.
        var sorted = totals.OrderDescending().ToList();
        // This is part A (the largest calorie count)
        Console.WriteLine(sorted[0]);
        
        // This is part B (the sum of the 3 largest).
        Console.WriteLine(sorted[0] + sorted[1] + sorted[2]);
    }
}
