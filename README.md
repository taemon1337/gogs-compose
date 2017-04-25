# gogs-compose
## Setup gogs with docker compose

### Host Machine Setup:
To complete/skip this step, you just need a host which can run docker containers.  Any linux host will do, but if you want to host it on another system you can use Virtualbox and Vagrant by doing the following:

1. Install Virtualbox
```
  DO IT YOURSELF
```
2. Install vagrant manually or use the provided install_vagrant.sh script.
```
  ./bin/install_vagrant.sh
```
3. After successful installation, start the VM and ssh into it using vagrant
```
  vagrant up
  vagrant ssh
```

### Docker Setup:
1. Install docker manually or use the provided installation script
```
  ./bin/install_docker.sh
  docker -v
```
2. Docker Compose should be installed along with Docker, but verify
```
  docker-compose -v
```

### Start Gogs and Postgres Containers:
```
  docker-compose up
```

### Configure Gogs and Postgres:
Gogs and Postgres both have small config option that need to be set to allow it to work correctly.

Note, you may want to change to docker-compose file to point to a non /tmp/ directory for persistant storage.

#### Configure Postgres
1. Edit pg_hba.conf
Edit the postgres host based authentication config in /tmp/gogs-postgres/pg_hba.conf to allow the postgres user to connect to the gogs database from the 172 network with username/password auth.
```
  #type database  username  network       auth
  host  gogs      postgres  172.0.0.0/8   md5
```
2. Restart postgres container
```
  # stop foreground docker-compose up
  <Ctrl+C>
  docker-compose up
```

#### Configure gogs
Navigate to gogs website to configure it.  Navigate to the host where gogs app is running (it may need be your VM's IP port 3000 for gogs)

  http://127.0.0.1:3000/

The first time it will redirect to the /install page, complete the following settings
1. Select Postgres for database
2. Enter 'postgres:5432' for 
3. Enter 'postgres' for username (must match pg_hba.conf)
4. Enter 'password123' for password (or change it in docker-compose.yml)
5. Enter 'gogs' for database name (must match pg_hba.conf)
6. Change the site url to match your browser bar (i.e. 'http://127.0.0.1:3000/') (used for links)
7. Optionally set Admin account
8. Click Install

If everything worked, it will go to home page where you can login or setup an account.





