# Getting started

**source**: `https://github.com/linuxserver/docker-calibre-web`

1. Switch to root user e.g. `sudo su - `
2. Download this repository
3. Edit the environment variables in the `install.sh` file
4. Update the `docker-compose.yml` to reflect the respective paths for the folders created above
5. Execute `install.sh`


### Defaults
|||
|-|-|
|uid|admin|
|pwd|admin123|

When configuring calibre web from the UI, unless you have customised the configuration, as per the vanilla `docker-compose.yml`, the `metadata.db` in stored in `\db`.
