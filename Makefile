SERVER_DIR="$(HOME)/csgo_ds"
METAMOD_URL="https://mms.alliedmods.net/mmsdrop/1.10/mmsource-1.10.7-git959-linux.tar.gz"
SOURCEMOD_URL="https://sm.alliedmods.net/smdrop/1.8/sourcemod-1.8.0-git6016-linux.tar.gz"
STRIPPER_URL="http://www.bailopan.net/stripper/snapshots/1.2/stripper-1.2.2-git113-linux.tar.gz"
CKSURF_URL="https://forums.alliedmods.net/attachment.php?attachmentid=153717&d=1460462158"

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

	# remove all default maps
	rm -rf $(SERVER_DIR)/csgo/maps/*

	# download and install ckSurf
	wget -O cksurf.zip $(CKSURF_URL)
	unzip cksurf.zip -d cksurf/
	cp -a cksurf/csgo/* $(SERVER_DIR)/csgo
	cp -r cksurf/Optional\ files/Stripper\ configurations/* $(SERVER_DIR)/csgo/addons/stripper/
	rm cksurf.zip
	rm -rf cksurf/

	# copy configs and default map
	cp -a csgo/* $(SERVER_DIR)/csgo/
        
	# copy run and update script to your server dir
	cp server_commands.makefile $(SERVER_DIR)/Makefile

	# activate some plugins
	mv $(SERVER_DIR)/csgo/addons/sourcemod/plugins/disabled/mapchooser.smx $(SERVER_DIR)/csgo/addons/sourcemod/plugins
	mv $(SERVER_DIR)/csgo/addons/sourcemod/plugins/disabled/rockthevote.smx $(SERVER_DIR)/csgo/addons/sourcemod/plugins
	mv $(SERVER_DIR)/csgo/addons/sourcemod/plugins/disabled/nominations.smx $(SERVER_DIR)/csgo/addons/sourcemod/plugins

