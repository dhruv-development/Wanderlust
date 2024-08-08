#base image
FROM python:3.11-slim

#working directive
WORKDIR /app

#copy code to container
COPY . .

#required libraries
RUN pip install -r requirements.txt

#Run
CMD ["python","app.py"]

