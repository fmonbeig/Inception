# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fmonbeig <fmonbeig@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/12/22 14:48:02 by fmonbeig          #+#    #+#              #
#    Updated: 2022/07/18 18:20:06 by fmonbeig         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

blue			= /bin/echo -e -n "\x1b[1m\x1b[34m$1\x1b[0m"
green			= /bin/echo -e -n "\x1b[1m\x1b[32m$1\x1b[0m"
filename		= /bin/echo -e -n "\x1b[30m\x1b[47m\x1b[1m$1\x1b[0m"

NAME			= inception

all:
	@ sudo mkdir -p /home/fmonbeig/data/www
	@ sudo mkdir -p /home/fmonbeig/data/database
	@ sudo docker-compose -f ./srcs/docker-compose.yml up

# all: dir launch

dir:
		sudo mkdir -p /home/fmonbeig/data/www
		sudo mkdir -p /home/fmonbeig/data/database

# launch:
# 			docker-compose -f ./srcs/docker-compose.yml -p $(NAME) up
# 			$(call green," successfully created. ✅")
# 			/bin/echo -e "\n\n🚀 You can go Deeper"

# clean:
# 				/bin/echo "💦 Cleaning..."
# 				sudo rm -rf /home/fmonbeig/data/www
# 				sudo rm -rf /home/fmonbeig/data/database
# 				$(call green,"Containers data are cleaned. ✅")

# fclean:			clean
# 				sudo docker rm -f nginx
# 				sudo docker rm -f mariadb
# 				sudo docker rm -f wordpress
# 				sudo docker rmi -f nginx
# 				sudo docker rmi -f mariadb
# 				sudo docker rmi -f wordpress

down:
	@ sudo docker-compose -f ./srcs/docker-compose.yml down

clean: down
	@ sudo docker container prune;

fclean: clean
	@ sudo rm -rf /home/fmonbeig/data/www
	@ sudo rm -rf /home/fmonbeig/data/database
	@ docker system prune -a

re:				fclean all

.PHONY:			all clean fclean re dir launch
