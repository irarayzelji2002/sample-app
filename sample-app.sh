#!/bin/bash

# Make and copy directories of the app to tempdir
mkdir tempdir
mkdir tempdir/templates
mkdir tempdir/static
cp sample_app.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

# Creating Dockerfile
echo "FROM python" > tempdir/Dockerfile
echo "RUN pip config --user set global.progress_bar off" >> tempdir/Dockerfile
echo "RUN pip install flask" >> tempdir/Dockerfile
echo "COPY ./static /home/myapp/static/" >> tempdir/Dockerfile
echo "COPY ./templates /home/myapp/templates/" >> tempdir/Dockerfile
echo "COPY sample_app.py /home/myapp/" >> tempdir/Dockerfile
echo "EXPOSE 5050" >> tempdir/Dockerfile
echo "CMD python3 /home/myapp/sample_app.py" >> tempdir/Dockerfile

# Building Docker container
cd tempdir
docker build -t sampleapp-jenkins .

# Starting Docker container
docker run -t -d -p 5050:5050 --name samplerunning-jenkins sampleapp-jenkins
docker ps -a