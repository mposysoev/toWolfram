import sys
import subprocess


def main():
    file_name = sys.argv[1]

    with open(file_name, "r") as file:
        data = file.readline()
        result = subprocess.run(["name-of-tool", data], capture_output=True)

    with open(f"{file_name}-out-tool.txt", "w") as output:
        print(result, file=output)


if __name__ == "__main__":
    main()
