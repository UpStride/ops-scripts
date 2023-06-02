## backup docker registry
- user story :<br/>
*I want to browse organization github and extract information (owners, recent activity, last commiters...).*
- requirements : 
	- curl
	- python3
	- bash
	- terraform

**set the auth token**
Export github token in the environment
```bash
export GITHUB_TOKEN=xxxxx
```

**run the script**
```bash
bash browse-github/run -o ContentSquare -l repo_name_list.csv
```
