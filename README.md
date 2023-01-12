# zone-updater
éditeur de fichier zone DNS même dynamique

ce petit script fait :

freeze la zone

injecte et supprime le jnl des mise à jour dynamique

auto incrémente le serial number de la zone

lance vi pour modifier la zone

vérifie la zone

libère la zone pour les futur mise à jours dynamiques.
    
usage : ```zone-updater.sh -z ZONE -f ZONE_FILE```
