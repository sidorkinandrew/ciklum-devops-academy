FROM python:3.9
RUN pip install flask
COPY . /app
WORKDIR /app
ADD static /static
VOLUME /templates
ENV FLASK_APP=app
ENV DATABASE_URL=sqlite:///database.db
EXPOSE 5000
RUN ls -latr /app
RUN python ./init_db.py
ENTRYPOINT ["python"]
CMD ["app.py"]