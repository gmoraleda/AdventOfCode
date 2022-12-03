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
    }
}
