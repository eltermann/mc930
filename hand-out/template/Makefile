# Makefile para exerc�cios EST�TICOS de POV-Ray
# Last edited on 2011-08-12 18:56:43 by stolfi

# Para cada novo exerc�cio EST�TICO (n�o animado), 
# crie um novo sub-diret�rio "mc930/tp{NN} na sua 
# �rea Linux, onde {NN} � o n�mero do laborat�rio, 
# e copie para ele este Makefile.

# O nome do arquivo principal da descri��o sua cena deve ser 
# OBRIGATORIAMENTE "main.pov", e a imagem final ser� "main.png"

# A vari�vel ${OTHERINPUTS} deve ser uma lista de 
# outros arquivos que fazem parte de seu modelo.
# Ela automaticamente inclui todos os arquivos do diret�rio
# corrente com extens�o ".inc" (chamados via "#include" pelo
# "main.pov"), imagens (usadas em texturas), arquivos de 
# fontes ".ttf" (usados em objetos de tipo texto), etc..
# Caso seu modelo use outros arquivos al�m desses, 
# acrescente-os no final da lista abaixo:
#

# Para mudar o tamanho das imagens est�ticas, edite STATIC.make
# Para mudar o tamanho dos quadros do file est�ticas, edite MOVIE.make

# Use "make " para rodar o POV-Ray no arquivo "main.pov".

# Use "make export" para entregar seu trabalho no final da aula.

# Mostrar automaticamente as imagens est�ticas ou quadros do filme?
SHOW := YES

# 
NRAYS := 2

# Directories where POV-Ray is installed:
POVPUB := /usr/local
POVRAY := ${POVPUB}/bin/povray
POVINC := ${POVPUB}/share/povray-3.6/include/

# Parent directory of lab homework directories:
TOPDIR := ${HOME}/mc930
#TOPDIR := ${HOME}/public_html/courses/MC930-2010-2-A/progs/hand-out
POVTTF := ${TOPDIR}/tt-fonts

# ----------------------------------------------------------------------
# ----------------------------------------------------------------------
# Normalmente, voc� n�o deveria precisar mexer nas linhas abaixo:

# all: print_help
all: 
	${MAKE} medium-landscape

print_help:
	@-echo "Voce deve executar 'make <ALGO>'"
	@-echo ""
	@-echo "Para produzir uma imagem est�tica use um destes:"
	@-echo ""
	@-echo "  make large-portrait"
	@-echo "  make large-landscape"
	@-echo "  make medium-portrait"
	@-echo "  make medium-landscape"
	@-echo "  make small-portrait"
	@-echo "  make small-landscape"
	@-echo ""
	@-echo "Para produzir (quadros de) uma anima��o use:"
	@-echo ""
	@-echo "  make first"
	@-echo "  make middle"
	@-echo "  make last"
	@-echo "  make strip"
	@-echo "  make fast"
	@-echo "  make movie"
	@-echo "  make clean"
	@-echo "  make still"
	@-echo ""
	@-echo "Para entregar o projeto no fim da aula use:"
	@-echo ""
	@-echo "  make export"

clean::
	-/bin/rm -f ${NAME}.png 
	-/bin/rm -f ${NAME}-*-i.png ${NAME}-i.png
	-/bin/rm -f ${NAME}-*.log ${NAME}.log

# Cuidado: linhas que come�am com 8 colunas em branco devem
# come�ar com 1 TAB, e n�o com SPACEs.

# Nome do arquivo ".pov" principal, e prefixo para arqs de sa�da
NAME := main
MAIN := main

INC_IMG_FILES := ${wildcard *.inc pic-*.png }

OTHERINPUTS := \
  ${shell echo ${INC_IMG_FILES} | tr ' ' '\012' | grep -v -e 'main.*'}

# These are defined with "=" rather than ":=" in order to defer expansion
DIRTAIL = ${shell pwd | sed -e 's:^.*/::'}

# None completo do programa:
POVRAY := povray

# Comando para visualizar as imagens produzidas pelo POV-Ray
# Defined with "=" rather than ":=" in order to defer expansion
IMVIEW := display -title '%d/%f'

# Script que efetua a entrega dos programas
EXPORT := ${HOME}/bin/mc930-export

# O comand "make export" copia seu trabalho para sua �rea ${HOME}/public_html/:
export: ${MAIN}.png ${MAIN}.pov ${OTHERINPUTS}
	${EXPORT} ${MAIN}.png ${MAIN}.pov ${OTHERINPUTS}

include STATIC.make
include MOVIE.make
