extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	test_fractions2()

func test_split_into():
	for i in range(0, 20):
		var arr = math_util.split_into(i, 4)
		print(str(i))
		print(arr)
		print("_______________________")

func test_ultimate_split():
	for i in range(2, 50):
		var arr = math_util.ultimate_split_into(i, 4)
		print(str(i))
		print(arr)
		print("___________________")

func test_generate(num, amount):
	for i in range(0, amount):
		var p = puzzle_division_blank.new(1,10)
		p.generate()
		print(p.display_problem())
		print(p.solution)
		print("_______________")

func test_fractions():
	for i in range(1, 21):
		for j in range(1, 21):
			var f1 = Fraction.new(i, j)
			var f2 = f1.copy()
			f2.simplify()
			print(str(f1) + " -> " + str(f2))

func test_fractions2():
	var f = Fraction.new(1, 2)
	print(f.generate_different(5, true))
