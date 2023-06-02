# Ops Scripts

The philosophy of the repos is to provide handy scripts no more complex than a curl command. Please keep in mind, that the scripts herein are executed at random place where the environment is unsure.
The scripts must require minimum stuff to run. 

## Practical example of the philosophy
For example, when you write a python script prefer built-in libraries to external library, to avoid introducing a layer of complexity for the script compilation. 
If you write your python script with only built-in library, the only requirement is the python's version within you have written and tested your script. At the script entrypoint you only to need to check the python version. 
If your script is not too complex is likely a major version will do...  

## Scripts structure 
All scripts have the same structure:
- *run*: main `bash` script handling high-level calls of other script and passing arguments
- *shared*: utilitary scripts in `python` to handle data and datastructure
- *external*: external program calls. Those programs must be installed on the machine where the script is executed. 
The main script will warn you if something is missing.

## Scripts List 
Here is a list of scripts implemented in this repos and their main purpose. There are additional readme into scripts directory to explain scripts fine-graded manipulation:
- **backup-registry** => archive all docker container(s) into a docker registry and push it into a bucket
- **azure-cleanup** => remove azure resource groups
- **azure-filesystem** => install azurefile and start the service

### cronjobs
- user story :<br/>
*I want to renew letsencrypt certificate automatically*
- installation :
```bash
curl https://raw.githubusercontent.com/UpStride/upstride-scripts/main/letsencrypt/renew-certs.sh | sudo bash
```

### upload-logs
- user story :<br/>
*I want to upload docker container log to some data store.*
```bash
curl https://raw.githubusercontent.com/UpStride/ops-scripts/main/upload-logs/install |sudo bash
```


## Testing
Tests are still missing for two main reasons:
- the repo is not very active
- at the moment, the objective of the repo is not to provide production grade code, but some one-shoot scripts to execute on the flight.
