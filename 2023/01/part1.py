# read input
with open('data') as f:
    lines = f.readlines()

    # for each line

    numbers = []

    for line in lines:
        # split line into characters
        chars = list(line)
        # trim \n
        chars.pop()

        pos1 = 0
        pos2 = 0

        # for each char check if it is a number
        for char in chars:
            if char.isdigit():
                # if it is a number, print it
                pos1 = int(char)
                break
        
        # reverse chars
        chars.reverse()
        for char in chars:
            if char.isdigit():
                pos2 = int(char)
                break
        

        number = (10 * int(pos1)) + pos2
        numbers.append(number)

    
    print(sum(numbers))

