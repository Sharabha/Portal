<VirtualHost *:80>
  ServerName meeting.ii.uni.wroc.pl

  DocumentRoot "/home/akijak/Sharabha/public"
  RailsEnv production

  <Directory "/home/akijak/Sharabha/public">
	Options Indexes +ExecCGI FollowSymLinks 
	Order allow,deny
	Allow from all
        AuthName "Login"
        AuthType Basic
        AuthUserFile /var/www/git/.htpasswd
        AuthGroupFile /dev/null
        require user sharabha
  </Directory>

</VirtualHost>
