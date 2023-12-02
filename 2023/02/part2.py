red = 12
green = 13
blue = 14

#define class game, with attributes id, rounds
class Game:
    isValid = True

    def __init__(self, id):
        self.id = id
        self.rounds = []
            
    def add_round(self, round):
        self.rounds.append(round)

    def max_cubes(self):
        max_blue = 0
        max_green = 0
        max_red = 0

        for round in self.rounds:
            if round.blue > max_blue:
                max_blue = round.blue
            if round.green > max_green:
                max_green = round.green
            if round.red > max_red:
                max_red = round.red
        
        return (max_red * max_green * max_blue)
        

#define class round, with attributes red, green, blue
class Round:    
    def __init__(self, red, green, blue):
        self.red = red
        self.green = green
        self.blue = blue
        
    def __init__(self, str):
        self.blue = 0
        self.green = 0
        self.red = 0
        parts = str.split(",")

        
        for part in parts:
            part = part.strip()
            if part.find("red") != -1:
                self.red = int( part.replace(" red", ""))
            elif part.find("green") != -1:
                self.green = int(part.replace(" green", ""))
            elif part.find("blue") != -1:
                self.blue = int(part.replace(" blue", ""))
            else:
                print("Error: " + part)

    
    def __str__(self):
        return "red: " + str(self.red) + ", green: " + str(self.green) + ", blue: " + str(self.blue)
    
    def __repr__(self):
        return self.__str__()
    
    def isValid(self, red, green, blue):
        if self.red <= red and self.green <= green and self.blue <= blue:
            return True
        else:
            return False
        

with open('data') as f:
    lines = f.readlines()

    results = []

    for line in lines:
        
        # split the line at ":"
        parts = line.split(":")
        # remove "Game " from the beginning of the id
        id = parts[0][5:]

        game = Game(id)

        # split part1 at ";", trim whitespace
        part1 = parts[1].split(";")
        trimmed = []
        for element in part1:
            round = Round(element)
            game.add_round(round)

        results.append(game.max_cubes())


    print(sum(results))
        
