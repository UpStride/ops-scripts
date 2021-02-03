# upstride-scripts
handy scripts to patch developers or production environments

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

### cronjobs
- user story :<br/>
*I want to renew letsencrypt certificate automatically*
- installation :
```bash
curl https://raw.githubusercontent.com/UpStride/upstride-scripts/main/letsencrypt/renew-certs.sh | sudo bash
```

## services
- user story :<br/>
*I want to upload docker container log to upstride data store.*
```bash
curl https://raw.githubusercontent.com/UpStride/ops-scripts/main/upload-logs/install |sudo bash
```



