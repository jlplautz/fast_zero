


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

## Autenticação e Autorização
poetry add "python-jose[cryptography]" "passlib[bcrypt]"
poetry add python-multipart


## Criando a mingração da nova tabela
❯ alembic revision --autogenerate -m "create todos table"
INFO  [alembic.runtime.migration] Context impl SQLiteImpl.
INFO  [alembic.runtime.migration] Will assume non-transactional DDL.
INFO  [alembic.autogenerate.compare] Detected added table 'todos'
  Generating /home/plautz/Proj_2023/fast_zero/migrations/versions/ed810ad38404_create_todos_table.py ...  done

## Aplicar a mingração
❯ alembic upgrade head
INFO  [alembic.runtime.migration] Context impl SQLiteImpl.
INFO  [alembic.runtime.migration] Will assume non-transactional DDL.
INFO  [alembic.runtime.migration] Running upgrade 2dd4b740b56c -> ed810ad38404, create todos table

## Criar Dockerfile e cmd para criar a imagem
docker build -t "fast_zero" .


## Rodando uma imagem
docker run -p 8000:8000 fast_zero:latest

## Deploy into FLY.io
fly auth login
fly launch
fly deploy --local-only
fly secrets list
fly ssh console -app jlp-fastzero
