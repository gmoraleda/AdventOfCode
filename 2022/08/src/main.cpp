#include <iostream>
#include <vector>
#include <string>
#include <fstream>
#include <unordered_map>
#include <set>

using namespace std;

int main(int argc, char **argv)
{
    string filename = argv[1];

    std::ifstream file(filename);
    if (file.is_open())
    {
        std::string line;
        // Grid of numbers
        std::vector<std::vector<int>> grid;

        while (std::getline(file, line))
        {
            // For each number in the line, add it to the grid
            std::vector<int> row;
            for (int i = 0; i < line.length(); i++)
            {
                row.push_back(std::stoi(line.substr(i, 1)));
            }
            grid.push_back(row);
        }
        file.close();

        // // Print grid
        // for (int i = 0; i < grid.size(); i++)
        // {
        //     for (int j = 0; j < grid[i].size(); j++)
        //     {
        //         cout << grid[i][j] << " ";
        //     }
        //     cout << endl;
        // }

        // Part I
        int height = grid.size();
        int width = grid[0].size();
        int count = 0;

        for (int i = 0; i < height; i++)
        {
            for (int j = 0; j < width; j++)
            {
                // Check if it's in the edge
                if (i == 0 || i == height - 1 || j == 0 || j == width - 1)
                {
                    count++;
                }
                else
                {
                    // Check if there is a number from the left edge to the current number that is greater or equal than the current number
                    bool left = false;
                    for (int k = 0; k < j; k++)
                    {
                        if (grid[i][k] >= grid[i][j])
                        {
                            left = true;
                            break;
                        }
                    }

                    // Check if there is a number from the right edge to the current number that is greater or equal than the current number
                    bool right = false;
                    for (int k = j + 1; k < width; k++)
                    {
                        if (grid[i][k] >= grid[i][j])
                        {
                            right = true;
                            break;
                        }
                    }

                    // Check if there is a number from the top edge to the current number that is greater or equal than the current number
                    bool top = false;
                    for (int k = 0; k < i; k++)
                    {
                        if (grid[k][j] >= grid[i][j])
                        {
                            top = true;
                            break;
                        }
                    }

                    // Check if there is a number from the bottom edge to the current number that is greater or equal than the current number
                    bool bottom = false;
                    for (int k = i + 1; k < height; k++)
                    {
                        if (grid[k][j] >= grid[i][j])
                        {
                            bottom = true;
                            break;
                        }
                    }

                    if (!left || !right || !top || !bottom)
                    {
                        count++;
                    }
                }
            }
        }

        cout << "Count: " << count << endl;

        // Part II
        // For each number in the grid, starting at the current number, check if the number on the left is smaller. If it is, increase the left count and continue with the next number. If it is greater or equal, increase the counter and stop. Repeat for the right, top and bottom.

        int highestValue = 0;
        for (int i = 0; i < height; i++)
        {

            for (int j = 0; j < width; j++)
            {
                int leftCount = 0;
                int rightCount = 0;
                int topCount = 0;
                int bottomCount = 0;

                if (i == 0 || i == height - 1 || j == 0 || j == width - 1)
                {
                    continue;
                }

                for (int k = j - 1; k >= 0; k--)
                {

                    leftCount++;

                    if (grid[i][k] >= grid[i][j])
                    {
                        break;
                    }
                }

                for (int k = j + 1; k < width; k++)
                {
                    rightCount++;

                    if (grid[i][k] >= grid[i][j])
                    {
                        break;
                    }
                }

                for (int k = i - 1; k >= 0; k--)
                {
                    topCount++;

                    if (grid[k][j] >= grid[i][j])
                    {
                        break;
                    }
                }

                for (int k = i + 1; k < height; k++)
                {
                    bottomCount++;

                    if (grid[k][j] >= grid[i][j])
                    {
                        break;
                    }
                }

                int value = 1;
                // Multiply values among them if they are not 0
                if (leftCount != 0)
                {
                    value *= leftCount;
                }
                if (rightCount != 0)
                {
                    value *= rightCount;
                }
                if (topCount != 0)
                {
                    value *= topCount;
                }
                if (bottomCount != 0)
                {
                    value *= bottomCount;
                }

                if (value > highestValue)
                {
                    highestValue = value;
                }
            }
        }

        cout << "Highest value: " << highestValue << endl;
    }
}
