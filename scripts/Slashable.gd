extends Node
class_name Slashable

signal slashed

func hit(dir):
	#print("hit ", dir)
	slashed.emit(dir)
	pass
