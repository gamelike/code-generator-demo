package com.gamelike.core.tool

import com.gamelike.model.ClassInfo
import com.gamelike.service.GeneratorService
import com.gamelike.util.SpringContextHolder
import org.springframework.ai.tool.annotation.Tool
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

    @Tool(description = "Generates code")
    fun generateCode(classInfo: ClassInfo, filePath: String): String {
        try {
            generatorService.generateEntity(classInfo, filePath)
            generatorService.generateRepository(classInfo, filePath)
            generatorService.generateService(classInfo, filePath)
            generatorService.generateController(classInfo, filePath)
            return "success"
        } catch (e: Exception) {
            throw e
        }
    }


    @Tool(description = "Generate entity code by freemarker.")
    fun generateEntity(classInfo: ClassInfo, filePath: String) =
        generatorService.generateEntity(classInfo, filePath)

    @Tool(description = "Generate repository code by freemarker.")
    fun generateRepository(classInfo: ClassInfo, filePath: String) =
        generatorService.generateRepository(classInfo, filePath)


    @Tool(description = "Generate service code by freemarker.")
    fun generateService(classInfo: ClassInfo, filePath: String) =
        generatorService.generateService(classInfo, filePath)

    @Tool(description = "Generate controller code by freemarker.")
    fun generateController(classInfo: ClassInfo, filePath: String) =
        generatorService.generateController(classInfo, filePath)
}