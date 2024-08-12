# 定义编译器
CC=g++
# 定义编译选项
CFLAGS=-I./inc -Wall -g
# 定义链接选项
# 添加了 -lOpenCL 来链接OpenCL库
LDFLAGS=-lOpenCL
# 定义目标文件
TARGET=unit
# 假设 main.cpp 和 layer.cpp 都位于 ./src 目录下
SRC_DIR=./src
SRC=main.cpp opencl.cpp loadParameters.cpp
OBJ=$(SRC:.cpp=.o)
OBJ_DIR=$(addprefix $(SRC_DIR)/,$(OBJ))
# 默认目标（伪目标规则）
all: $(TARGET)
# 链接生成可执行文件
# 确保在链接时包含链接选项
$(TARGET): $(OBJ_DIR)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJ_DIR) $(LDFLAGS)
# 从 .cpp 文件生成 .o 文件
$(SRC_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CC) $(CFLAGS) -c $< -o $@
# 清理编译生成的文件
clean:
	rm -f $(TARGET) $(OBJ_DIR)
# 伪目标，避免 make 执行默认规则
.PHONY: all clean