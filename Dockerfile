FROM python:3.14-slim

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
WORKDIR /app

# Copy dependency metadata first
COPY pyproject.toml uv.lock /app/

# Install dependencies into the system interpreter (no venv)
ENV UV_SYSTEM_PYTHON=1
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --locked --no-install-project

# Copy the app and install project (non-editable)
COPY . /app
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --locked --no-editable

ENV VIRTUAL_ENV=/app/.venv
ENV PATH="/app/.venv/bin:${PATH}"

CMD ["sh", "./startup.sh"]
