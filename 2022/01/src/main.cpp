#include <iostream>
#include <vector>
#include <string>
#include <fstream>

using namespace std;

int main(int argc, char **argv)
{
    string filename = argv[1];

    vector<int> counters;

    ifstream file(filename);
    if (file.is_open())
    {
        string line;
        counters.push_back(0);

        while (getline(file, line))
        {

            if (!line.empty())
            {
                int num = stoi(line);
                counters.back() += num;
            }
            else
            {
                counters.push_back(0);
            }
        }
        file.close();

        sort(counters.begin(), counters.end());

        // Part I
        cout << counters[counters.size() - 1] << endl;

        // Part II
        cout << counters[counters.size() - 1] + counters[counters.size() - 2] + counters[counters.size() - 3] << endl;
    }
}
