# Flask Blog

Docker Home Work

## How to run the project on Unix-like OS:

```
install python3
install pip
install flask
export FLASK_APP=app 
flask run
```
Open in browser: http://localhost:5000/

Web interface allows to create, edit and delete posts.

## Task description:

1. Make sure you can run the application locally using the manual above.
2. Dockerize 'Flask_blog' application:
- create Dockerfile and put it in your repository;
- use volume to store 'templates' folder;
- build docker image; use tag for the image; put the result command in README.md file;
- run container on local machine; put the result command in README.md file;
- test the application; make sure the application works and you can create, edit posts; check the volume - rename some templates and check the application;
- improve existing dockerfile;
- build docker image and use different tag; compare the size of previous and new image;
- create Compose file;
- Update README.md file and add information how to run application using Docker Compose;

Deadline: August 22
