
# Ubicación del archivo de configuración de shiny: /etc/shiny-server/shiny-server.conf
# Ubicación del archivo de logs de shiny: /var/log/shiny-server/

sudo service shiny-server stop
sudo rm -R /srv/shiny-server/contract-grouping
sudo cp -R '/home/camilo/Fidelio/secop-analysis/6. Viz/shiny' /srv/shiny-server/contract-grouping
sudo service shiny-server start

