FROM openstax/python3-poetry:20210714.164853 as base

FROM base as builder

# change working directory
WORKDIR /build

# create Virtualenv
RUN python -m venv /opt/venv && \
  . /opt/venv/bin/activate && \
  pip install --no-cache-dir -U pip

COPY ./pyproject.toml /
COPY ./poetry.lock /

RUN . /opt/venv/bin/activate && poetry install --no-root --no-interaction

# start a new build stage
FROM base as runner

# Set env variables
ENV PATH="/opt/venv/bin:$PATH"
ENV PYTHONIOENCODING utf_8
ENV PYTHONPATH /app:$PYTHONPATH
ENV PATH="/app/bin:${PATH}"
ENV FLASK_APP=/app/wsgi.py

# copy everything from /opt
COPY --from=builder /opt/venv /opt/venv
COPY ./bin/docker-entrypoint.sh .
COPY ./app/ .

RUN chmod +x /docker-entrypoint.sh

WORKDIR /app

CMD ["/docker-entrypoint.sh", "wsgi:app"]
