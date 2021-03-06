MAP=surf_kitsune
MAPFILES=csgo/maps/*.bsp

run: update updatemaplist
	./srcds_run -game csgo -console -usercon +mapgroup mg_custom +map $(MAP) +game_type 0 +game_mode 0

update:
	steamcmd/steamcmd.sh +login anonymous +force_install_dir $$PWD +app_update 740 +quit

updatemaplist:
	rm -f csgo/maplist.txt
	for file in $(MAPFILES) ; do name=$${file##*/} ; echo $${name%.*} >> csgo/maplist.txt; done
