extends RichTextLabel

@onready var cole = $".."

func set_text(text: String):

	self.size.x = self.get_theme_font("normal_font").get_string_size(text).x
	self.size.y = self.get_theme_font("normal_font").get_string_size(text).y

	if cole is CharacterBody2D:
		self.position.x = -self.size.x / 2
	else:
		self.position = cole.camera.unproject_position(
			cole.transform.origin + cole.talk_bubble_offset
		) - Vector2(self.size.x / 2, 0)

	self.text = text
