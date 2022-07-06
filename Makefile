# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fmonbeig <fmonbeig@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/12/22 14:48:02 by fmonbeig          #+#    #+#              #
#    Updated: 2022/07/06 15:45:00 by fmonbeig         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

blue			= /bin/echo -e -n "\x1b[1m\x1b[34m$1\x1b[0m"
green			= /bin/echo -e -n "\x1b[1m\x1b[32m$1\x1b[0m"
filename		= /bin/echo -e -n "\x1b[30m\x1b[47m\x1b[1m$1\x1b[0m"

NAME			= inception

all:	dir
		launch


dir:	mkdir -p /home/fmonbeig/data/www
		mkdir -p /home/fmonbeig/data/database

launch:	docker compose -f srcs/docker-compose.yml -p $(NAME) up
		$(call green," successfully created. ✅")
		/bin/echo -e "\n\n🚀 You can go Deeper"

clean:
				/bin/echo "💦 Cleaning..."
				rm -rf /home/fmonbeig/data/www/*
				rm -rf /home/fmonbeig/data/database/*
				$(call green,"Containers data are cleaned. ✅")

fclean:			clean
				docker rm -f nginx
				docker rm -f mariadb
				docker rm -f wordpress
				docker rmi -f nginx
				docker rmi -f mariadb
				docker rmi -f wordpress

re:				fclean all

.PHONY:			all clean fclean re
