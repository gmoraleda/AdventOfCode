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

        while (std::getline(file, line))
        {
            std::vector<string> marker;

            for (int i = 0; i < line.length(); i++)
            {
                string e = line.substr(i, 1);

                if (std::find(marker.begin(), marker.end(), e) != marker.end())
                {

                    while (marker.size() > 0 && std::find(marker.begin(), marker.end(), e) != marker.end())
                    {
                        marker.erase(marker.begin());
                    }
                    marker.push_back(e);
                }
                else
                {
                    marker.push_back(e);
                }

                // Part I
                // if (marker.size() == 4)
                // Part II
                if (marker.size() == 14)
                {
                    cout << "Index: " << i + 1 << endl;
                    break;
                }
            }
        }
        file.close();
    }
}
