FROM rocker/shiny-verse:latest

# install R packages required 
RUN mkdir -p /opt/software/setup/R
ADD install_packages.R /opt/software/setup/R/
RUN Rscript /opt/software/setup/R/install_packages.R

# copy the app to the image
COPY *.Rproj /srv/shiny-server/
COPY *.R /srv/shiny-server/


# select port
EXPOSE 3838

# allow permission
RUN sudo chown -R shiny:shiny /srv/shiny-server

# Copy further configuration files into the Docker image
COPY shiny-server.sh /usr/bin/shiny-server.sh

RUN ["chmod", "+x", "/usr/bin/shiny-server.sh"]

# run app
CMD ["/usr/bin/shiny-server.sh"]
