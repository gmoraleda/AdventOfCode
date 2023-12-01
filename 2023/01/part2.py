# read input
digits = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', '1', '2', '3', '4', '5', '6', '7', '8', '9']
values = { 'one' : 1, 'two' : 2, 'three' : 3, 'four' : 4, 'five' : 5, 'six' : 6, 'seven' : 7, 'eight' : 8, 'nine' : 9, '1' : 1, '2' : 2, '3' : 3, '4' : 4, '5' : 5, '6' : 6, '7' : 7, '8' : 8, '9' : 9}
numbers = []

with open('data') as f:
    lines = f.readlines()

    for line in lines:
   
        indexes = { 'one': -1, 'two': -1, 'three': -1, 'four': -1, 'five': -1, 'six': -1, 'seven': -1, 'eight': -1, 'nine': -1, '1': -1, '2': -1, '3': -1, '4': -1, '5': -1, '6': -1, '7': -1, '8': -1, '9': -1}
        for digit in digits:    
            # find the smallest index of any digit or any value
            index = line.find(digit)
            if index != -1:
                indexes[digit] = index
            
        min_index = 1000000
        min_value = ''

        for key, value in indexes.items():
            if value != -1 and value < min_index:
                min_index = value
                min_value = key



        # find the last number inside the line, without reversing it, because a number can be written in letters "one", "two", "three", etc.
        indexes = { 'one': -1, 'two': -1, 'three': -1, 'four': -1, 'five': -1, 'six': -1, 'seven': -1, 'eight': -1, 'nine': -1, '1': -1, '2': -1, '3': -1, '4': -1, '5': -1, '6': -1, '7': -1, '8': -1, '9': -1}
        
        for digit in digits:
            # find the largest index of any digit or any value
            index = line.rfind(digit)
            if index != -1:
                indexes[digit] = index
        
        max_index = -1
        max_value = ''

        for key, value in indexes.items():
            if value != -1 and value > max_index:
                max_index = value
                max_value = key

        
        number1 = values[min_value]
        number2 = values[max_value]
        
        number = (10 * int(number1)) + number2
        numbers.append(number)

    
    print(sum(numbers))

