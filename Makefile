all:
	mkdir -p /home/${USER}/data/mariadb && mkdir -p /home/${USER}/data/wordpress
	@cd ./srcs && docker-compose up --build -d

down:
	@cd ./srcs && docker-compose down

stop: 
	@if [ -n "$$(docker ps -qa)" ]; then docker stop $$(docker ps -qa); fi

container_clean:
	@if [ -n "$$(docker ps -qa)" ]; then docker rm $$(docker ps -qa); fi

images_clean:
	@docker image prune -a -f

volume_clean:
	@if [ -n "$$(docker volume ls -q)" ]; then docker volume rm $$(docker volume ls -q); fi

network_clean:
	@if [ -n "$$(docker network ls -q)" ]; then docker network rm $$(docker network ls -q) 2>/dev/null || true; fi

clean:
	docker system prune -a

fclean: stop container_clean images_clean volume_clean network_clean

re: fclean all
