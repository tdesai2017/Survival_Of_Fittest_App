


def temp_potato(board)

  puts("########################")
  print(board.current_state)
  board.current_state = '{"cells":[[0]]}'
  board.save
  print(board.current_state)
  puts("\n#######################")

end