# upstride-scripts
handy scripts to patch developers or production environments

- **backup-registry** => archive all docker container(s) into a docker registry and push it into a bucket
- **azure-cleanup** => remove azure resource groups
- **azure-filesystem** => install azurefile and start the service

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



