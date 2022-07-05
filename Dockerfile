# Get input Python version for base image
ARG PYTHON_VERSION=3.10.2

# Set base image
FROM python:${PYTHON_VERSION}-slim AS base
LABEL maintainer="Giacomo Pojani <giacomo.pojani@spire.com>"

# Get input parameters
# CONTEXT defines the stage context environment (e.g., run, debug, test)
# POETRY_VERSION defines Poetry version
ARG CONTEXT=run
ARG POETRY_VERSION=1.1.13
ARG GIT_ACCESS_TOKEN=ghp_

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
pip3 install pip wheel setuptools --upgrade pip wheel setuptools

# Install ad-hoc dependencies for Cartopy installation
RUN apt-get install -y libproj-dev libgeos-dev && \
apt-get install -y proj-data proj-bin

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

# Add ad-hoc dependencies of Spire nsat repositories
RUN poetry add git+https://${GIT_ACCESS_TOKEN}@github.com/nsat/tlegen.git -vvv
RUN poetry add git+https://${GIT_ACCESS_TOKEN}@github.com/nsat/pypredict.git -vvv

# Install dependencies
#  RUN poetry install $(test "$CONTEXT" != test && echo "--no-dev") --no-interaction --no-ansi --no-root -vvv

# Export dependencies from Poetry and install them with Pip
RUN poetry export --without-hashes -f $(test "$CONTEXT" == test && echo "--dev") requirements.txt | \
$VIRTUAL_ENV/bin/pip install -r /dev/stdin --upgrade --no-cache-dir --use-deprecated=legacy-resolver

# Re-install Shapely to prevent Geos compatibility issues
RUN pip3 uninstall shapely -y -v && pip3 install --no-binary :all: shapely -v

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

# Update versions of the dependencies (if needed)
RUN poetry update --lock -vvv

# Install extra dependencies for automatic documentation
# RUN poetry install --extras docs --no-interaction --no-ansi --no-root

# Export extra dependencies from Poetry and install them with Pip
RUN poetry export --without-hashes --extras docs -f requirements.txt | \
$VIRTUAL_ENV/bin/pip install -r /dev/stdin --upgrade --no-cache-dir --use-deprecated=legacy-resolver

# Copy environment
COPY --from=base $VIRTUAL_ENV $VIRTUAL_ENV
ENV PATH="${POETRY_HOME}/bin:${VIRTUAL_ENV}/bin:${PATH}"

# Grant execution permission to start-up script
RUN chmod +x ./scripts/tester.sh

# Execute script at container start-up
CMD ["./scripts/tester.sh"]
