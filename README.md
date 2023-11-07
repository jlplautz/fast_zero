


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

fly secrets set DATABASE_URL=postgresql://postgres:postgres@localhost:5432/jlpapi-db

fly secrets set DATABASE_URL=postgresql://postgres:EcDwJNzlp8WxHSu@jlpfapi-db.internal:5432
fly secrets set SECRET_KEY=your-secret-key
fly secrets set ACCESS_TOKEN_EXPIRE_MINUTES=30
fly secrets set ALGORITHM=HS256

fly ssh console --app fastzerojp 'poetry run alembic upgrade head'


1- fly launch

Postgres cluster jlpfapi-db created
  Username:    postgres
  Password:    GtcgUQPlUgO6ZDD
  Hostname:    jlpfapi-db.internal
  Flycast:     fdaa:3:6eb5:0:1::a
  Proxy port:  5432
  Postgres port:  5433
  Connection string: postgres://postgres:GtcgUQPlUgO6ZDD@jlpfapi-db.flycast:5432

Save your credentials in a secure place -- you won't be able to see them again!

Connect to postgres
Any app within the Jorge Luiz Plautz organization can connect to this Postgres using the above connection string

Now that you've set up Postgres, here's what you need to understand: https://fly.io/docs/postgres/getting-started/what-you-should-know/
Checking for existing attachments
Registering attachment
Creating database
Creating user


2- corrigir DATABASE_URL postgres -> postgresql

❯ fly secrets set DATABASE_URL=postgresql://postgres:spPPWyw4gng7VQd@jlpfapi-db.flycast:5432
Secrets are staged for the first deployment

3- fly deploy

❯ fly status                                                                                
App
  Name     = jlpfapi                                        
  Owner    = personal                                       
  Hostname = jlpfapi.fly.dev                                
  Image    = jlpfapi:deployment-01HE8RARCD5J00AGZKNDYVAAJ8  
  Platform = machines                                       

Machines
PROCESS ID              VERSION REGION  STATE   ROLE    CHECKS  LAST UPDATED         
app     4d89116ec65118  1       gig     started                 2023-11-02T19:33:35Z
app     e784ee9ea253d8  1       gig     started                 2023-11-02T19:33:48Z


4-
❯ fly ssh console --app jlpfapi 'poetry run alembic upgrade head'
Error: host unavailable at poetry run alembic upgrade head: malformed resolve command

fast_zero on  main [!?] is 📦 v0.1.0 via 🐍 v3.11.0 (fast-zero-py3.11) took 2s 
❯ fly ssh console --app jlpfapi
Connecting to fdaa:3:6eb5:a7b:d2:c1f1:dcd3:2... complete
root@e784ee9ea253d8:/# poetry run alembic upgrade head
Skipping virtualenv creation, as specified in config file.
INFO  [alembic.runtime.migration] Context impl PostgresqlImpl.
INFO  [alembic.runtime.migration] Will assume transactional DDL.
INFO  [alembic.runtime.migration] Running upgrade  -> 2dd4b740b56c, create users table
INFO  [alembic.runtime.migration] Running upgrade 2dd4b740b56c -> ed810ad38404, create todos table
INFO  [alembic.runtime.migration] Running upgrade ed810ad38404 -> 11a4085457a1, create users table