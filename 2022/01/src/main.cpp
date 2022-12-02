#include <iostream>
#include <vector>
#include <string>
#include <fstream>

using namespace std;

int main(int argc, char **argv)
{
    string filename = argv[1];

    vector<int> counters;

    std::ifstream file(filename);
    if (file.is_open())
    {
        std::string line;
        counters.push_back(0);

        while (std::getline(file, line))
        {

            if (!line.empty())
            {
                int num = std::stoi(line);
                counters.back() += num;
            }
            else
            {
                counters.push_back(0);
            }
        }
        file.close();

        std::sort(counters.begin(), counters.end());

        // Part I
        std::cout << counters[counters.size() - 1] << std::endl;

        // Part II
        std::cout << counters[counters.size() - 1] + counters[counters.size() - 2] + counters[counters.size() - 3] << std::endl;
    }
}
