import sys
import subprocess


def main():
    file_name = sys.argv[1]

    with open(file_name, "r") as file:
        data = file.readline()
        execution = subprocess.run(["./tool.exe", data], capture_output=True)
        result = execution.stdout.decode("utf-8")
    with open(f"{file_name}-out-tool.txt", "w") as output:
        print(result, file=output)


if __name__ == "__main__":
    main()
