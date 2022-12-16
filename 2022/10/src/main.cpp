#include <iostream>
#include <vector>
#include <string>
#include <fstream>
#include <unordered_map>
#include <set>

using namespace std;

set<string> visited;

int main(int argc, char **argv)
{
    string filename = argv[1];
    vector<string> instructions;

    ifstream file(filename);
    if (file.is_open())
    {
        string line;

        while (getline(file, line))
        {
            instructions.push_back(line);
        }
        file.close();
    }

    int x = 1;
    int cycle = 1;
    int i = 0;

    struct instruction
    {
        int val;
        int cycle;
    };

    vector<instruction> executing;

    int sum = 0;

    struct point
    {
        int x;
        int y;
    };

    point head = {0, 0};

    // 6 rows and 40 columns of " "
    vector<vector<string>> output = {
        {" ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " "},
        {" ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " "},
        {" ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " "},
        {" ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " "},
        {" ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " "},
        {" ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " "},
    };

    while (cycle <= 240)
    {

        if (executing.size() == 0)
        {
            string instruction = instructions[i];
            i++;

            if (instruction == "noop")
            {
                executing.push_back({0, 1});
            }
            else
            {
                int val = stoi(instruction.substr(5));
                executing.push_back({val, 2});
            }
        }

        if (cycle == 20)
        {
            cout << "x: " << x << endl;
            int strength = x * 20;
            cout << "strength: " << strength << endl;
            sum = sum + strength;
        }
        else if (cycle == 60)
        {
            cout << "x: " << x << endl;
            int strength = x * 60;
            cout << "strength: " << strength << endl;
            sum = sum + strength;
        }
        else if (cycle == 100)
        {
            cout << "x: " << x << endl;
            int strength = x * 100;
            cout << "strength: " << strength << endl;
            sum = sum + strength;
        }
        else if (cycle == 140)
        {
            cout << "x: " << x << endl;
            int strength = x * 140;
            cout << "strength: " << strength << endl;
            sum = sum + strength;
        }
        else if (cycle == 180)
        {
            cout << "x: " << x << endl;
            int strength = x * 180;
            cout << "strength: " << strength << endl;
            sum = sum + strength;
        }
        else if (cycle == 220)
        {
            cout << "x: " << x << endl;
            int strength = x * 220;
            cout << "strength: " << strength << endl;
            sum = sum + strength;
        }

        if (head.x == x || head.x == x + 1 || head.x == x - 1)
        {
            output[head.y][head.x] = "#";
        }

        for (int j = 0; j < executing.size(); j++)
        {
            executing[j].cycle--;
            if (executing[j].cycle == 0)
            {
                x += executing[j].val;
                executing.erase(executing.begin() + j);
            }
        }

        cycle++;
        head.x++;
        if (head.x == 40)
        {
            head.x = 0;
            head.y++;
        }
    }

    cout << "sum: " << sum << endl;

    for (int i = 0; i < output.size(); i++)
    {
        for (int j = 0; j < output[i].size(); j++)
        {
            cout << output[i][j];
        }
        cout << endl;
    }
}
