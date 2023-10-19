# # Use an official Python runtime as a parent image
# FROM python

# # Set the working directory to /app
# WORKDIR /app

# # Copy the current directory contents into the container at /app
# COPY . /app

# # Install any needed packages specified in requirements.txt
# RUN pip install -r requirements.txt

# # Expose port 5000 for the Flask application
# EXPOSE 5000

# # Define environment variables
# ENV MYSQL_HOST=mysql
# ENV MYSQL_USER=root
# ENV MYSQL_ROOT_PASSWORD=password
# ENV MYSQL_DATABASE=my_db

# # Run the Flask application
# CMD ["python", "app.py"]


FROM python
COPY . /app
WORKDIR /app
RUN python setup.py sdist bdist_wheel
RUN pip install -r requirements.txt
# WORKDIR /app/dist
RUN pip install dist/flask_app-*.tar.gz  
RUN pip install dist/flask_app-*.whl  
# WORKDIR /app
EXPOSE  5000
# Define environment variables
ENV MYSQL_HOST=mysql
ENV MYSQL_USER=root
ENV MYSQL_ROOT_PASSWORD=password
ENV MYSQL_DATABASE=my_db
CMD ["python", "-m" ,"app"]