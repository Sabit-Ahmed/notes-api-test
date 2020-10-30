## Production ##

start:
	docker container start db api
build:
	./boot.sh
stop:
	docker container stop api db
destroy: stop
	docker container rm api db;
	docker image rm crudim mysql;


## Development ##

dev-start:
	docker-compose up
dev-build:
	docker-compose up --detach --build;
dev-shell:
	docker-compose exec api bash
dev-stop:
	docker-compose stop
dev-destroy:
	docker-compose down --volume

prune:
	docker system prune --all