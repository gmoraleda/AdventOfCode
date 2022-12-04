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
        int sum = 0;

        while (std::getline(file, line))
        {
            string elf1 = line.substr(0, line.find(','));
            string elf2 = line.substr(line.find(',') + 1, line.length() - 1);

            string elf1_start = elf1.substr(0, elf1.find('-'));
            string elf1_end = elf1.substr(elf1.find('-') + 1, elf1.length() - 1);

            string elf2_start = elf2.substr(0, elf2.find('-'));
            string elf2_end = elf2.substr(elf2.find('-') + 1, elf2.length() - 1);

            int elf1_start_int = stoi(elf1_start);
            int elf1_end_int = stoi(elf1_end);

            std::vector<int> elf1_range;
            for (int i = elf1_start_int; i <= elf1_end_int; i++)
            {
                elf1_range.push_back(i);
            }

            int elf2_start_int = stoi(elf2_start);
            int elf2_end_int = stoi(elf2_end);

            std::vector<int> elf2_range;
            for (int i = elf2_start_int; i <= elf2_end_int; i++)
            {
                elf2_range.push_back(i);
            }

            std::set<int> elf1_set(elf1_range.begin(), elf1_range.end());
            std::set<int> elf2_set(elf2_range.begin(), elf2_range.end());

            std::vector<int> intersection;
            std::set_intersection(elf1_set.begin(), elf1_set.end(), elf2_set.begin(), elf2_set.end(), std::back_inserter(intersection));

            // Part I

            // if (intersection.size() == elf1_set.size() || intersection.size() == elf2_set.size())
            // {
            //     sum++;
            // }

            // Part II
            if (intersection.size() > 0)
            {
                sum++;
            }
        }
        std::cout << sum << std::endl;
    }
    file.close();
}
