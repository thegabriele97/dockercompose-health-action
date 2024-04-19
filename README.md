# GitHub Action for waiting for Docker-Compose Health Services

This is a very simple action to wait until all the services given by Docker Compose are Up and Healthy before moving on in your workflow.

It accepts two arguments:
 - **filename**: The docker-compose filename. Default: 'docker-compose.yml'
 - **timeout**: After timeout seconds, the wait process fails returning Status Code 1
 - **workdir**: The directory where your docker-compose.yml is

## Usage
```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - name: Check services healthiness
        uses: thegabriele97/dockercompose-health-action@main
        with:
          filename: 'docker-compose.test.yml'
          timeout: '60'
          workdir: 'src'
```

## License

This project is distributed under the [MIT license](LICENSE.md).