FROM python:3.10
RUN pip install --upgrade pip

RUN useradd -m -s /bin/bash -G sudo -p $(openssl passwd -1 password) meander
USER meander
ENV PATH="/home/meander/.local/bin:${PATH}"

WORKDIR /app

COPY --chown=meander:meander requirements.txt requirements.txt
RUN pip install --user -r requirements.txt
RUN export FLASK_APP=app

COPY --chown=meander:meander . .
CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0", "--port=5000" ]

LABEL org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.title="seismos" \
      org.opencontainers.image.authors="hyena <hyena>" \
      org.opencontainers.image.source="https://github.com/thefueley/meander" \
      org.opencontainers.image.revision="${BUILD_REF}" \
      org.opencontainers.image.vendor="SEISMOS"