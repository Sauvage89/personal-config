# ####################################################################### #
#                                                                         #
#                                                     :::     ::::::::    #
#   makefile                                         :+:     :+:    :+:   #
#                                                  +:+ +:+        +:+     #
#   By: lensauva <sauvagelenny89@gmail.com>      +#+  +:+      +#+        #
#                                              +#+#+#+#+#+  +#+           #
#   Created: 29/10/2026 22:34:27 by lensauva        #+#   #+#             #
#   Updated: 29/10/2026 22:58:44 by lensauva       ###  ##########.fr     #
#                                                                         #
# ####################################################################### #

# ================================ PROJET ==================================== #

NAME		:= tetris
CC			:= cc
CFLAGS		:= -Wall -Wextra -Werror

# ============================== DOSSIERS ==================================== #

SRC_DIR		:= src
OBJ_DIR		:= obj
INC_DIR		:= include

# =============================== SOURCES ==================================== #

SRC_FILES	:= handle_framebuffer.c

SRCS		:= $(addprefix $(SRC_DIR)/, $(SRC_FILES))
OBJS		:= $(SRCS:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)
DEPS		:= $(OBJS:.o=.d)

# ================================ FLAGS ===================================== #

# -MMD : génère un .d (liste des headers utilisés) à côté de chaque .o
# -MP  : ajoute une cible vide par header (évite l'erreur si un header est supprimé)
CPPFLAGS	:= -I$(INC_DIR) -MMD -MP

# ================================ REGLES ==================================== #

all: $(NAME)

$(NAME): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

clean:
	rm -rf $(OBJ_DIR)

fclean: clean
	rm -f $(NAME)

re: fclean
	$(MAKE) all

-include $(DEPS)

.PHONY: all clean fclean re
