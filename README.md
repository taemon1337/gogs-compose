# gogs-compose
## Private Github Clone with Gogs and Docker in 10 Steps

The setup for this project assumes a blank Linux host (ubuntu 16.04) with git installed.

First, we'll install docker, which includes docker-compose.  Then we'll start the gogs and postgres containers as defined in the docker-compose.yml file.  They will mount host volumes from /tmp/gogs-data and /tmp/gogs-postgres for persistence.  Then modify the pg_hba.conf file to allow remote login to gogs database and restart container.  Then login to gogs web app and configure it to talk to postgres.


1. Clone repository
```
  git clone git@github.com:taemon1337/gogs-compose.git
  cd gogs-compose/
```

2. Install Docker
```
  ./bin/install_docker.sh
  docker -v
  docker-compose -v
```

3. Start docker-compose up
```
  docker-compose up
```

4. Stop docker-compose up
```
  <Ctrl+C>
```

5. Modify pg_hba.conf at /tmp/gogs-postgres/pg_hba.conf
```
  host  gogs  postgres  md5
```

6. Restart docker-compose up
```
  docker-compose up
```
7. Visit Local Gogs web page
```
  http://127.0.0.1:3000/
```

8. Enter the following values into the Gogs web first-time run config
```
  Database Type:    'PostgreSQL'            # select from dropdown
  Host:             'postgres:5432'         # must match docker-compose.yml link
  User:             'postgres'              # must match docker-compose.yml POSTGRES_USER and pg_hba.conf
  Password:         'password123'           # must match docker-compose.yml POSTGRES_PASSWORD
  Database Name:    'gogs'                  # must match docker-compose.yml POSTGRES_DB and pg_hba.conf
  Domain:           <domain-name>           # option so that git remote add '<domain-name>' is correct
  Application URL:  <machine-ip>:3000       # option so that links/redirects in gogs are accurate
```

9. Click 'Install Gogs'

10. Create account, login and enjoy Gogs!


## Additional Tasks
If you are actually going to use Gogs in a production or production-like environment, you will need complete the following tasks:

#### Volume Storage
In the provided docker-compose.yml file, a host volume is mapped from /tmp/gogs-data and /tmp/gogs-postgres. You will want to make sure you have a robust storage mechanism (like Convoy/NFS, RAID volume, or w/e).

#### Docker Swarm
In addition, I've included a docker-swarm.yml compose version 3.1 file which can be deployed on a Docker Swarm if you go that route.  In this file, I'm using the convoy NFS plugin for swarm nodes to use for storage.

#### Logging, Backup, Security, and Performance
In a real production environment, you want to take care of logging, backups, and securing the environment as well.  You will also want to make your system has the performance to support your workload, but all these are outside the scope of this demo.

