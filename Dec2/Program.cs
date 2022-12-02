
using System;
using System.Xml.Schema;

public class TestExe {

    private static uint DetermineRoundScoreA(string opp, string your)
    {
        switch (opp)
        {
            // Opponent Rock
            case "A":
                {
                    if (your == "X") return 1 + 3;
                    else if (your == "Y") return 2 + 6;
                    else if (your == "Z") return 3 + 0;
                    else return 0;
                }
            case "B":
                {
                    if (your == "X") return 1 + 0;
                    else if (your == "Y") return 2 + 3;
                    else if (your == "Z") return 3 + 6;
                    else return 0;
                }
            case "C":
                {
                    if (your == "X") return 1 + 6;
                    else if (your == "Y") return 2 + 0;
                    else if (your == "Z") return 3 + 3;
                    else return 0;
                }
            default:
                return 0;
        }
    }

    private static uint DetermineRoundScoreB(string opp, string your)
    {
        switch (opp)
        {
            // Opponent Rock
            case "A":
                {
                    if (your == "X") return 3 + 0;
                    else if (your == "Y") return 1 + 3;
                    else if (your == "Z") return 2 + 6;
                    else return 0;
                }
            case "B":
                {
                    if (your == "X") return 1 + 0;
                    else if (your == "Y") return 2 + 3;
                    else if (your == "Z") return 3 + 6;
                    else return 0;
                }
            case "C":
                {
                    if (your == "X") return 2 + 0;
                    else if (your == "Y") return 3 + 3;
                    else if (your == "Z") return 1 + 6;
                    else return 0;
                }
            default:
                return 0;
        }
    }

    public static void Main(string[] args)
    {
        // Read the input data.
        string inputTxt = File.ReadAllText(@"D:\workspace\AoC\Dec2\input.txt");

        uint totalScorePartA = 0;
        uint totalScorePartB = 0;
        // Iterate through each line of the input file.
        foreach (string line in inputTxt.Split(Environment.NewLine))
        {
            // Split the opponent and our shape.
            var curChoice = line.Split(' ');
            // Get the score of the current round.
            totalScorePartA += DetermineRoundScoreA(curChoice[0], curChoice[1]);
            totalScorePartB += DetermineRoundScoreB(curChoice[0], curChoice[1]);
        }
        Console.WriteLine("PartA: " + totalScorePartA);
        Console.WriteLine("PartB: " + totalScorePartB);
    }
}
