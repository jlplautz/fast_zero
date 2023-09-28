


poetry new fast_zero
cd fast_zero

tree -L 1
pyenv global
pyenv local
code .

poetry install
poetry shell
poetry add fastapi uvicorn
uvicorn fast_zero.app:app --reload
poetry add --group dev pytest pytest-cov taskipy blue ruff httpx isort
