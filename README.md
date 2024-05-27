# ROS2-dev-image
Some configurations in `docker-compose.yaml` are intended for Docker in MacOS,
and you need to reconfigure them as necessary if you are using a different OS.

## How to Use
Assume you already have Docker and docker-compose installed on your local machine.
- **Build** from Dockerfile (build only): 
```bash
docker compose build
```
- **Create** a new container (build included):
```bash
docker compose up -d
```
- **Start** an existing container (if available):
```bash
docker compose start
```
- **Enter** the container:
```bash
docker compose exec ros2-dev /bin/bash
```
- **Stop** a running container: 
```bash
docker compose stop
```
- **Remove** an existing container:
```bash
docker compose down
```

## Known Issues
- ~~an issue that you have to load `setup.bash` every time you launch a terminal window~~ (Fixed on 27th May)
