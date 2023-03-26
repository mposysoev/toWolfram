import strutils, sequtils
import nimpy

proc replace_function(big_string: string, replace_what: string, replace_with: string): string {.exportpy.} =
  # Replace all instances of "replace_what(" with "replace_with["
  let replace_what_len = replace_what.len + 1
  replace_what = replace_what & "("
  replace_with = replace_with & "["
  var index = 0
  while true:
    index = big_string.find(replace_what, index)
    if index == -1: break
    big_string.replace(index, replace_what_len, replace_with)
  
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
          big_string.replace(j, 1, "]")
      else:
        discard
      j += 1
    
    index = j
  
  return big_string
