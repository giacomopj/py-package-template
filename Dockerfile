# Get input Python version for base image
ARG PYTHON_VERSION=3.10.2

# Set base image
FROM python:${PYTHON_VERSION}-slim AS base
LABEL maintainer="Giacomo Pojani <giacomo.pj@hotmail.it>"

# Get input parameters
# CONTEXT defines the stage context environment (e.g., run, debug, test)
ARG CONTEXT=run
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
POETRY_VIRTUALENVS_CREATE=true \
POETRY_HOME="/opt/poetry" \
POETRY_CACHE_DIR='/var/cache/pypoetry' \
POETRY_NO_INTERACTION=1 \
# Application variables
APP_PATH="/opt/app" \
VIRTUAL_ENV="/opt/app/venv"

# Prepend Poetry and virtual environment paths
ENV PATH="${POETRY_HOME}/bin:${VIRTUAL_ENV}/bin:${PATH}"

# Install essential dependencies
RUN apt-get update && \
apt-get upgrade -y && \
apt-get install -y build-essential git gcc g++ libffi-dev musl-dev && \
pip3 install pip wheel setuptools

# Install Poetry
RUN pip3 install poetry==${POETRY_VERSION}

# Set application path as working directory
WORKDIR $APP_PATH

# Enable virtual environment creation
RUN poetry config virtualenvs.create true

# Set virtual environment path
RUN poetry config virtualenvs.path $VIRTUAL_ENV

# Create virtual environment
RUN python -m venv $VIRTUAL_ENV

# Copy list of dependencies into the working directory
COPY pyproject.toml poetry.lock ./

# Update versions of the dependencies (if needed)
RUN poetry update $(test "$CONTEXT" != test && echo "--no-dev") --lock -vvv

# Install dependencies
#  RUN poetry install $(test "$CONTEXT" != test && echo "--no-dev") --no-interaction --no-ansi --no-root -vvv

# Export dependencies from Poetry and install them with Pip
RUN poetry export --without-hashes -f $(test "$CONTEXT" == test && echo "--dev") requirements.txt | \
$VIRTUAL_ENV/bin/pip install -r /dev/stdin

# Copy all files
COPY . ./

# Build a wheel with Poetry and then install it with Pip
RUN poetry build && $VIRTUAL_ENV/bin/pip install dist/*.whl

# Set pre-commit and pre-push hooks
RUN if [ "$CONTEXT" == test ] ; then \
pre-commit install -t pre-commit && \
pre-commit install -t pre-push ; fi

# ---

# Set debugger image
FROM base AS debugger

# Copy environment
COPY --from=base $VIRTUAL_ENV $VIRTUAL_ENV
ENV PATH="${POETRY_HOME}/bin:${VIRTUAL_ENV}/bin:${PATH}"

# Expose port of debugger
EXPOSE 5678

# Grant execution permission to start-up script
RUN chmod +x ./scripts/debugger.sh

# Execute script at container start-up
CMD ["./scripts/debugger.sh"]

# ---

# Set runner image
FROM base AS runner

# Copy environment
COPY --from=base $VIRTUAL_ENV $VIRTUAL_ENV
ENV PATH="${POETRY_HOME}/bin:${VIRTUAL_ENV}/bin:${PATH}"

# Grant execution permission to start-up script
RUN chmod +x ./scripts/runner.sh

# Execute script at container start-up
CMD ["./scripts/runner.sh"]

# ---

# Set tester image
FROM base AS tester

# Install optional dependencies for automatic documentation
RUN poetry install --extras docs --no-interaction --no-ansi --no-root

# Copy environment
COPY --from=base $VIRTUAL_ENV $VIRTUAL_ENV
ENV PATH="${POETRY_HOME}/bin:${VIRTUAL_ENV}/bin:${PATH}"

# Grant execution permission to start-up script
RUN chmod +x ./scripts/tester.sh

# Execute script at container start-up
CMD ["./scripts/tester.sh"]
