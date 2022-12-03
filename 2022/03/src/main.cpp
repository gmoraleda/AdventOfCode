#include <iostream>
#include <vector>
#include <string>
#include <fstream>
#include <unordered_map>

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
            string compartment1 = line.substr(0, (line.length() / 2));
            string compartment2 = line.substr(line.length() / 2, line.length() - 1);

            std::sort(compartment1.begin(), compartment1.end());
            std::sort(compartment2.begin(), compartment2.end());

            std::string string_intersection;

            std::set_intersection(compartment1.begin(), compartment1.end(), compartment2.begin(), compartment2.end(), std::back_inserter(string_intersection));

            // std::cout << "string1 intersection string2: " << string_intersection[0] << std::endl;

            int value = string_intersection[0] - 96;
            if (value < 0)
            {
                value = string_intersection[0] - 38;
            }

            sum += value;
        }
        std::cout << sum << std::endl;
        file.close();

        sum = 0;

        std::ifstream file(filename);
        if (file.is_open())
        {

            // Part II

            std::string elf1;

            while (std::getline(file, elf1))
            {
                std::string elf2;
                std::string elf3;

                std::getline(file, elf2);
                std::getline(file, elf3);

                std::sort(elf1.begin(), elf1.end());
                std::sort(elf2.begin(), elf2.end());
                std::sort(elf3.begin(), elf3.end());

                std::string string_intersection1;
                std::string string_intersection2;
                std::string string_intersection3;

                // Intersection elf1 with elf2
                std::set_intersection(elf1.begin(), elf1.end(), elf2.begin(), elf2.end(), std::back_inserter(string_intersection1));
                std::set_intersection(elf1.begin(), elf1.end(), elf3.begin(), elf3.end(), std::back_inserter(string_intersection2));

                // Intersection intersection1 with intersection2
                std::set_intersection(string_intersection1.begin(), string_intersection1.end(), string_intersection2.begin(), string_intersection2.end(), std::back_inserter(string_intersection3));

                int value = string_intersection3[0] - 96;
                if (value < 0)
                {
                    value = string_intersection3[0] - 38;
                }

                sum += value;
            }

            std::cout << sum << std::endl;

            file.close();
        }
    }
}
