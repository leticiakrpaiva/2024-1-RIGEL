FROM python:3.12.3-alpine3.20
LABEL mantainer="mateusvillela.eng@gmail.com"

ARG DUSER_UID
ARG DUSER_GID
RUN echo "DUSER_UID=${DUSER_UID}"
RUN echo "DUSER_GID=${DUSER_GID}"

# SHELL ["/bin/bash", "-c"]

# Essa variável de ambiente é usada para controlar se o Python deve 
# gravar arquivos de bytecode (.pyc) no disco. 1 = Não, 0 = Sim
ENV PYTHONDONTWRITEBYTECODE 1

# Define que a saída do Python será exibida imediatamente no console ou em 
# outros dispositivos de saída, sem ser armazenada em buffer.
# Em resumo, você verá os outputs do Python em tempo real.
ENV PYTHONUNBUFFERED 1

# RUN mkdir -p /app

# Copia a pasta "driverplan" e "scripts" para dentro do container
COPY driverplan /driverplan
COPY scripts /scripts  
# COPY driverplan/manage.py /app
# COPY driverplan/requirements.txt /app
# COPY driverplan/driverplan /app/driverplan

# Entra na pasta driverplan no container
WORKDIR /driverplan

# A porta 800 estará disponível para conexões externas ao container
# É a porta que será usada para o django
EXPOSE 8000

# RUN executa comandos em um shell dentro do container para construir a imagem. 
# O resultado da execução do comando é armazenado no sistema de arquivos da 
# imagem como uma nova camada.
# Agrupar os comandos em um único RUN pode reduzir a quantidade de camadas da 
# imagem e torná-la mais eficiente.
#RUN adduser --disabled-password --no-create-home --uid $DUSER_UID --gid $DUSER_GID duser && \
RUN addgroup -g $DUSER_GID duser && \
    adduser -G duser -D -H -u $DUSER_UID duser && \
    mkdir -p /venv && \
    mkdir -p /data/web/static && \
    mkdir -p /data/web/media && \
    chown -Rv duser:duser /venv && \
    chown -v duser:duser /data/web && \
    chown -Rv duser:duser /data/web && \
    chmod -Rv 755 /data/web/static && \
    chmod -Rv 755 /data/web/media && \
    chmod -Rv +x /scripts && \
    chown -Rv duser:duser /driverplan

#RUN apt update
#RUN apt full-upgrade -y
#RUN apt install -y python3 pip pkg-config
#RUN apt install -y python3-dev default-libmysqlclient-dev build-essential

# Adiciona a pasta scripts e venv/bin 
# no $PATH do container.
ENV PATH="/scripts:/venv/bin:$PATH"

# Mudar o usuário para duser
USER duser

RUN python -m venv /venv && \
  /venv/bin/pip install --upgrade pip && \
  /venv/bin/pip install -r /driverplan/requirements.txt

# RUN pip install Django mysqlclient pyTelegramBotAPI python-decouple

# CMD python3 manage.py migrate --noinput && python3 manage.py collectstatic --noinput && python3 manage.py runserver 0.0.0.0:8000

CMD ["commands.sh"] 
