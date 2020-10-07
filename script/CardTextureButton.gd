extends TextureButton

var isInCardPopupPanel = false

func _ready():
	pass
	connect("mouse_entered", self, "_on_CardTextureButton_mouse_entered")
	connect("mouse_exited", self, "_on_CardTextureButton_mouse_exited")

func _on_CardTextureButton_mouse_entered():
	_show_Panel_and_follow()
	$CardPopupPanel.visible = true
	
func _on_CardTextureButton_mouse_exited():
	$CardPopupPanel.visible = false


func _show_Panel_and_follow():
	var mpos = get_global_mouse_position()
	var psize = $CardPopupPanel.rect_size
	var vsize = get_viewport_rect().size
	mpos += Vector2(15, 0)
	mpos.y = min(mpos.y, vsize.y - psize.y - 5)
	mpos.x = min(mpos.x, vsize.x - psize.x - 5)
	$CardPopupPanel.rect_position = mpos
	
	

func _process(delta):
	pass
	_show_Panel_and_follow()
