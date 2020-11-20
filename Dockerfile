FROM python:3.8
WORKDIR /usr/src/app
RUN groupadd --gid 5000 lmuser \
    && useradd --home-dir /home/lmuser --create-home --uid 5000 \
    --gid 5000 --shell /bin/sh --skel /dev/null lmuser
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 8080
USER lmuser
CMD [ "uvicorn", "main:app", "--reload", "--port", "8080", "--host", "0.0.0.0" ]