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

