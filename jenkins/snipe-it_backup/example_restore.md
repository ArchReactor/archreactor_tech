Start a docker container
```docker run -v $(pwd):/data -it --rm --link mysql-snipe-it:mysql mysql:5.6 sh```
In the docker conainer run
```mysql -h $MYSQL_PORT_3306_TCP_ADDR -u root -p$MYSQL_ENV_MYSQL_ROOT_PASSWORD snipeit < /data/snipe-it_db_dump.sql.20200323_074918```