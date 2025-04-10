# Code-Generate MCP

## 概述

代码生成器的兼容[MCP协议](https://modelcontextprotocol.io/introduction), 使用Stdio模式。

提供简单的 MCP Server，包含 生成Entity、Repository、Service、Controller 代码的功能, 摆脱繁琐的CRUD的编写。

依赖 MCP Java SDK、Freemarker 和 Spring-AI-MCP 开发，任意支持MCP协议的客户端均可使用。

## 工具

> Tips: 建议搭配数据库的mcp server使用，获取DDL后直接用该MCP在项目中生成代码.

- generate-code
  > 也可以可使用generate-entity、generate-repository、generate-service、generate-controller等工具单独生成代码
    - 采用[模板](./src/main/resources/templates)引擎渲染生成将获取到的表结构直接生成相关的CURD代码

## 开始

### 安装

> 依赖Java 17 和 Maven 3.8.1+，(建议使用IDEA打开项目)

```bash
./gradlew build
```

## 配置

任意MCP客户端 (如Claude.app) 中添加如下配置、部分客户端可能需要调整配置

其中构建的jar需要为绝对路径

```json
{
  "mcpServers": {
    "code-generate": {
      "command": "java",
      "args": [
        "-jar",
        "code-generator-0.0.1-SNAPSHOT.jar"
      ]
    }
  }
}
```
### 使用

> 需要注意，LLM生成的最终生成文件路径可能有误, 当前项目生成不需要最终的文件夹路径和文件名，MCP工具会自己处理
> ，其中model和${EntityName}为自动生成的文件夹和文件名
 
- Entity
  - 生成路径: {filePath}/model/{EntityName}.java
  - 包含注解及字段
- Repository
  - 生成路径: {filePath}/repository/{EntityName}DAO.java
  - 继承SpringEntityDAO
- Service (会生成接口和实现类)
  - 生成路径: 
    - {filePath}/service/{EntityName}Service.java
    - {filePath}/service/impl/{EntityName}ServiceImpl.java
  - 包含基本的 queryById、upsert 、delete 方法
- Controller
  - 生成路径: {filePath}/controller/{EntityName}Controller.java
  - 包含基本的 api 接口
    - GET v1/{id}
    - DELETE v1/{id}
    - PUT v1 ```Body: Entity```
    - PATCH v1 ```Body: Entity```