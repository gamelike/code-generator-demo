package com.gamelike.service

import com.gamelike.constant.GenerateType
import com.gamelike.model.ClassInfo
import org.springframework.stereotype.Service
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer
import java.io.ByteArrayOutputStream
import java.io.OutputStreamWriter


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

    fun generateRepository(classInfo: ClassInfo) =
        streamHandler(classInfo, GenerateType.REPOSITORY)

    private fun streamHandler(classInfo: ClassInfo, generateType: GenerateType): String {
        val resourcesTemplate = when (generateType) {
            GenerateType.ENTITY -> "model/entity.ftl"
            GenerateType.REPOSITORY -> "model/dao.ftl"
            GenerateType.SERVICE -> "service/service.ftl"
            GenerateType.CONTROLLER -> "controller/controller.ftl"
        }
        val renderString = ByteArrayOutputStream().use { outputStream ->
            OutputStreamWriter(outputStream).use {
                freeMarker.configuration.getTemplate(resourcesTemplate).process(classInfo, it)
                it.flush()
            }
            outputStream.toString(Charsets.UTF_8)
        }
        return renderString
    }
}