# setup

```
git clone git@github.com:roadhouse/app1.git
```

```
cd app1`
```

```
docker-compose up db`
```
```
export DATABASE_URL=postgres://docker:docker@localhost:25432`
```
```
rake db:create db:migrate import:ubs`
```
```
docker-compose up web`
```

heroku url: https://jeanbionexoteste.herokuapp.com
  
