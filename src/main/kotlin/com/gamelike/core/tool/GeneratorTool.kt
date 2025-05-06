package com.gamelike.core.tool

import com.gamelike.model.ClassInfo
import com.gamelike.service.GeneratorService
import com.gamelike.util.SpringContextHolder
import org.springframework.ai.tool.annotation.Tool
import org.springframework.ai.tool.annotation.ToolParam
import org.springframework.ai.tool.definition.ToolDefinition
import org.springframework.ai.tool.method.MethodToolCallback
import org.springframework.util.ReflectionUtils
import kotlin.jvm.java


/**
 * @author violet
 * @since 2025/4/6
 */
@Suppress("unused")
object GeneratorTool {
    private val generatorService = SpringContextHolder.getBean(GeneratorService::class.java)

    const val CODE_DESCRIPTION = """
        一个基于模板的代码生成器
        - 生成代码包括 entity,repository,service,dto,execlListener
        基于freemarker模板实现的代码生成器
    """

    const val TOOL_PARAMS_FILE_PATH = """
        生成的文件路径
        - 文件路径要求:
            - 项目工作空间的绝对路径
            - 文件路径不需要生成到java文件
        - 样例:
        {workspace}
        └─src
            ├─main
                ├─java
                    └─com
        filePath应该为 C:\Users\violet\idea-projects\code-generator-spring\java\com
    """

    @Tool(
        name = "basic-code-generator",
        description = CODE_DESCRIPTION,
        returnDirect = false
    )
    fun generateCode(@ToolParam(description = "生成代码的基本类信息") classInfo: ClassInfo,
                     @ToolParam(description = TOOL_PARAMS_FILE_PATH) filePath: String): String {
        try {
            generatorService.generateEntity(classInfo, filePath)
            generatorService.generateRepository(classInfo, filePath)
            generatorService.generateService(classInfo, filePath)
            generatorService.generateQueryDTO(classInfo, filePath)
            generatorService.generateExcelDTO(classInfo, filePath)
            generatorService.generateExcelImportListener(classInfo, filePath)
            return "success"
        } catch (e: Exception) {
            throw e
        }
    }


    //    @Tool(description = "Generate entity code by freemarker.")
    fun generateEntity(classInfo: ClassInfo, filePath: String) =
        generatorService.generateEntity(classInfo, filePath)

    //    @Tool(description = "Generate repository code by freemarker.")
    fun generateRepository(classInfo: ClassInfo, filePath: String) =
        generatorService.generateRepository(classInfo, filePath)


    //    @Tool(description = "Generate service code by freemarker.")
    fun generateService(classInfo: ClassInfo, filePath: String) =
        generatorService.generateService(classInfo, filePath)


    //    @Tool(description = "Generate query DTO code by freemarker.")
    fun generateQueryDTO(classInfo: ClassInfo, filePath: String) =
        generatorService.generateQueryDTO(classInfo, filePath)

    //    @Tool(description = "Generate Excel DTO for import/export functionality.")
    fun generateExcelDTO(classInfo: ClassInfo, filePath: String) =
        generatorService.generateExcelDTO(classInfo, filePath)

}