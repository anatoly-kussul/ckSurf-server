SERVER_DIR="$(HOME)/csgo_ds"
THIS_DIR=$(PWD)
METAMOD_URL=http://sourcemod.gameconnect.net/files/mmsource-1.10.6-linux.tar.gz
SOURCEMOD_URL=http://www.sourcemod.net/smdrop/1.7/sourcemod-1.7.3-git5272-linux.tar.gz
STRIPPER_URL=http://www.bailopan.net/stripper/files/stripper-1.2.2-linux.tar.gz

install:
	test -e $(SERVER_DIR) || mkdir $(SERVER_DIR)

	# download steamcmd
	wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz
	test -e $(SERVER_DIR)/steamcmd || mkdir $(SERVER_DIR)/steamcmd
	tar -xvzf steamcmd_linux.tar.gz -C $(SERVER_DIR)/steamcmd
	rm steamcmd_linux.tar.gz*

	# download srcds for csgo (740)
	$(SERVER_DIR)/steamcmd/steamcmd.sh +login anonymous +force_install_dir $(SERVER_DIR) +app_update 740 +quit

	# download and install metamod
	wget -O mmsource.tar.gz $(METAMOD_URL) 
	tar -xvzf mmsource.tar.gz -C $(SERVER_DIR)/csgo
	rm mmsource.tar.gz*

	# download and install sourcemod
	wget -O sourcemod.tar.gz $(SOURCEMOD_URL)
	tar -xvzf sourcemod.tar.gz -C $(SERVER_DIR)/csgo
	rm sourcemod.tar.gz*

	# download and install stripper
	wget -O stripper.tar.gz $(STRIPPER_URL)
	tar -xvzf stripper.tar.gz -C $(SERVER_DIR)/csgo
	rm stripper.tar.gz*

	# copy ckSurf plugin and configs
	\cp -r csgo/* $(SERVER_DIR)/csgo
        
	# copy run and update script to your server dir
	cp Makerun $(SERVER_DIR)/Makefile

	# activate some plugins
	mv $(SERVER_DIR)/csgo/addons/sourcemod/plugins/disabled/mapchooser.smx $(SERVER_DIR)/csgo/addons/sourcemod/plugins
	mv $(SERVER_DIR)/csgo/addons/sourcemod/plugins/disabled/rockthevote.smx $(SERVER_DIR)/csgo/addons/sourcemod/plugins
	mv $(SERVER_DIR)/csgo/addons/sourcemod/plugins/disabled/nominations.smx $(SERVER_DIR)/csgo/addons/sourcemod/plugins

