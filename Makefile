# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fmonbeig <fmonbeig@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/12/22 14:48:02 by fmonbeig          #+#    #+#              #
#    Updated: 2022/07/20 13:07:52 by fmonbeig         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all:
	@ sudo mkdir -p /home/fmonbeig/data/www
	@ sudo mkdir -p /home/fmonbeig/data/database
	@ sudo docker-compose -f ./srcs/docker-compose.yml up -d --build

up:
	@ sudo docker-compose -f ./srcs/docker-compose.yml up -d

down:
	@ sudo docker-compose -f ./srcs/docker-compose.yml down

clean: down
	@ sudo docker container prune;

fclean: clean
	@ sudo rm -rf /home/fmonbeig/data/www
	@ sudo rm -rf /home/fmonbeig/data/database
	@ docker system prune -a

re:				fclean all

.PHONY:			all clean fclean re down launch up
