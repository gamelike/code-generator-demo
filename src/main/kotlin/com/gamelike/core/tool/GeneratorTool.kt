package com.gamelike.core.tool

import com.gamelike.model.ClassInfo
import com.gamelike.service.GeneratorService
import com.gamelike.util.SpringContextHolder
import org.apache.coyote.http11.Constants.a
import org.slf4j.LoggerFactory
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
    private val log = LoggerFactory.getLogger(GeneratorTool::class.java)

    @Tool(description = "Generates code")
    fun generateCode(classInfo: ClassInfo, filePath: String): String {
        // 打印参数
        log.info("Generating code: {}", classInfo)
        log.info("Generating code: {}", filePath)

        try {
            generatorService.generateEntity(classInfo, filePath)
            generatorService.generatePageDTO(classInfo, filePath)
            generatorService.generateQueryDTO(classInfo, filePath)
            generatorService.generateRepository(classInfo, filePath)
            generatorService.generateService(classInfo, filePath)
            generatorService.generateController(classInfo, filePath)
            return "success"
        } catch (e: Exception) {
            e.printStackTrace();
            return "error: ${e.message}"
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

    //    @Tool(description = "Generate controller code by freemarker.")
    fun generateController(classInfo: ClassInfo, filePath: String) =
        generatorService.generateController(classInfo, filePath)
}