## upload-logs

This script set a cronjob to upload hourly logs from a machine to a bucket. The script can be run manually as well.

- user story :<br/>
*I want to upload docker container log to some data store.*

- installation (linux)
```bash
curl https://github.com/MarcelNasser/ops-scripts/main/upload-logs/install |sudo bash
```

- script run
````bash
sudo upload-logs -u username -p password -i image_name [-d directory -c container_name -n namespace]

    Retrieve and upload a docker container log to the specific endpoint <$ENDPOINT_URL>
    Arguments:
        - u: login's username [required]
        - p: login's password or access token [required]
        - d: directory [optional]
        - c: container's name [optional]
        - i: image's name [optional]
        - n: remote storage's namespace [optional][default::production]
        --dry-run: display logs location without doing anything
````