class_name SSignIn extends RefCounted


var header = Packets.SIGN_IN


var email: String = ""
var posicao: Vector3 = Vector3.ZERO
var velocidade: Vector2 = Vector2.ZERO
var online: bool = false
var lista: Array[String] = []
var dic: Dictionary = {}


func handle(email: String, posicao: Vector3, velocidade: Vector2, online: bool, lista: Array[String], dic: Dictionary, tree: SceneTree, peer_id: int) -> void:
	self.email = email
	self.posicao = posicao
	self.velocidade = velocidade
	self.online = online
	self.lista = lista
	self.dic = dic

	Multiplayer.server.send_to(peer_id, header, [])
