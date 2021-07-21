## backup docker registry
- user story :<br/>
*I want to backup an entire docker registry into google drive.*
- requirements : 
	- docker-cli
	- python3
	- bash

**set the registry auth**
if a basic authentication is protecting the registry server. Put the admin credentials into the env as follow:
```bash
export REGISTRY_USERNAME=upstride
export REGISTRY_PASSWORD=secret
```

**get a Google Drive access token**
- create an application in the Google's console, then generate a client ID/client secret
- get a device_code and identification code to Google api endpoint:
```bash
curl -d "client_id=your_client_id_here&scope=https://www.googleapis.com/auth/drive.file" https://oauth2.googleapis.com/device/code
```
- authorize the device with the identification code provided
	- go the url: https://www.google.com/device
	- authorize the access to Google Drive to the application
	
- get the access token
```bash
curl -d client_id=your_client_id_here -d client_secret=your_client_secret_here -d device_code=your_device_code_here -d grant_type=urn%3Aietf%3Aparams%3Aoauth%3Agrant-type%3Adevice_code https://accounts.google.com/o/oauth2/token
```

**run the script**
```bash
bash backup-registry/run -h localhost:5000 -g google_drive_id -t access_token_here
```