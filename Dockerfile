FROM python:3.9
SHELL ["/bin/bash", "-c"]
# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
RUN mkdir -p /app
COPY driverplan/manage.py /app
COPY driverplan/requirements.txt /app
COPY driverplan/driverplan /app/driverplan
RUN apt update
RUN apt full-upgrade -y
RUN apt install -y python3 pip pkg-config
RUN apt install -y python3-dev default-libmysqlclient-dev build-essential
WORKDIR /app
RUN pip install Django mysqlclient pyTelegramBotAPI python-decouple
CMD python3 manage.py migrate --noinput && python3 manage.py collectstatic --noinput && python3 manage.py runserver 0.0.0.0:8000
EXPOSE 8000
