extends Node2D

var board = [
	["", "", ""],
	["", "", ""],
	["", "", ""]
]
var current_player = "X"

func check_winner():
	# Check rows
	for row in board:
		if row[0] != "" and row[0] == row[1] == row[2]:
			return true

	# Check columns
	for i in range(3):
		if board[0][i] != "" and board[0][i] == board[1][i] == board[2][i]:
			return true

	# Check diagonals
	if board[0][0] != "" and board[0][0] == board[1][1] == board[2][2]:
		return true
	if board[0][2] != "" and board[0][2] == board[1][1] == board[2][0]:
		return true

	return false
	
func on_button_pressed():
	var button = get_caller() as Button
	if button == null:
		return
	var index = button.get_index()  # Get button’s index in the parent
	var row = index / 3
	var col = index % 3
	# Check if the cell is empty
	if board[row][col] == "":
		board[row][col] = current_player
		button.text = current_player  # Display "X" or "O"
		if check_winner():
			print(current_player + " wins!")
			return
	# Check if the board is full (Draw)
	var board_full = true
	for r in board:
		if "" in r:
			board_full = false
			break
	if board_full:
		print("It's a draw!")
		return
		
	# Switch player
	current_player = "O" if current_player == "X" else "X"


func _on_reset_pressed() -> void:
	board = [
		["", "", ""],
		["", "", ""],
		["", "", ""]
	]
	current_player = "X"  
	# Reset all button texts
	for button in $Board/GridContainer.get_children():
		button.text = ""
