ANIMALSDIR := $(TOP)$(notdir $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))/
INCDIRS += $(shell find $(ANIMALSDIR)$(INCDIR) -type d)
ANIMALSSRC := $(ANIMALSDIR)$(SRCDIR)
ANIMALSCFILES := $(wildcard $(ANIMALSSRC)*.c) 
ANIMALS_OFILES := $(patsubst %.c,%.o,$(ANIMALSCFILES)) 

#Debug part
ANIMALSDEBUGDIR := $(ANIMALSDIR)$(DEBUG_OBJECTS_DIR)
ANIMALSDOFILES := $(patsubst $(ANIMALSDIR)$(SRCDIR)%,$(ANIMALSDEBUGDIR)%,$(ANIMALS_OFILES))
DOFILES += $(ANIMALSDOFILES)

#Release part
ANIMALSRELEASEDIR := $(ANIMALSDIR)$(RELEASE_OBJECTS_DIR)
ANIMALSROFILES := $(patsubst $(ANIMALSDIR)$(SRCDIR)%,$(ANIMALSRELEASEDIR)%,$(ANIMALS_OFILES))
OFILES += $(ANIMALSROFILES)

#Make sure the output paths are created
DEBUGDIRS += $(ANIMALSDEBUGDIR)
RELEASEDIRS += $(ANIMALSRELEASEDIR)

#Include the rules about the dependency files
-include $(ANIMALSDOFILES:%.o=%.d)
-include $(ANIMALSROFILES:%.o=%.d)

$(ANIMALSDEBUGDIR)%.o $(ANIMALSRELEASEDIR)%.o: $(ANIMALSSRC)%.c
	$(CC) $(CFLAGS) -c $< -o $@