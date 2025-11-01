SRCDIR := src
INCDIR := include
OBJDIR := obj
BINDIR := bin

# Compiler and Flags
CC := gcc
CFLAGS := -Wall -Wextra -std=gnu11 -g -I$(INCDIR) -MMD -MP
LDFLAGS := 

# Target executable
TARGET := $(BINDIR)/psh

# Source and Object files
SRCS := $(wildcard $(SRCDIR)/*.c)
OBJS := $(patsubst $(SRCDIR)/%.c,$(OBJDIR)/%.o,$(SRCS))
DEPS := $(OBJS:.o=.d)

# Default target
.PHONY: all clean run

all: $(TARGET)

# Link all object files into final binary
$(TARGET): $(OBJS)
	@mkdir -p $(BINDIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^

# Compile .c -> .o and place in /obj
$(OBJDIR)/%.o: $(SRCDIR)/%.c
	@mkdir -p $(OBJDIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Include auto-generated dependency files
-include $(DEPS)

# Run the shell
run: $(TARGET)
	@echo "Running shell..."
	./$(TARGET)

# Clean object and binary files
clean:
	rm -rf $(OBJDIR) $(BINDIR)

