## docker-homework-02

#### 1. docker build ./ -t flask_app

```
Sending build context to Docker daemon  103.4kB
Step 1/13 : FROM python:3.9
 ---> 1e76b28bfd4e
Step 2/13 : RUN pip install flask
 ---> Using cache
 ---> c93ccba048d0
Step 3/13 : COPY . /app
 ---> ad268f562fe3
Step 4/13 : WORKDIR /app
 ---> Running in b6f6465488a4
Removing intermediate container b6f6465488a4
 ---> 409a9598fdfa
Step 5/13 : ADD static /static
 ---> e5cbd41e0526
Step 6/13 : VOLUME /templates
 ---> Running in dfe4f0eb6ae8
Removing intermediate container dfe4f0eb6ae8
 ---> 0d5b02534cb4
Step 7/13 : ENV FLASK_APP=app
 ---> Running in b5672baa972d
Removing intermediate container b5672baa972d
 ---> 8d96d53aa346
Step 8/13 : ENV DATABASE_URL=sqlite:///database.db
 ---> Running in 034562779a90
Removing intermediate container 034562779a90
 ---> 856ed3ff42e6
Step 9/13 : EXPOSE 5000:5000
 ---> Running in 0db32ef3178a
Removing intermediate container 0db32ef3178a
 ---> c65b3d11873c
Step 10/13 : RUN ls -latr /app
 ---> Running in f5225c37ca8b
total 56
drwxr-xr-x 3 root root  4096 Aug 21 20:32 static
-rw-r--r-- 1 root root   204 Aug 21 20:32 schema.sql
-rw-r--r-- 1 root root   472 Aug 21 20:32 init_db.py
-rw-r--r-- 1 root root 12288 Aug 21 20:32 database.db
-rw-r--r-- 1 root root  2220 Aug 21 20:32 base.html
-rw-r--r-- 1 root root  2432 Aug 21 20:32 app.py
-rw-r--r-- 1 root root    22 Aug 21 20:32 README.md
drwxr-xr-x 8 root root  4096 Aug 21 20:32 .git
drwxr-xr-x 2 root root  4096 Aug 22 20:59 templates
-rw-r--r-- 1 root root   252 Aug 22 21:00 Dockerfile
drwxr-xr-x 5 root root  4096 Aug 22 21:01 .
drwxr-xr-x 1 root root  4096 Aug 22 21:01 ..
Removing intermediate container f5225c37ca8b
 ---> f69017db162a
Step 11/13 : RUN python ./init_db.py
 ---> Running in f11702d8d42e
Removing intermediate container f11702d8d42e
 ---> e086ba7a1a0d
Step 12/13 : ENTRYPOINT ["python"]
 ---> Running in 76ba9b63ce1e
Removing intermediate container 76ba9b63ce1e
 ---> c9626d5a6d01
Step 13/13 : CMD ["app.py"]
 ---> Running in fdd377ec5224
Removing intermediate container fdd377ec5224
 ---> ca042bec6b78
Successfully built ca042bec6b78
Successfully tagged flask_app:latest
```

#### 2. Run the image locally

```
docker run -d -p 5000:5000 -v=/home/devops/docker-homework-02/templates:/app/templates:rw flask_app
```

#### 3. Improve existing Dockerfile - 

