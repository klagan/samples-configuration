# Getting started

## Build a site configuration

#### Create a sample configuration file

Location: `/etc/nginx/conf.d/`  
e.g. `vim /etc/nginx/conf.d/samplesite.conf`

---

#### Populate the configuration file:

```bash
server {
        listen 80;
        root /var/www/samplesite;
}
server {
        listen 80 default_server;
        server_name 192.168.86.52 binaryville.local www.binaryville.local;
        index index.html index.htm index.php;
        root /var/www/binaryville;
}
```
---

#### Add sample content

```
# setup new site
mkdir -p /var/www/binaryville

# create holding page
echo "Site coming soon!" > /var/www/binaryville/index.html
```
---

#### Validate the nginx configurations

```bash
# confirm configuration is syntactically correct
nginx -t

# dump out the configuration file
# should see our new site configuration 
nginx -T

# check running fine
systemctl status nginx
systemctl reload nginx

curl localhost 192.168.86.52:80
```
