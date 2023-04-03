#!/bin/bash
sudo rm -rf /usr/share/nginx/html
sudo ln -s /home/ec2-user/web/build/ /usr/share/nginx/html

echo " " >> /home/ec2-user/web/nginx.conf
echo "     sendfile            on;" >> /home/ec2-user/web/nginx.conf
echo "     tcp_nopush          on;" >> /home/ec2-user/web/nginx.conf
echo "     tcp_nodelay         on;" >> /home/ec2-user/web/nginx.conf
echo "     keepalive_timeout   65;" >> /home/ec2-user/web/nginx.conf
echo "     types_hash_max_size 4096;" >> /home/ec2-user/web/nginx.conf
echo " " >> /home/ec2-user/web/nginx.conf
echo "     include             /etc/nginx/mime.types;" >> /home/ec2-user/web/nginx.conf
echo "     default_type        application/octet-stream;" >> /home/ec2-user/web/nginx.conf
echo " " >> /home/ec2-user/web/nginx.conf
echo "     include /etc/nginx/conf.d/*.conf;" >> /home/ec2-user/web/nginx.conf
echo " " >> /home/ec2-user/web/nginx.conf
echo "     server {" >> /home/ec2-user/web/nginx.conf
echo "         listen       80;" >> /home/ec2-user/web/nginx.conf
echo "         listen       [::]:80;" >> /home/ec2-user/web/nginx.conf
echo "         server_name  _;" >> /home/ec2-user/web/nginx.conf
echo " " >> /home/ec2-user/web/nginx.conf
echo "         location / {" >> /home/ec2-user/web/nginx.conf
echo "             root         /usr/share/nginx/html;" >> /home/ec2-user/web/nginx.conf
echo "         }" >> /home/ec2-user/web/nginx.conf
echo " " >> /home/ec2-user/web/nginx.conf
echo "         location /api {" >> /home/ec2-user/web/nginx.conf
echo "             proxy_pass http://$1:5000;" >> /home/ec2-user/web/nginx.conf
echo "         }" >> /home/ec2-user/web/nginx.conf
echo "         " >> /home/ec2-user/web/nginx.conf
echo "         error_page 404 /404.html;" >> /home/ec2-user/web/nginx.conf
echo "         location = /404.html {" >> /home/ec2-user/web/nginx.conf
echo "         }" >> /home/ec2-user/web/nginx.conf
echo " " >> /home/ec2-user/web/nginx.conf
echo "         error_page 500 502 503 504 /50x.html;" >> /home/ec2-user/web/nginx.conf
echo "         location = /50x.html {" >> /home/ec2-user/web/nginx.conf
echo "         }" >> /home/ec2-user/web/nginx.conf
echo "     }" >> /home/ec2-user/web/nginx.conf
echo " }" >> /home/ec2-user/web/nginx.conf
echo " " >> /home/ec2-user/web/nginx.conf

sudo rm -rf /etc/nginx/nginx.conf
sudo mv /home/ec2-user/web/ngnix.conf /etc/nginx/nginx.conf

sudo systemctl start nginx.service
sudo systemctl enable nginx.service
sudo systemctl restart nginx.service