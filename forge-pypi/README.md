# forge-pypi

This project provides a private PyPI repo based on [pywharf](https://pypi.org/project/pywharf/)

## Prerequisites

The only prerequisite for this is the ability to run Docker containers.

## Set Up

### Step 1 - config.toml
Create `./config.toml` with the following content:

```
[forge-pypi]
type = "file_system"
read_secret = "foo"
write_secret = "bar"
```

Replace `foo` and `bar` with randomized values.

### Step 2 - admin.toml
Create `./admin.toml` with the following content:

```
[forge-pypi]
type = "file_system"
raw = "foobar"
```

Replace `foobar` with a randomized value.

### Step 3 - Build a Docker image
As a user with Docker permissions, run:

```
docker build -t forge-pypi .
```

### Step 4 - Run it!
As a user with Docker permissions, run:

```
docker run --rm -v "$(pwd)/pywharf-root":/pywharf-root -p 60001:60001 forge-pypi
```

## How to Use It

### Poetry

#### Publishing Projects
Configure your local poetry environment:

```
poetry config repositories.forge-pypi http://localhost:60001/simple/
poetry config http-basic.forge-pypi forge-pypi <write_secret>
```

Then once you have built your project, you can publish it like so:

```
poetry publish -r forge-pypi
```

#### Downloading Projects
Add the repo to your `pyproject.toml` like so:

```
[[tool.poetry.source]]
name = 'forge-pypi'
url = 'http://localhost:600001/simple/
```

Then add the dependency:

```
poetry add digital-forge-foo
```