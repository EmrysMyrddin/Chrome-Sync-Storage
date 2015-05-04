class ChromeSyncStorage
	constructor: ->
		@session = new Session()
		@idTabDriver = new IdTabDriver()

	#Private Methods
	updateFromStorage = (storage, areaName, afsStorage) ->
		if areaName isnt "local" then return

		for key in Object.keys storage
			if key.contains "afs_"
				[firsts..., last] = key.split "_"
				for name in firsts
					if name is "afs" then obj = afsStorage;
					else obj = obj[name]
				obj[last] = storage[key].newValue ? storage[key]
				null
		#log "Storage Updated"

	#private attribute
	login = ""
	password = ""
	idStore = ""
	cloudHost = "accessfrance.eu/cloud/WS/"
	usingTablet = false
	initiating = false
	initialised = false

	#public Getters and Setters
	@property "login",
		set : (newValue) ->
			if initiating then login = newValue; return
			if newValue isnt login then chrome.storage.local.set({afs_login: newValue}, -> login = newValue)
		get : -> login

	@property "password",
		set : (newValue) ->
			if initiating then password = newValue; return
			if newValue isnt password then chrome.storage.local.set({afs_password: newValue}, -> password = newValue)
		get : -> password

	@property "cloudHost",
		set : (newValue) ->
			if initiating then cloudHost = newValue; return
			if newValue isnt cloudHost then chrome.storage.local.set({afs_cloudHost: newValue}, -> cloudHost = newValue)
		get : -> cloudHost

	@property "idStore",
		set : (newValue) ->
			if initiating then idStore = newValue; return
			if newValue isnt idStore then chrome.storage.local.set({afs_idStore: newValue}, -> idStore = newValue)
		get : -> idStore

	@property "usingTablet",
		set : (newValue) ->
			if initiating then usingTablet = newValue; return
			if newValue isnt usingTablet then chrome.storage.local.set({afs_usingTablet: newValue}, -> usingTablet = newValue)
		get : -> usingTablet

	@property "initialized",
		get : -> initialised

	#Public methods
	init : ->
		((afsStorage) ->
			initiating = true
			chrome.storage.local.get (storage) ->
				updateFromStorage storage, "local" , afsStorage
				initiating = false
				initialised = true

			chrome.storage.onChanged.addListener (changes, areaName) ->
				updateFromStorage changes, areaName, afsStorage
		)(this)

	class Session
		token = ""
		expiration = 0

		@property "token",
			set : (newValue) ->
				if initiating then token = newValue; return
				if newValue isnt token
					chrome.storage.local.set({afs_session_token: newValue}, -> token = newValue)
			get : -> token

		@property "expiration",
			set : (newValue) ->
				if initiating then expiration = newValue; return
				if newValue isnt expiration
					chrome.storage.local.set({afs_session_expiration: newValue}, -> expiration = newValue)
			get : -> expiration

	class IdTabDriver
		host = "localhost"
		port = 44360

		@property "host",
			set : (newValue) ->
				if initiating then host = newValue; return
				if newValue isnt host
					chrome.storage.local.set({afs_idTabDriver_host: newValue}, -> host = newValue)
			get : -> host

		@property "port",
			set : (newValue) ->
				if initiating then port = newValue; return
				if newValue isnt port
					chrome.storage.local.set({afs_idTabDriver_port: newValue}, -> port = newValue)
			get : -> port



storage = new ChromeSyncStorage()
storage.init()
