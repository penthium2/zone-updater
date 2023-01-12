# zone-updater
DNS zone file editor even dynamic

this little script does :

freeze the zone

injects and removes the jnl of dynamic updates

auto increment the serial number of the zone

launch vi to modify the zone in secure mode ( user login launch vi )

check the zone

releases the zone for future dynamic updates.
    
usage : ```zone-updater.sh -z ZONE -f ZONE_FILE```
