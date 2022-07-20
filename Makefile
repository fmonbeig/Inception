# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fmonbeig <fmonbeig@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/12/22 14:48:02 by fmonbeig          #+#    #+#              #
#    Updated: 2022/07/20 12:33:35 by fmonbeig         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all: dir
	sudo docker-compose -f ./srcs/docker-compose.yml up -d --build

dir:
		@ sudo mkdir -p /home/fmonbeig/data/www
		@ sudo mkdir -p /home/fmonbeig/data/database

down:
	sudo docker-compose -f ./srcs/docker-compose.yml down

clean: down
	sudo docker container prune;

fclean: clean
	@ sudo rm -rf /home/fmonbeig/data/www
	@ sudo rm -rf /home/fmonbeig/data/database
	  docker system prune -a

re:				fclean all

.PHONY:			all clean fclean re dir launch down
