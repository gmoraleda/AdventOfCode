#include <iostream>
#include <vector>
#include <string>
#include <fstream>
#include <unordered_map>
#include <set>
#include <functional>

using namespace std;

struct monkey
{
    int number;
    vector<int> starting_items;
    function<long long(long long)> operation;
    int test;
    int throw_to_true;
    int throw_to_false;
    int inspect_count;
};

// function that takes

vector<monkey> monkeys;
vector<string> instructions;

int main(int argc, char **argv)
{
    string filename = argv[1];
    int rounds = stoi(argv[2]);
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

    // Monkey 0:
    //   Starting items: 79, 98
    //   Operation: new = old * 19
    //   Test: divisible by 23
    //     If true: throw to monkey 2
    //     If false: throw to monkey 3

    for (int i = 0; i < instructions.size(); i++)
    {
        string line = instructions[i];
        if (line.find("Monkey") != string::npos)
        {
            // Read monkey number
            int monkey_number = stoi(line.substr(7, 1));
            monkey m;
            m.number = monkey_number;
            m.inspect_count = 0;
            monkeys.push_back(m);
        }
        else if (line.find("Starting items") != string::npos)
        {
            // Read starting items
            string starting_items = line.substr(18);
            vector<int> items;
            int start = 0;
            int end = 0;
            while (end != string::npos)
            {
                end = starting_items.find(",", start);
                string item = starting_items.substr(start, end - start);
                start = end + 2;
                items.push_back(stoi(item));
            }
            monkeys.back().starting_items = items;
        }
        else if (line.find("Operation") != string::npos)
        {
            string operation = line.substr(12);
            string op = operation.substr(11, 1);
            string value = operation.substr(13);

            if (op == "*")
            {
                if (value == "old")
                {
                    monkeys.back().operation = [](long long old)
                    { return (old * old); };
                }
                else
                {
                    monkeys.back().operation = [value](long long old)
                    { return (old * stol(value)); };
                }
            }
            else if (op == "+")
            {
                if (value == "old")
                {
                    monkeys.back().operation = [](long long old)
                    { return (old + old); };
                }
                else
                {
                    monkeys.back().operation = [value](long long old)
                    { return (old + stol(value)); };
                }
            }
        }
        else if (line.find("Test") != string::npos)
        {
            // Read test "divisible by 23". Take only what comes after "divisible by "
            string test = line.substr(21);
            monkeys.back().test = stoi(test);
        }
        else if (line.find("If true") != string::npos)
        {
            // Read throw_to (last char in line)
            string throw_to = line.substr(line.size() - 1, 1);
            monkeys.back().throw_to_true = stoi(throw_to);
        }
        else if (line.find("If false") != string::npos)
        {
            // Read throw_to
            string throw_to = line.substr(line.size() - 1, 1);
            monkeys.back().throw_to_false = stoi(throw_to);
        }
    }

    vector<int> divisors;
    for (int i = 0; i < monkeys.size(); i++)
    {
        divisors.push_back(monkeys[i].test);
    }

    int supermodulo = 1;
    for (int i = 0; i < divisors.size(); i++)
    {
        supermodulo *= divisors[i];
    }

    // Print monkeys
    for (int i = 0; i < monkeys.size(); i++)
    {
        cout << "Monkey " << monkeys[i].number << ":" << endl;
        cout << "  Starting items: ";
        for (int j = 0; j < monkeys[i].starting_items.size(); j++)
        {
            cout << monkeys[i].starting_items[j];
            if (j != monkeys[i].starting_items.size() - 1)
            {
                cout << ", ";
            }
        }
        cout << endl;
        cout << "  Test: " << monkeys[i].test << endl;
        cout << "    If true: throw to monkey " << monkeys[i].throw_to_true << endl;
        cout << "    If false: throw to monkey " << monkeys[i].throw_to_false << endl;
    }

    int round = 1;

    while (round <= rounds)
    {
        for (int i = 0; i < monkeys.size(); i++)
        {
            // cout << "Running monkey " << i << endl;
            // cout << "Starting items: ";
            // for (int j = 0; j < monkeys[i].starting_items.size(); j++)
            // {
            //     cout << monkeys[i].starting_items[j] << ", ";
            // }
            // cout << endl;

            while (monkeys[i].starting_items.size() > 0)
            {
                monkeys[i].inspect_count++;

                int item = monkeys[i].starting_items.front();

                // cout << "Inspecting item " << item << " from monkey " << i << endl;

                long long new_item = monkeys[i].operation(item);

                // new_item = floor(new_item / 3);

                new_item = new_item % supermodulo;

                if (new_item % monkeys[i].test == 0)
                {
                    monkeys[monkeys[i].throw_to_true].starting_items.push_back(new_item);
                    // cout << "Throwing item " << new_item << " to monkey " << monkeys[i].throw_to_true << endl;
                }
                else
                {
                    monkeys[monkeys[i].throw_to_false].starting_items.push_back(new_item);
                    // cout << "Throwing item " << new_item << " to monkey " << monkeys[i].throw_to_false << endl;
                }

                // Remove first item from starting_items
                monkeys[i].starting_items.erase(monkeys[i].starting_items.begin());
            }
        }

        // Print monkeys starting items
        // cout << "----------------" << endl;
        // cout << "Round " << round << endl;
        // for (int i = 0; i < monkeys.size(); i++)
        // {
        //     cout << "Monkey " << i << ": ";
        //     for (int j = 0; j < monkeys[i].starting_items.size(); j++)
        //     {
        //         cout << monkeys[i].starting_items[j] << ", ";
        //     }
        //     cout << endl;
        // }
        round++;
    }

    // Print inspect count for each monkey
    cout << "----------------" << endl;

    for (int i = 0; i < monkeys.size(); i++)
    {
        cout << "Monkey " << i << " inspect count: " << monkeys[i].inspect_count << endl;
    }

    // Get the two monkeys with the highest inspect count
    long long max1 = 0;
    long long max2 = 0;
    for (int i = 0; i < monkeys.size(); i++)
    {
        if (monkeys[i].inspect_count > max1)
        {
            max1 = monkeys[i].inspect_count;
        }
    }

    for (int i = 0; i < monkeys.size(); i++)
    {
        if (monkeys[i].inspect_count > max2 && monkeys[i].inspect_count < max1)
        {
            max2 = monkeys[i].inspect_count;
        }
    }

    cout << "----------------" << endl;
    cout << "Max 1: " << max1 << endl;
    cout << "Max 2: " << max2 << endl;

    cout << (max1) * (max2) << endl;
}
