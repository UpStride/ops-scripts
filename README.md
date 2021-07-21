# upstride-scripts
handy scripts to patch developers or production environments




## monitoring
- user story :<br/>
*I want to push log of standard output of my docker container to upstride's monitoring.*
- requirements : 
	- dockerd
	- docker-compose
	- user/password to preprod registry `registryupstrideprod.azurecr.io`

- installation :

**install docker-compose**
```bash
pip install docker-compose
```

**connect to the preprod registry**
```bash
pip install docker-compose
docker login -u username - p password  registryupstrideprod.azurecr.io
```

**download docker-compose yaml**
```bash
curl https://raw.githubusercontent.com/UpStride/ops-scripts/main/monitor/docker-compose.yml -o docker-compose.yml
```
**add the run parameters (image, volumes, port)**
```bash
vi docker-compose.yml
```
**run the container**
```bash
docker-compose up -d
```


## installation
### install azurefile network filesystem for docker
- user story :<br/>
*I want to dump my data in a datalake when I am using a azure's virtual machine and docker.*
- installation :
```bash
curl https://raw.githubusercontent.com/UpStride/ops-scripts/main/set-azurefile/install-azure-driver.sh | sudo bash
```
- cli :
  - `--clean` cleanup the azurefile daemon from systemctl
  - `--dry-run` check all stages without doing anything dramatic

## cronjobs
- user story :<br/>
*I want to renew letsencrypt certificate automatically*
- installation :
```bash
curl https://raw.githubusercontent.com/UpStride/upstride-scripts/main/letsencrypt/renew-certs.sh | sudo bash
```

## upload script
- user story :<br/>
*I want to upload docker container log to upstride data store.*
```bash
curl https://raw.githubusercontent.com/UpStride/ops-scripts/main/upload-logs/install |sudo bash
```



