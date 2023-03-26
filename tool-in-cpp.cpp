#include <fstream>
#include <iostream>
#include <string>

using namespace std;

string replace_function(string big_string, string replace_what, string replace_with)
{
    // Replace all instances of "replace_what(" with "replace_with["
    size_t index = 0;
    size_t length = replace_what.length() + 1;
    replace_what = replace_what.append("(");
    replace_with = replace_with.append("[");
    while ((index = big_string.find(replace_what, index)) != string::npos) {
        big_string.replace(index, length, replace_with);
    }

    // Add a closing bracket for each "replace_with[" expression
    index = 0;
    while ((index = big_string.find(replace_with, index)) != string::npos) {
        int bracket_count = 1;
        size_t j = index + length;
        while (bracket_count > 0 && j < big_string.length()) {
            if (big_string[j] == '(') {
                bracket_count++;
            } else if (big_string[j] == ')') {
                bracket_count--;
                if (bracket_count == 0 && big_string[j] == ')') {
                    big_string.replace(j, 1, "]");
                }
            }
            j++;
        }

        index = j;
    }

    return big_string;
}

int main(int argc, char* argv[])
{
    if (argc != 2) {
        std::cerr << "Usage: " << argv[0] << " <string>\n";
        return 1;
    }

    string input_string = argv[1];
    string result = replace_function(input_string, "sqrt", "Sqrt");
    cout << result << endl;

    return 0;
}

// int main()
// {
//     string filename = "Diagram_example.txt";
//     ifstream file(filename);
//     if (!file) {
//         cerr << "Error: could not open file " << filename << endl;
//         return 1;
//     }

//     string big_string;
//     string line;
//     while (getline(file, line)) {
//         big_string += line;
//     }
//     file.close();
//     cout << "start to calculate" << endl;
//     string modified_big_string = replace_function(big_string, "sqrt", "Sqrt");
//     cout << modified_big_string << endl;

//     string filenameout = "output-cpp-new.txt";
//     ofstream file2(filenameout);
//     if (!file2) {
//         cerr << "Error: could not create file " << filename << endl;
//         return 1;
//     }

//     file2 << modified_big_string;
//     file2.close();

//     return 0;
// }
