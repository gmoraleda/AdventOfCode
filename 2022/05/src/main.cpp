
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

    std::vector<string> lines;
    std::ifstream file(filename);
    if (file.is_open())
    {
        std::string line;
        while (std::getline(file, line))
        {
            lines.push_back(line);
        }
    }

    file.close();

    // Split the lines into 2 sections
    std::vector<std::string> section1;
    std::vector<std::string> section2;

    bool section1_done = false;
    for (int i = 0; i < lines.size(); i++)
    {
        if (lines[i] == "")
        {
            section1_done = true;
            continue;
        }

        if (!section1_done)
        {
            section1.push_back(lines[i]);
        }
        else
        {
            section2.push_back(lines[i]);
        }
    }

    // Get number of crates. Section 1 last line
    string crates = section1[section1.size() - 1];

    // Trim whitespace
    crates.erase(std::remove(crates.begin(), crates.end(), ' '), crates.end());

    int num_crates = crates[crates.size() - 1] - '0';

    std::vector<std::vector<string>> crates_vec;
    for (int i = 0; i < num_crates; i++)
    {
        std::vector<string> crate;
        crates_vec.push_back(crate);
    }

    for (int i = 0; i < section1.size() - 1; i++)
    {
        string line = section1[i];

        int cursor = 0;
        int current_crate = 0;
        for (int j = 0; j < line.size(); j++)
        {
            cursor++;

            if (cursor == 3)
            {
                current_crate++;
                cursor = 0;
                j++;
                continue;
            }

            if (line[j] == ' ' || line[j] == '[' || line[j] == ']')
            {
                continue;
            }

            // Add the crate to the correct crate
            crates_vec[current_crate].push_back(std::string(1, line[j]));
        }
    }

    // Reverse the crates
    for (int i = 0; i < crates_vec.size(); i++)
    {
        std::reverse(crates_vec[i].begin(), crates_vec[i].end());
    }

    // Get instructions
    for (int i = 0; i < section2.size(); i++)
    {
        string line = section2[i];

        // Remove "move"
        line.erase(0, 5);

        // Split on "from"
        std::vector<std::string> parts;
        std::string delimiter = " from ";

        size_t pos = 0;
        std::string token;
        while ((pos = line.find(delimiter)) != std::string::npos)
        {
            token = line.substr(0, pos);
            // From found, remove from line
            line.erase(0, pos + delimiter.length());
            parts.push_back(token);

            // Find "to"
            delimiter = " to ";
            pos = line.find(delimiter);
            token = line.substr(0, pos);

            // To found, remove from line
            line.erase(0, pos + delimiter.length());
            parts.push_back(token);

            // Add the rest of the line
            parts.push_back(line);
        }

        int num_crates_to_move = stoi(parts[0]);
        int from_crate = stoi(parts[1]);
        int to_crate = stoi(parts[2]);

        // Move the crates
        // Part I
        // for (int j = 0; j < num_crates_to_move; j++)
        // {
        //     crates_vec[to_crate - 1].push_back(crates_vec[from_crate - 1].back());
        //     crates_vec[from_crate - 1].pop_back();
        // }

        // Part II

        std::vector<string> temp_crate;

        for (int j = 0; j < num_crates_to_move; j++)
        {
            // Place crates in temp crate
            temp_crate.push_back(crates_vec[from_crate - 1].back());
            crates_vec[from_crate - 1].pop_back();
        }

        // Reverse temp crate
        std::reverse(temp_crate.begin(), temp_crate.end());

        // Add temp crate to destination
        for (int j = 0; j < temp_crate.size(); j++)
        {
            crates_vec[to_crate - 1].push_back(temp_crate[j]);
        }
    }

    // Get last element of each crate
    std::vector<string> last_elements;
    for (int i = 0; i < crates_vec.size(); i++)
    {
        last_elements.push_back(crates_vec[i].back());
    }

    // Print the last elements
    for (int i = 0; i < last_elements.size(); i++)
    {
        std::cout << last_elements[i];
    }

    std::cout << std::endl;
}
