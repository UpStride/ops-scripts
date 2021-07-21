## backup docker registry
- user story :<br/>
*I want to backup an entire docker registry into google drive.*
- requirements : 
	- dockerd
	- python
	- bash

**set the registry auth**
```bash
export REGISTRY_USERNAME=upstride
export REGISTRY_PASSWORD=secret
export REGISTRY_HOST=localhost:5000
```

**set the docker hub**
```bash
export DOCKER_USERNAME=upstride_google_token
export DOCKER_USERNAME=/tarball/registry
```

**run the script**
```bash
bash backup-registry/run
```