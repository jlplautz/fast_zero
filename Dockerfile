FROM python:3.11-slim

ENV  POETRY_VIRTUALENVS_CREATE=false
ENV ALGORITHM=HS256
ENV SECRET_KEY=your-secret-key
ENV ACCESS_TOKEN_EXPIRE_MINUTES=30

RUN pip install poetry

COPY . .

RUN poetry config installer.max-workers 10
RUN poetry install --no-interaction --no-ansi

EXPOSE 8000
CMD [ "poetry", "run", "uvicorn", "--host", "0.0.0.0", "fast_zero.app:app" ]
