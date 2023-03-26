import strutils, sequtils
import os

proc replace_function(big_string: string, replace_what: string,
    replace_with: string): string =
  # Replace all instances of "replace_what(" with "replace_with["
  let replace_what_len = replace_what.len + 1
  let replace_what = replace_what & "("
  let replace_with = replace_with & "["
  var index = 0

  var big_string = replace(big_string, replace_what, replace_with)

  # Add a closing bracket for each "replace_with[" expression
  let replace_with_len = replace_with.len
  index = 0
  while true:
    index = big_string.find(replace_with, index)
    if index == -1: break
    var bracket_count = 1
    var j = index + replace_with_len
    while bracket_count > 0 and j < big_string.len:
      case big_string[j]
      of '(':
        bracket_count += 1
      of ')':
        bracket_count -= 1
        if bracket_count == 0 and big_string[j] == ')':
          big_string.delete(j, j)
          big_string.insert("]", j)
          # big_string.replace(j, 1, "]")
      else:
        discard
      j += 1

    index = j

  return big_string

when isMainModule:

  let argc = paramCount()
  if argc != 1:
    quit 1
  else:
    let argv = commandLineParams()
    let input_string = argv[0]
    let result = replace_function(input_string, "sqrt", "Sqrt")
    echo result
