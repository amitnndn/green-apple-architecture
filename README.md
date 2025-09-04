## Green Apple Architecture

### Local Setup
1. Pull `structurizr/lite` docker image. 
```sh 
docker pull structurizr/lite
```
2. Run structurizr docker image
```sh 
docker run -it --rm -p 8080:8080 -v $(pwd):/usr/local/structurizr structurizr/lite
```
3. Navigate to [localhost:8080](http://localhost:8080) to view the documents. 
