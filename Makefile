NAME = alinmear/docker-manage-windows:latest

all: no-cache
all-cache: cache

no-cache:
	docker build --no-cache=true -t $(NAME) .
cache:
	docker build -t $(NAME) .
