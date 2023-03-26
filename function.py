import sys


def replace_function(big_string, replace_what, replace_with):
    # Replace all instances of "replace_what(" with "replace_with["
    index = 0
    length = len(replace_what) + 1
    while True:
        index = big_string.find(f"{replace_what}(", index)
        if index == -1:
            break
        big_string = (
            big_string[:index] + f"{replace_with}[" + big_string[index + length :]
        )

    # Add a closing bracket for each "replace_with[" expression
    index = 0
    while True:
        index = big_string.find(f"{replace_with}[", index)
        if index == -1:
            break
        bracket_count = 1
        j = index + length
        while bracket_count > 0 and j < len(big_string):
            if big_string[j] == "(":
                bracket_count += 1
            elif big_string[j] == ")":
                bracket_count -= 1
                if bracket_count == 0 and big_string[j] == ")":
                    big_string = big_string[:j] + "]" + big_string[j + 1 :]
            j += 1

        index = j

    return big_string


def main():
    file_name: str = sys.argv[1]

    with open(file_name, "r") as file:
        data = file.readline()
        result = replace_function(data, "sqrt", "Sqrt")

    with open(f"{file_name}-out.txt", "w") as output:
        print(result, file=output)


if __name__ == "__main__":
    main()