```
docker build -f Dockerfile_slim . -t flask_app_slim

Sending build context to Docker daemon  103.9kB
Step 1/13 : FROM python:3.9-alpine
 ---> d4d6be1b90ec
Step 2/13 : RUN pip install flask
 ---> Running in d001779ffb48
Collecting flask
  Downloading Flask-2.0.1-py3-none-any.whl (94 kB)
Collecting itsdangerous>=2.0
  Downloading itsdangerous-2.0.1-py3-none-any.whl (18 kB)
Collecting Werkzeug>=2.0
  Downloading Werkzeug-2.0.1-py3-none-any.whl (288 kB)
Collecting click>=7.1.2
  Downloading click-8.0.1-py3-none-any.whl (97 kB)
Collecting Jinja2>=3.0
  Downloading Jinja2-3.0.1-py3-none-any.whl (133 kB)
Collecting MarkupSafe>=2.0
  Downloading MarkupSafe-2.0.1.tar.gz (18 kB)
Building wheels for collected packages: MarkupSafe
  Building wheel for MarkupSafe (setup.py): started
  Building wheel for MarkupSafe (setup.py): finished with status 'done'
  Created wheel for MarkupSafe: filename=MarkupSafe-2.0.1-py3-none-any.whl size=9761 sha256=45749b35debff8879c1f9f1d0ef7e296735c943e4f9fb02ee8680a7876c4624b
  Stored in directory: /root/.cache/pip/wheels/9f/6d/c8/1f59b07cf85ae842908006ec28f4477f7e4578df72c3eb0e46
Successfully built MarkupSafe
Installing collected packages: MarkupSafe, Werkzeug, Jinja2, itsdangerous, click, flask
WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv
Successfully installed Jinja2-3.0.1 MarkupSafe-2.0.1 Werkzeug-2.0.1 click-8.0.1 flask-2.0.1 itsdangerous-2.0.1
Removing intermediate container d001779ffb48
 ---> aa28761a3549
Step 3/13 : COPY . /app
 ---> 0c3605660c2f
Step 4/13 : WORKDIR /app
 ---> Running in 30c1110ecc24
Removing intermediate container 30c1110ecc24
 ---> ea1a7914d6c0
Step 5/13 : ADD static /static
 ---> 4cd6dff2fd10
Step 6/13 : VOLUME /templates
 ---> Running in 31928bd35a69
Removing intermediate container 31928bd35a69
 ---> ea27d8933c6d
Step 7/13 : ENV FLASK_APP=app
 ---> Running in 43785e659238
Removing intermediate container 43785e659238
 ---> 838b01ca19f8
Step 8/13 : ENV DATABASE_URL=sqlite:///database.db
 ---> Running in 9f046fe585ab
Removing intermediate container 9f046fe585ab
 ---> 089344897e72
Step 9/13 : EXPOSE 5000
 ---> Running in 5bf5206bbfc6
Removing intermediate container 5bf5206bbfc6
 ---> ca48da3f15cb
Step 10/13 : RUN ls -latr /app
 ---> Running in 39ebcdc54d3c
total 60
drwxr-xr-x    3 root     root          4096 Aug 21 20:32 static
-rw-r--r--    1 root     root           204 Aug 21 20:32 schema.sql
-rw-r--r--    1 root     root           472 Aug 21 20:32 init_db.py
-rw-r--r--    1 root     root         12288 Aug 21 20:32 database.db
-rw-r--r--    1 root     root          2220 Aug 21 20:32 base.html
-rw-r--r--    1 root     root          2432 Aug 21 20:32 app.py
-rw-r--r--    1 root     root            22 Aug 21 20:32 README.md
drwxr-xr-x    8 root     root          4096 Aug 21 20:32 .git
-rw-r--r--    1 root     root           252 Aug 22 21:00 Dockerfile
drwxr-xr-x    2 root     root          4096 Aug 22 21:09 templates
-rw-r--r--    1 root     root           254 Aug 22 21:14 Dockerfile_slim
drwxr-xr-x    5 root     root          4096 Aug 22 21:16 .
drwxr-xr-x    1 root     root          4096 Aug 22 21:16 ..
Removing intermediate container 39ebcdc54d3c
 ---> a32d12bf7125
Step 11/13 : RUN python ./init_db.py
 ---> Running in 3f5134afaf00
Removing intermediate container 3f5134afaf00
 ---> 4d5366519caf
Step 12/13 : ENTRYPOINT ["python"]
 ---> Running in b35fd68f77e7
Removing intermediate container b35fd68f77e7
 ---> 10392e228b14
Step 13/13 : CMD ["app.py"]
 ---> Running in dc6f2ef26acc
Removing intermediate container dc6f2ef26acc
 ---> 5f23b6fe256b
Successfully built 5f23b6fe256b
Successfully tagged flask_app_slim:latest
```

