# Get input parameters outside image
ARG PYTHON_VERSION=3.10.2

# Set base image
FROM python:${PYTHON_VERSION}-slim

# Get input parameters inside image
ARG TAG
ARG USER=developer
ARG POETRY_VERSION=1.1.13

# Set environment variables
ENV TAG=$TAG \
    # Python flags
    PYTHONFAULTHANDLER=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONHASHSEED=random \
    # Pip flags
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    # Poetry flags
    POETRY_VERSION=${POETRY_VERSION} \
    POETRY_VIRTUALENVS_CREATE=false \
    POETRY_CACHE_DIR='/var/cache/pypoetry'

RUN apt-get update
RUN apt-get install -y gcc
RUN apt-get -y install git
RUN pip3 install setuptools

# Install Poetry
RUN pip3 install poetry==${POETRY_VERSION}
ENV PATH="${PATH}:/root/.poetry/bin"

# Set working directory
WORKDIR /app

# Copy dependencies to the working directory
COPY pyproject.toml poetry.lock .

# Disable virtual environment creation
RUN poetry config virtualenvs.create false

# Install dependencies
RUN poetry install --no-root
RUN poetry update

# Copy everything to the working directory
COPY . .

# Set pre-commit and pre-push hooks
RUN pre-commit install -t pre-commit
RUN pre-commit install -t pre-push

# Set entry point (if needed)
# ENTRYPOINT python -m src

# Execute script at container start-up
RUN chmod +x ./scripts/start.sh
CMD ["./scripts/start.sh"]
