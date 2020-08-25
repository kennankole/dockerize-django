FROM python:3.8.2-alpine

#creates and sets a working directory. 
WORKDIR /usr/src/app

#removes .pyc files from the container. good for optimization
ENV PYTHONDONTWRITEBYTECODE 1 

#buffers the output so it will look normal within Docker 
ENV PYTHONUNBUFFERED 1



RUN apk update \
    && apk add postgresql-dev gcc python3-dev musl-dev

#install dependencies 
RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN pip install -r requirements.txt 

#copy entrypoint.sh
COPY ./entrypoint.sh .

#Copy the project
COPY . .

ENTRYPOINT [ "/usr/src/app/entrypoint.sh" ]