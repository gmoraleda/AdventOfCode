#include <iostream>
#include <vector>
#include <string>
#include <fstream>
#include <unordered_map>

using namespace std;

int main(int argc, char **argv)
{
    string filename = argv[1];

    // A = Rock
    // B = Paper
    // C = Scissors

    // Points
    // A = 1
    // B = 2
    // C = 3

    // Result
    // X = Lose
    // Y = Draw
    // Z = Win

    // unordered_map<char, unordered_map<char, char>> rules;
    // rules['A']['X'] = 'D';
    // rules['A']['Y'] = 'Y';
    // rules['A']['Z'] = 'A';
    // rules['B']['X'] = 'B';
    // rules['B']['Y'] = 'D';
    // rules['B']['Z'] = 'Z';
    // rules['C']['X'] = 'X';
    // rules['C']['Y'] = 'C';
    // rules['C']['Z'] = 'D';

    unordered_map<char, unordered_map<char, char>> rules;
    rules['A']['X'] = 'C';
    rules['A']['Y'] = 'A';
    rules['A']['Z'] = 'B';
    rules['B']['X'] = 'A';
    rules['B']['Y'] = 'B';
    rules['B']['Z'] = 'C';
    rules['C']['X'] = 'B';
    rules['C']['Y'] = 'C';
    rules['C']['Z'] = 'A';

    // unordered_map<char, int> winner_points;
    // winner_points['D'] = 3;
    // winner_points['X'] = 6;
    // winner_points['Y'] = 6;
    // winner_points['Z'] = 6;
    // winner_points['A'] = 0;
    // winner_points['B'] = 0;
    // winner_points['C'] = 0;

    unordered_map<char, int> winner_points;
    winner_points['X'] = 0;
    winner_points['Y'] = 3;
    winner_points['Z'] = 6;

    // Choosen values
    // unordered_map<char, int> values;
    // values['X'] = 1;
    // values['Y'] = 2;
    // values['Z'] = 3;

    unordered_map<char, int> values;
    values['A'] = 1;
    values['B'] = 2;
    values['C'] = 3;

    int points = 0;

    ifstream file(filename);
    if (file.is_open())
    {
        string line;

        while (getline(file, line))
        {
            char player1 = line[0];
            char result = line[2];
            char player2 = rules[player1][result];

            points += winner_points[result];
            points += values[player2];
        }
        file.close();

        cout << points << endl;
    }
}
