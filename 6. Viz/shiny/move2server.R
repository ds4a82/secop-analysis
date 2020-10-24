
system(command = "sudo rm -R /srv/shiny-server/backlog")
system(command = "sudo cp -R /home/camilo/CRISP-DM/R/Shiny/loginNavBar /srv/shiny-server/backlog")


# Ubicación del archivo de configuración de shiny: /etc/shiny-server/shiny-server.conf
# Ubicación del archivo de logs de shiny: /var/log/shiny-server/