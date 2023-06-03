# Ops Scripts

The philosophy of the repos is to provide handy scripts no more complex than a curl command. Please keep in mind, that these scripts herein are executed at random machines where the environment is unsure.
These scripts must require minimum stuff to run. 

## Practical example of the philosophy
Let's take the example of a Python script.<br><br>
Whenever you write a python script, we strongly recommend built-in libraries to external libraries. This avoids the introduction of an additional layer of complexity for the script compilation. 
If you write your python script with only built-in libraries, the only requirement is that the python's version corresponds to version where you implemented and tested your script.<br><br> 
At the script's entrypoint, you must check if the python version is present on the machine. So your script will run swiftly on random machine with a compatible python version. If your script is not too complex is likely even a compatible major version will do...

## Scripts structure 
All scripts have the same structure:
````
script-abc/
 |_ run
 |_ shared/ 
    |_ scripts.py
    |_ args.sh
````

Below some details about the scripts structure:
- *run*: entrypoint main `bash` script handling high-level calls of other scripts and passing arguments
- *shared*: utilities scripts in `python` to handle data and datastructure
- *external*: external program calls. Those programs must be installed on the machine where the script is executed. 

The main script must run dependencies check and warn if something is missing. For example, below we check python version with a regex and crash if the check fails:
````bash
python3 --version | grep -E "Python 3.([7-9]|1[0-1])\..*" >/dev/null ||  { echo "Python version is not between 3.7 and 3.11"; exit 2; }
````

## Scripts List 
Here is a non-exhaustive list of scripts implemented in the repos and their main purpose. 
There are additional readme files into scripts directory. Those readmes explain scripts fine-graded manipulation:
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
- at the moment, the objective of the repo is not to provide production grade code, but handy scripts to execute on the flight.
