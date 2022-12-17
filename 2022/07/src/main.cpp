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

    ifstream file(filename);
    if (file.is_open())
    {
        string line;
        vector<string> instructions;

        while (getline(file, line))
        {
            instructions.push_back(line);
        }
        file.close();

        // Part I

        // if instruction is "$ cd /", go to root
        // if instruction is "$ cd ..", go to parent
        // if instruction is "$ cd <directory>", go to child

        struct node
        {
            string name;
            node *parent;
            int size;
            vector<node *> children;
        };

        node *root = new node;
        root->name = "/";
        root->parent = NULL;

        node *current = root;

        for (int i = 0; i < instructions.size(); i++)
        {
            string instruction = instructions[i];
            if (instruction.substr(0, 4) == "$ cd")
            {
                string path = instruction.substr(5);
                if (path == "/")
                {
                    current = root;
                }
                else if (path == "..")
                {
                    current = current->parent;
                }
                else
                {
                    node *new_node = new node;
                    new_node->name = path;
                    new_node->parent = current;
                    new_node->size = 0;
                    current->children.push_back(new_node);
                    current = new_node;
                }
            }

            if (instruction[0] >= '0' && instruction[0] <= '9')
            {
                string number_string = "";
                for (int j = 0; j < instruction.length(); j++)
                {
                    if (instruction[j] >= '0' && instruction[j] <= '9')
                    {
                        number_string += instruction[j];
                    }
                    else
                    {
                        break;
                    }
                }
                int number = stoi(number_string);
                current->size += number;

                // Add size to all parents
                node *parent = current->parent;
                while (parent != NULL)
                {
                    parent->size += number;
                    parent = parent->parent;
                }
            }
        }

        int sum = 0;
        function<void(node *)> small_nodes = [&](node *n)
        {
            if (n->size <= 100000)
            {
                sum += n->size;
            }
            for (int i = 0; i < n->children.size(); i++)
            {
                small_nodes(n->children[i]);
            }
        };

        small_nodes(root);
        cout << sum << endl;

        // Part II
        int total_space = 70000000;
        int used_space = root->size;
        int unused_space = total_space - used_space;
        int required_space = 30000000;

        int smallest = 1000000000;
        function<void(node *)> smallest_node = [&](node *n)
        {
            if (n->size + unused_space >= required_space)
            {
                if (n->size < smallest)
                {
                    smallest = n->size;
                }

                for (int i = 0; i < n->children.size(); i++)
                {
                    smallest_node(n->children[i]);
                }
            }
        };

        smallest_node(root);
        cout << smallest << endl;
    };
}