#### 5. compare the size of previous and new image

```
docker images

REPOSITORY                   TAG                  IMAGE ID           CREATED              SIZE
flask_app_slim               latest               5f23b6fe256b        About a minute ago   57MB
flask_app                    latest               ca042bec6b78        16 minutes ago       922MB
```

#### 6. create docker-compose.yaml

To build this project into a docker container please run the following command

```
docker-compose up --build -d
```

A sample output should look like:

```
 docker-compose up --build -d


Building web
Step 1/13 : FROM python:3.9-alpine
 ---> d4d6be1b90ec
Step 2/13 : RUN pip install flask
 ---> Using cache
 ---> aa28761a3549
Step 3/13 : COPY . /app
 ---> e0e0b99a6dea
Step 4/13 : WORKDIR /app
 ---> Running in 1582de71c74b
Removing intermediate container 1582de71c74b
 ---> 004f4c215cdd
Step 5/13 : ADD static /static
 ---> e57f11f33bbd
Step 6/13 : VOLUME /templates
 ---> Running in aae72a05dcfd
Removing intermediate container aae72a05dcfd
 ---> 9afea1cd5846
Step 7/13 : ENV FLASK_APP=app
 ---> Running in eb648dde9aeb
Removing intermediate container eb648dde9aeb
 ---> 131bfdebd3c6
Step 8/13 : ENV DATABASE_URL=sqlite:///database.db
 ---> Running in 7e5191febb28
Removing intermediate container 7e5191febb28
 ---> d354c4767f84
Step 9/13 : EXPOSE 5000
 ---> Running in 5b9fffbad702
Removing intermediate container 5b9fffbad702
 ---> 0c8616bf02e4
Step 10/13 : RUN ls -latr /app
 ---> Running in 91917e0cbbda
total 64
drwxr-xr-x    3 root     root          4096 Aug 21 20:32 static
-rw-r--r--    1 root     root           204 Aug 21 20:32 schema.sql
-rw-r--r--    1 root     root           472 Aug 21 20:32 init_db.py
-rw-r--r--    1 root     root         12288 Aug 21 20:32 database.db
-rw-r--r--    1 root     root          2220 Aug 21 20:32 base.html
-rw-r--r--    1 root     root          2432 Aug 21 20:32 app.py
-rw-r--r--    1 root     root            22 Aug 21 20:32 README.md
drwxr-xr-x    8 root     root          4096 Aug 21 20:32 .git
-rw-r--r--    1 root     root           252 Aug 22 21:00 Dockerfile
drwxr-xr-x    2 root     root          4096 Aug 22 21:09 templates
-rw-r--r--    1 root     root           254 Aug 22 21:14 Dockerfile_slim
-rw-r--r--    1 root     root           307 Aug 22 21:49 docker-compose.yaml
drwxr-xr-x    5 root     root          4096 Aug 22 21:49 .
drwxr-xr-x    1 root     root          4096 Aug 22 21:49 ..
Removing intermediate container 91917e0cbbda
 ---> 3c48230ba7d3
Step 11/13 : RUN python ./init_db.py
 ---> Running in 030c9a571a75
Removing intermediate container 030c9a571a75
 ---> 20fb0de32ab7
Step 12/13 : ENTRYPOINT ["python"]
 ---> Running in 8f0e31c37b3b
Removing intermediate container 8f0e31c37b3b
 ---> 7adacddb1b0b
Step 13/13 : CMD ["app.py"]
 ---> Running in caf74375d0f0
Removing intermediate container caf74375d0f0
 ---> bb2c6b6298f6
Successfully built bb2c6b6298f6
Successfully tagged docker-homework-02_web:latest
Recreating docker-homework-02_web_1 ... done

docker-compose ps

          Name                Command      State           Ports
-------------------------------------------------------------------------
docker-homework-02_web_1   python app.py   Up      0.0.0.0:5000->5000/tcp

```

