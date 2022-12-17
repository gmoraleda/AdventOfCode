#include <iostream>
#include <vector>
#include <string>
#include <fstream>
#include <unordered_map>

using namespace std;

int main(int argc, char **argv)
{
    string filename = argv[1];

    ifstream file(filename);
    if (file.is_open())
    {
        string line;
        int sum = 0;

        while (getline(file, line))
        {
            string compartment1 = line.substr(0, (line.length() / 2));
            string compartment2 = line.substr(line.length() / 2, line.length() - 1);

            sort(compartment1.begin(), compartment1.end());
            sort(compartment2.begin(), compartment2.end());

            string string_intersection;

            set_intersection(compartment1.begin(), compartment1.end(), compartment2.begin(), compartment2.end(), back_inserter(string_intersection));

            // cout << "string1 intersection string2: " << string_intersection[0] << endl;

            int value = string_intersection[0] - 96;
            if (value < 0)
            {
                value = string_intersection[0] - 38;
            }

            sum += value;
        }
        cout << sum << endl;
        file.close();

        sum = 0;

        ifstream file(filename);
        if (file.is_open())
        {

            // Part II

            string elf1;

            while (getline(file, elf1))
            {
                string elf2;
                string elf3;

                getline(file, elf2);
                getline(file, elf3);

                sort(elf1.begin(), elf1.end());
                sort(elf2.begin(), elf2.end());
                sort(elf3.begin(), elf3.end());

                string string_intersection1;
                string string_intersection2;
                string string_intersection3;

                // Intersection elf1 with elf2
                set_intersection(elf1.begin(), elf1.end(), elf2.begin(), elf2.end(), back_inserter(string_intersection1));
                set_intersection(elf1.begin(), elf1.end(), elf3.begin(), elf3.end(), back_inserter(string_intersection2));

                // Intersection intersection1 with intersection2
                set_intersection(string_intersection1.begin(), string_intersection1.end(), string_intersection2.begin(), string_intersection2.end(), back_inserter(string_intersection3));

                int value = string_intersection3[0] - 96;
                if (value < 0)
                {
                    value = string_intersection3[0] - 38;
                }

                sum += value;
            }

            cout << sum << endl;

            file.close();
        }
    }
}
