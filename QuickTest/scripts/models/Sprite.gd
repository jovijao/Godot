class_name Sprite extends Sprite3D

func _init():
	pixel_size = 0.05
	texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	alpha_cut = SpriteBase3D.ALPHA_CUT_DISCARD
	shaded = true
