class listener:
	ROBOT_LISTENER_API_VERSION = 3

	def end_keyword(self, name, attributes):
		print("name		:", name)
		print("attributes	:", attributes)