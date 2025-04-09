package com.gamelike.service

import com.gamelike.constant.GenerateType
import com.gamelike.model.ClassInfo
import freemarker.template.Configuration
import org.springframework.stereotype.Service
import org.springframework.web.servlet.function.RequestPredicates.path
import java.io.*


/**
 * @author violet
 * @since 2025/4/6
 */
@Service
class GeneratorService(
    private val freeMarker: Configuration
) {

    fun generateEntity(classInfo: ClassInfo) =
        streamHandler(classInfo, GenerateType.ENTITY)

    fun generateEntity(classInfo: ClassInfo, filePath: String) =
        streamHandler(classInfo, GenerateType.ENTITY, filePath)

    fun generateRepository(classInfo: ClassInfo) =
        streamHandler(classInfo, GenerateType.REPOSITORY)

    fun generateRepository(classInfo: ClassInfo, filePath: String) =
        streamHandler(classInfo, GenerateType.REPOSITORY, filePath)

    fun generateService(classInfo: ClassInfo, filePath: String): String {
        streamHandler(classInfo, GenerateType.SERVICE, filePath)
        streamHandler(classInfo, GenerateType.SERVICE_IMPL, filePath)
        return "success"
    }

    fun generateController(classInfo: ClassInfo, filePath: String) =
        streamHandler(classInfo, GenerateType.CONTROLLER, filePath)

    @Throws(IOException::class)
    private fun streamHandler(classInfo: ClassInfo, generateType: GenerateType, filePath: String): String {
        val dirPath = filePath + File.separator + subPath(generateType)
        val dir = File(dirPath)
        if (!dir.exists()) {
            dir.mkdirs()
        }
        val resourcesTemplate = template(generateType)
        OutputStreamWriter(FileOutputStream(dirPath + File.separator + classInfo.entityName + suffix(generateType))).use {
            freeMarker.getTemplate(resourcesTemplate).process(classInfo, it)
            it.flush()
        }
        return "success"
    }

    private fun streamHandler(classInfo: ClassInfo, generateType: GenerateType): String {
        val resourcesTemplate = template(generateType)
        val renderString = ByteArrayOutputStream().use { outputStream ->
            OutputStreamWriter(outputStream).use {
                freeMarker.getTemplate(resourcesTemplate).process(classInfo, it)
                it.flush()
            }
            outputStream.toString(Charsets.UTF_8)
        }
        return renderString
    }

    private fun template(generateType: GenerateType) = when (generateType) {
        GenerateType.ENTITY -> "model/entity.ftl"
        GenerateType.REPOSITORY -> "model/dao.ftl"
        GenerateType.SERVICE -> "service/service.ftl"
        GenerateType.SERVICE_IMPL -> "service/serviceImpl.ftl"
        GenerateType.CONTROLLER -> "controller/controller.ftl"
    }

    private fun subPath(generateType: GenerateType) = when (generateType) {
        GenerateType.ENTITY -> "model"
        GenerateType.REPOSITORY -> "dao"
        GenerateType.SERVICE -> "service"
        GenerateType.SERVICE_IMPL -> "service" + File.separator + "impl"
        GenerateType.CONTROLLER -> "controller"
    }

    private fun suffix(generateType: GenerateType) = when (generateType) {
        GenerateType.ENTITY -> ".java"
        GenerateType.REPOSITORY -> "DAO.java"
        GenerateType.SERVICE -> "Service.java"
        GenerateType.SERVICE_IMPL -> "ServiceImpl.java"
        GenerateType.CONTROLLER -> "Controller.java"
    }
}