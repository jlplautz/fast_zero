


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


git init .
git status
gh repo create
git remote -v
git remote add origin git@github.com:jlplautz/fast_zero.git 

git add .coverage fast_zero/ poetry.lock pyproject.toml
git status 
git add .gitignore README.md tests/
git status 
git commit -m 'feat(initial): Adding the first files into project.'

git branch -M master main
git push --set-upstream origin main
git push -f origin main
git checkout -b issue-1

poetry add "pydantic[email]"
git commit -m 'feat(issue-1): Created project structure and CRUD routes.'
git push origin issue-1
git checkout main
git pull origin main
git checkout -b issue-3
poetry add sqlalchemy
poetry add pydantic-settings
touch fast_zero/models.py
touch fast_zero/settings.py
poetry add alembic

## O comando de inicialização criará um diretório migrations
alembic init migrations

## Para criar a migração, utilizamos o seguinte comando:
alembic revision --autogenerate -m "create users table"

## Para aplicar as migrações, usamos o comando upgrade do CLI Alembic. 
## O argumento head indica que queremos aplicar todas as migrações que 
## ainda não foram aplicadas:
alembic upgrade head