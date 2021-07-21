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