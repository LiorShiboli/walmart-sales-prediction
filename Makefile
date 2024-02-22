SHELL:=/usr/bin/env bash -O globstar

# Clean the project from cache
clean:
	rm -rf .pytest_cache
	rm -rf .mypy_cache
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +
	find . -name '.ipynb_checkpoints' -exec rm -fr {} +

isort:
	python -m isort src

black:
	 python -m black src

fix: isort black

flake8:
	python -m flake8 src

black-check:
	 python -m black --check --diff src

mypy:
	python -m mypy src

lint: flake8 black-check mypy

# Run the formatters and linters
fix-lint: fix lint

# Run the tests
jupyter: clean
	jupyter-lab

run: clean
	python -m src.main
