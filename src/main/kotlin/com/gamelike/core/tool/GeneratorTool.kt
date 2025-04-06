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

    fun toolCallback(): List<MethodToolCallback> {
        val toolEntityMethod = ReflectionUtils.findMethod(
            GeneratorTool::class.java, "generateEntity",
            ClassInfo::class.java
        )
        if (toolEntityMethod == null) {
            throw IllegalStateException("Tool method generateEntity not found")
        }
        val toolRepositoryMethod = ReflectionUtils.findMethod(
            GeneratorTool::class.java, "generateRepository",
            ClassInfo::class.java
        )
        if (toolRepositoryMethod == null) {
            throw IllegalStateException("Tool method generateRepository not found")
        }
        return listOf(
            MethodToolCallback.builder()
                .toolDefinition(
                    ToolDefinition.builder(toolEntityMethod)
                        .description("Generate the entity code by freemarker.")
                        .build()
                ).toolMethod(toolEntityMethod)
                .toolObject(GeneratorTool)
                .build(),
            MethodToolCallback.builder()
                .toolDefinition(
                    ToolDefinition.builder(toolRepositoryMethod)
                        .description("Generate the entity code by freemarker.")
                        .build()
                ).toolMethod(toolRepositoryMethod)
                .toolObject(GeneratorTool)
                .build()
        )
    }

    @Tool(description = "Generate entity code by freemarker.")
    fun generateEntity(classInfo: ClassInfo) =
        generatorService.generateEntity(classInfo)

    @Tool(description = "Generate repository code by freemarker.")
    fun generateRepository(classInfo: ClassInfo) =
        generatorService.generateRepository(classInfo)
}