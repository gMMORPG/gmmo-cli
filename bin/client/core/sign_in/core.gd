class_name SignIn extends Packet


var email: String = ""
var password: String = ""
var settings: Dictionary = {}
var lista: Array[String] = []


func _init():
    header = Packets.SIGN_IN


func serialize(writer: StreamPeerBuffer) -> void:
    super.serialize(writer)


func deserialize(reader: StreamPeerBuffer) -> void:
    super.deserialize(reader)


func handle(_tree: SceneTree, id: int = -1) -> void:
    pass