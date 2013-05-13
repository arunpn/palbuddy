palbuddy
========

Open Source Ruby on Rails Social Networking Codebase

## Setting Up

### Step 1 - Getting Started
1. Clone the Repository
`git clone git@github.com:raycoding/palbuddy.git`
2. Install Essentials - RVM with Ruby 1.9.2 , Rails 3.2.13, MySQL 5.5, Apache2 (You can use APP_PATH/setup/install.sh). `sudo chmod +x ./script/install.sh` & `./script/install.sh localbox`
3. Once everything is installed Enter APP_PATH and run `bundle install`
4. Create DataBase and Run Migrations `rake db:create` `rake db:migrate`
5. Create directories APP_PATH/log, APP_PATH/shared/log and APP_PATH/shared/pids if not present
6. `sudo chmod -R 777 log`  , `sudo chmod -R /shared/` and also make sure you are owner of shared directory not 'root'

### Step 2 - Apache2 Web Server
1. Run bundle install to get all GEMS 
2. Read about Unicorn Web Server and take a look at APP_PATH/config/unicorn.rb for better understanding
3. Setting Up Apache 2 Virtual Hosts
4. Enable Apache2 Rewrites - execute `sudo a2enmod rewrite`
5. Add the below lines to a new sites-available file `sudo vim /etc/apache2/sites-available/palbuddy.dev`
   [VirtualHost Apache Conf Sample Data](https://gist.github.com/raycoding/5561819)
6. Add site to hosts - execute `sudo vim /etc/hosts` and add **127.0.0.1  palbuddy.dev** to existing list
7. Add the Virtual Configuration to enabled sites - execute `sudo a2ensite palbuddy.dev`

NOTE : This Virtual Conf looks different that normal or what you do for Passenger with Apache, reason being it is configured to respond to Unicorn App Server in next Step. Please make necessary changes to your APP_PATH after getting the sample. I will assume you have Apache configured and running. We need to add some configurations to allow Apache to proxy requests to the Unicorn server

### Step 3 - Integrating Unicorn Web Server
1. `sudo a2enmod proxy`
2. `sudo a2enmod proxy_balancer`
3. `sudo a2enmod proxy_http`
4. `sudo a2enmod rewrite`
5. Restart your Apache server `sudo service apache2 restart`
6. Assuming you have already ran `bundle install` so Unicorn GEM has been installed.
9. Start / Stop / Restart Unicorn Using the script APP_PATH/script/unicorn.sh 
   `./script/unicorn.sh start` & `./script/unicorn.sh stop` OR `./script/unicorn.sh restart`
10. Open Browser and palbuddy.dev/ should take you the HOME Page. Done!

### Step 4 - Integrating Apache Solr on Apache Tomcat Server
1. For Search Puposes please read more about Apache Solr. 
2. I have pre-configured Apache Tomcat Server and Apache Solr to work with the project out-of-the-box.
3. Open ../tomcat-solr/bin/seten.sh and make changes to the PATH where your Project Solr is. 
For example in the codebase `export CATALINA_OPTS="-Dsolr.solr home=/home/ghostviper/Work/codebase/palbuddy/codebase/search-palbuddy .."`
changes to 
`export CATALINA_OPTS="-Dsolr.solr.home=/YOUR_PATH/palbuddy/codebase/search-palbuddy .."`
5. Once done make changes to PATH in ../palbuddy-search/solr.xml similarly updating your PATH
4. From APP_PATH `../tomcat-solr/bin/bounce.sh` should stopNstart the Tomcat Solr

