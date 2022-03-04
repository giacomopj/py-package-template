# Get input Python version for base image
ARG PYTHON_VERSION=3.10.2

# Set base image
FROM python:${PYTHON_VERSION}-slim AS base
LABEL maintainer="Giacomo Pojani < giacomo.pj@hotmail.it>"

# Get input parameters
# CONTEXT defines the stage context environment (e.g., run, debug, test)
# USER_NAME defines user name
# POETRY_VERSION defines Poetry version
ARG CONTEXT=run
ARG USER_NAME=developer
ARG POETRY_VERSION=1.1.13

# Set environment variables
ENV CONTEXT=$CONTEXT \
# Python variables
PYTHONDONTWRITEBYTECODE=1 \
PYTHONFAULTHANDLER=1 \
PYTHONUNBUFFERED=1 \
PYTHONHASHSEED=random \
PYTHONPATH="${PYTHONPATH}:/opt/app" \
# Pip variables
PIP_NO_CACHE_DIR=off \
PIP_DISABLE_PIP_VERSION_CHECK=on \
PIP_DEFAULT_TIMEOUT=100 \
# Poetry variables
POETRY_VERSION=${POETRY_VERSION} \
POETRY_VIRTUALENVS_CREATE=false \
POETRY_HOME="/opt/poetry" \
# POETRY_CACHE_DIR='/var/cache/pypoetry' \
POETRY_NO_INTERACTION=1 \
# Application variables
APP_PATH="/opt/app"

# Prepend Poetry and virtual environment paths
ENV PATH="${POETRY_HOME}/bin:${PATH}"

# Install system dependencies for base image
RUN apt-get update && \
apt-get upgrade -y && \
apt-get install --no-install-recommends && \
apt-get install -y gcc && \
apt-get install -y git && \
pip3 install pip wheel setuptools

# Install Poetry
RUN pip3 install poetry==${POETRY_VERSION}

# Set application path as working directory
WORKDIR $APP_PATH

# Copy list of dependencies into the working directory
COPY pyproject.toml poetry.lock ./

# Disable virtual environment creation
RUN poetry config virtualenvs.create false

# Update versions of the dependencies (if needed)
# --lock Only update .lock file without installing
RUN poetry update $(test "$CONTEXT" != test && echo "--no-dev") --lock

# Install dependencies
# --no-root Set installation to regular mode instead of editable mode
# --no-interaction Turn off interactive questions
# --no-ansi Disable ANSI output
RUN poetry install $(test "$CONTEXT" != test && echo "--no-dev") --no-interaction --no-ansi --no-root

# Copy all files
COPY . .

# Set pre-commit and pre-push hooks
RUN if [ "$CONTEXT" == test ] ; then \
pre-commit install -t pre-commit && \
pre-commit install -t pre-push ; fi

# ---

# Set debuger image
FROM base AS debugger

# Expose port of debugger
EXPOSE 5678

# Set debugger as entry point
ENTRYPOINT [ "python", "-m", "debugpy", "--listen", "0.0.0.0:5678", "--wait-for-client", "-m" ]

# ---

# Set runner image
FROM base AS runner

ENTRYPOINT [ "python", "-m", "src"]

# ---

# Set tester image
FROM base AS tester

# Install optional dependencies for automatic documentation
RUN poetry install --extras docs --no-interaction --no-ansi --no-root

# Grant execution permission to start-up script
RUN chmod +x ./scripts/start.sh

# Execute script at container start-up
CMD ["./scripts/start.sh"]
