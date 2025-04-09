package com.gamelike.service

import com.gamelike.constant.GenerateType
import com.gamelike.model.ClassInfo
import org.springframework.stereotype.Service
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer
import java.io.*


/**
 * @author violet
 * @since 2025/4/6
 */
@Service
class GeneratorService(
    private val freeMarker: FreeMarkerConfigurer
) {

    fun generateEntity(classInfo: ClassInfo) =
        streamHandler(classInfo, GenerateType.ENTITY)

    fun generateEntity(classInfo: ClassInfo, filePath: String) =
        streamHandler(classInfo, GenerateType.ENTITY, filePath)

    fun generateRepository(classInfo: ClassInfo) =
        streamHandler(classInfo, GenerateType.REPOSITORY)

    fun generateRepository(classInfo: ClassInfo, filePath: String) =
        streamHandler(classInfo, GenerateType.REPOSITORY, filePath)

    fun generateService(classInfo: ClassInfo, filePath: String) {
        streamHandler(classInfo, GenerateType.SERVICE, filePath)
        streamHandler(classInfo, GenerateType.SERVICE_IMPL, filePath)
    }

    @Throws(IOException::class)
    private fun streamHandler(classInfo: ClassInfo, generateType: GenerateType, filePath: String) {
        val resourcesTemplate = template(generateType)
        OutputStreamWriter(FileOutputStream(filePath + File.separator + subPath(generateType))).use {
            freeMarker.configuration.getTemplate(resourcesTemplate).process(classInfo, it)
            it.flush()
        }
    }

    private fun streamHandler(classInfo: ClassInfo, generateType: GenerateType): String {
        val resourcesTemplate = template(generateType)
        val renderString = ByteArrayOutputStream().use { outputStream ->
            OutputStreamWriter(outputStream).use {
                freeMarker.configuration.getTemplate(resourcesTemplate).process(classInfo, it)
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
}