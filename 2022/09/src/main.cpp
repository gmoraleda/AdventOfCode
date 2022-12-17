#include <iostream>
#include <vector>
#include <string>
#include <fstream>
#include <unordered_map>
#include <set>

using namespace std;

struct point
{
    int x;
    int y;
};

set<string> visited;

void move_points(point &head, point &tail, char direction, int steps)
{
    for (int i = 0; i < steps; i++)
    {
        switch (direction)
        {
        case 'U':
            head.y++;
            break;
        case 'D':
            head.y--;
            break;
        case 'L':
            head.x--;
            break;
        case 'R':
            head.x++;
            break;
        }

        while (abs(head.x - tail.x) > 1 || abs(head.y - tail.y) > 1)
        {
            if (head.x > tail.x)
            {
                tail.x++;
            }
            if (head.x < tail.x)
            {
                tail.x--;
            }
            if (head.y > tail.y)
            {
                tail.y++;
            }
            if (head.y < tail.y)
            {
                tail.y--;
            }

            visited.insert("(" + to_string(tail.x) + ", " + to_string(tail.y) + ")");
            cout << "(" << tail.x << ", " << tail.y << ")" << endl;
        }
    }
}

int main(int argc, char **argv)
{
    string filename = argv[1];

    ifstream file(filename);
    if (file.is_open())
    {
        string line;
        vector<string> instructions;

        while (getline(file, line))
        {
            instructions.push_back(line);
        }

        point head = {0, 0};
        point tail = {0, 0};

        visited.insert("(" + to_string(tail.x) + ", " + to_string(tail.y) + ")");

        for (int i = 0; i < instructions.size(); i++)
        {
            string instruction = instructions[i];

            char direction = instruction[0];
            int steps = stoi(instruction.substr(2));

            move_points(head, tail, direction, steps);
        }
        file.close();
    }

    // Print the set
    // for (auto it = visited.begin(); it != visited.end(); it++)
    // {
    //     cout << *it << endl;
    // }

    // Print set count
    cout << visited.size() << endl;
}
