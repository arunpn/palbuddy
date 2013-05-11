    set -e
	function say_green
	{
		echo -e '\E[00;32m'"\033[1m$@\033[0m"
	}
	function say_red
	{
		echo -e '\E[00;31m'"\033[1m$@\033[0m"
	}
	function say_cyan
	{
		echo -e '\E[00;36m'"\033[1m$@\033[0m"
	}
	function say_yellow
	{
		echo -e '\E[01;33m'"\033[1m$@\033[0m"
	}

	function get_essentials
	{
		say_green "Updating apt-get"
		sudo apt-get update
		say_green "Installing development packages"
		sudo apt-get install build-essential bison openssl libreadline5 libreadline-dev curl git zlib1g zlib1g-dev libssl-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev
		sudo apt-get install g++-multilib
		say_green "Installing ImageMagik"
		sudo apt-get install imagemagick
		say_green "Installing Memcached"
		sudo apt-get install memcached
		say_green "Installing GIT and SVN"
		sudo apt-get install git-core subversion
		sudo echo "export PS1='\u \w $(__git_ps1 "\[\033[01;34m\]%s \[\033[00m\]")$ '"  >> ~/.bashrc
		#Patch for RVM GCC Issues
		sudo echo "export CFLAGS='-O2 -fno-tree-dce -fno-optimize-sibling-calls'" >> ~/.bashrc
		sudo echo "export CC='/usr/bin/gcc'" >> ~/.bashrc
		#Path for RMagik
		sudo apt-get install libmagickwand-dev
		export LD_LIBRARY_PATH=/usr/local/lib

	}

	function  local_install_java
	{
		d=`pwd`
		sudo mkdir /usr/lib/jvm
		cd /usr/lib/jvm
		say_cyan " Downloading jdk-6u29-linux-i586.bin in your /usr/lib/jvm folder"
		sudo wget https://s3.amazonaws.com/socialbeam-repo/jdk/jdk-6u29-linux-i586.bin
		sudo chmod +x jdk-6u29-linux-i586.bin
		sudo ./jdk-6u29-linux-i586.bin
		sudo ./jdk-6u29-linux-i586.bin
		sudo update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.6.0_29/bin/java" 1
		sudo update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk1.6.0_29/bin/javac" 1
		sudo update-alternatives --install "/usr/lib/mozilla/plugins/libjavaplugin.so" "mozilla-javaplugin.so" "/usr/lib/jvm/jdk1.6.0_29/jre/lib/i386/libnpjp2.so" 1
		sudo update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/lib/jvm/jdk1.6.0_29/bin/javaws" 1
		sudo update-alternatives --config java
		sudo update-alternatives --config javac
		sudo update-alternatives --config mozilla-javaplugin.so
		sudo update-alternatives --config javaws
		say_green "JDK 6.0 Update 29 Installation complete"
		say_yellow "export JAVA_HOME=/usr/lib/jvm/jdk1.6.0_29"
		say_yellow "export JRE_HOME=/usr/lib/jvm/jdk1.6.0_29/jre"
		sudo echo "export JAVA_HOME=/usr/lib/jvm/jdk1.6.0_29" >> ~/.bashrc
		sudo echo "export JRE_HOME=/usr/lib/jvm/jdk1.6.0_29/jre" >> ~/.bashrc
		say_yellow "Added JAVA PATH variables  to ~/.bashrc"
		export PATH=$PATH:/usr/lib/jvm/jdk1.6.0_29/bin
		cd $d
		say_green "Sourcing ~/.bashrc"
		source ~/.bashrc

	}

	function local_install_rvm_jruby
	{
		say_green "installing RVM for current user"
		\curl -L https://get.rvm.io | bash -s stable
		say_green "Completed installation of RVM"
		say_green "installing Ruby 1.9.2 to be used by RVM"
		rvm install 1.9.2
		say_green "Completed installing Ruby 1.9.2"
		say_green "Adding alias to ~/.bashrc"
		say_green "alias 1.9.2='rvm use 1.9.2 --default'" 
		sudo echo "alias 1.9.2='rvm use 1.9.2 --default'" >> ~/.bashrc
		say_red "sourcing ~/.bashrc"
		source ~/.bashrc
		export PATH=$PATH:$HOME/.rvm/bin
		# If Not AUTO GENERATED after installation of RVM-Ruby Please execute the lines below
        #echo "[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"" >> ~/.bash_profile
        #echo "source $HOME/.rvm/scripts/rvm" >> ~/.bashrc
	}

	function local_install_rails3
	{	
		ruby -v
		say_yellow "Installing Rails 3.2.13"
		jruby -S gem install rails -v='3.2.13' --no-ri --no-rdoc
		say_green "Completed installing Rails 3.2.13"
	}


	function install_myql
	{
		say_yellow "Installing MySQL Server and Client Packges"
		sudo apt-get install libmysqlclient-dev 
		say_yellow "Installing mysql2 gems"
		gem install mysql2 -v=0.3.11
		say_green"Completed installing mysql and mysql2  gems"
		sudo apt-get install mysql-server-5.5 mysql-client-5.5
		say_green "Completed installing MySQL Server and Client Packges"

	}

	function  install_apache2
	{
		say_yellow "Installing Apache2"
		sudo apt-get install apache2 apache2-mpm-prefork apache2-prefork-dev
		sudo apt-get install libapache2-mod-xsendfile	
		say_green "Completed installing Apache2"
	}

	function setup
	{
		if [ "$1" == "localbox" ];then
			say_cyan "Setting Up Enviromnet for $1"
			get_essentials
			local_install_java
			local_install_rvm_ruby
			local_install_rails3
			install_myql
			install_apache2
			say_red "sourcing ~/.bashrc and putting it in /etc/profile"
			source ~/.bashrc
	        sudo echo "source ~/.bashrc" >> ~/etc/profile
			say_green "Installation Complete"
		else
			say_red "please pass either 'localbox' as argument"
		fi
	}
	#Calling Setup Function with Argument :localbox
	setup $1