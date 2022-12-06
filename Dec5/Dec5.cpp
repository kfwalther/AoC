// Dec5.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>
#include <deque>
#include <memory>
#include <algorithm>

/**
 * @brief A structure to house the crate stack data.
 **/
struct CrateStacks {
    // Alias our data structures for brevity.
    typedef std::deque<std::string> CrateStackType;
    typedef std::vector<CrateStackType> CrateStackListType;

    CrateStacks() {
        stacks = CrateStackListType(9);
        stacks[0] = { "D", "M", "S", "Z", "R", "F", "W", "N"};
        stacks[1] = { "W", "P", "Q", "G", "S"};
        stacks[2] = { "W", "R", "V", "Q", "F", "N", "J", "C"};
        stacks[3] = { "F", "Z", "P", "C", "G", "D", "L"};
        stacks[4] = { "T", "P", "S" };
        stacks[5] = { "H", "D", "F", "W", "R", "L"};
        stacks[6] = { "Z", "N", "D", "C"};
        stacks[7] = { "W", "N", "R", "F", "V", "S", "J", "Q"};
        stacks[8] = { "R", "M", "S", "G", "Z", "W", "V"};
    }

    std::string const showStackTops() const {
        std::stringstream tops;
        for (std::size_t i = 0; i < stacks.size(); i++) {
            tops << stacks[i].back();
        }
        return tops.str();
    }

    CrateStackListType stacks;
};

// Main entry point to the program.
int main()
{
    std::string curLine;
    std::ifstream ifs("D:\\workspace\\AoC\\Dec5\\input.txt");
    std::vector<std::string> stackOps;
    bool initialized = false;
    std::unique_ptr<CrateStacks> csA = std::make_unique<CrateStacks>();
    std::unique_ptr<CrateStacks> csB = std::make_unique<CrateStacks>();
    // Open the input file for reading.
    if (ifs.is_open()) {
        try {
            // Iterate thru each line.
            while (std::getline(ifs, curLine)) {
                // If un-init'd, fall in here.
                if (!initialized && std::all_of(curLine.begin(), curLine.end(), std::isspace)) {
                    initialized = true;
                }
                else if (initialized) {
                    // If initialized, read the rest of the file to digest each crate move action.
                    std::stringstream iss(curLine);
                    std::vector<std::string> curOp{ std::istream_iterator<std::string>{iss},
                            std::istream_iterator<std::string>{} };
                    std::size_t sourceIdx = std::stoull(curOp[3]) - 1;
                    std::size_t destIdx = std::stoull(curOp[5]) - 1;
                    std::size_t num = std::stoull(curOp[1]);
                    // Perform the PartA moves necessary for this operation.
                    for (std::size_t i = 0; i < num; i++) {
                        // Take top item in source stack and add it to top of dest stack.
                        csA->stacks[destIdx].push_back(csA->stacks[sourceIdx].back());
                        // Pop the item off the source stack.
                        csA->stacks[sourceIdx].pop_back();
                    }
                    // Perform the PartB moves (move subset of source stack to dest stack in bulk).
                    csB->stacks[destIdx].insert(csB->stacks[destIdx].end(),
                        std::make_move_iterator(csB->stacks[sourceIdx].end() - num),
                        std::make_move_iterator(csB->stacks[sourceIdx].end()));
                    csB->stacks[sourceIdx].erase(csB->stacks[sourceIdx].end() - num, csB->stacks[sourceIdx].end());
                }
            }
            // When done processing input operations, print the crates at the top of each stack.
            std::cout << "Part A: " << csA->showStackTops() << std::endl;
            std::cout << "Part B: " << csB->showStackTops() << std::endl;
        }
        catch (std::exception ex) {
            std::cerr << "Exception occurred processing input: " << ex.what() << std::endl;
        }
        std::cout << "Successful Completion!\n";
        return EXIT_SUCCESS;
    }
    else {
        std::cout << "Could not open input file!\n";
        return EXIT_FAILURE;
    }
}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
