package com.gamelike.service

import com.gamelike.constant.GenerateType
import com.gamelike.model.ClassInfo
import freemarker.template.Configuration
import org.springframework.stereotype.Service
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

    fun generateQueryDTO(classInfo: ClassInfo, filePath: String) =
        streamHandler(classInfo, GenerateType.QUERY_DTO, filePath)

    fun generateExcelDTO(classInfo: ClassInfo, filePath: String) =
        streamHandler(classInfo, GenerateType.EXCEL_DTO, filePath)

    @Throws(IOException::class)
    private fun streamHandler(classInfo: ClassInfo, generateType: GenerateType, filePath: String): String {
        val dirPath = filePath + File.separator + subPath(generateType)
        val dir = File(dirPath)
        if (!dir.exists()) {
            dir.mkdirs()
        }
        val resourcesTemplate = template(generateType)
        OutputStreamWriter(
            FileOutputStream(dirPath + File.separator + classInfo.entityName + suffix(generateType)),
            Charsets.UTF_8
        ).use {
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
        GenerateType.QUERY_DTO -> "model/queryDTO.ftl"
        GenerateType.EXCEL_DTO -> "model/excelDTO.ftl"
    }

    private fun subPath(generateType: GenerateType) = when (generateType) {
        GenerateType.ENTITY -> "model" + File.separator + "entity"
        GenerateType.REPOSITORY -> "repository"
        GenerateType.SERVICE -> "service"
        GenerateType.SERVICE_IMPL -> "service" + File.separator + "impl"
        GenerateType.CONTROLLER -> "controller"
        GenerateType.QUERY_DTO -> "model" + File.separator + "dto"
        GenerateType.EXCEL_DTO -> "model" + File.separator + "dto"
    }

    private fun suffix(generateType: GenerateType) = when (generateType) {
        GenerateType.ENTITY -> ".java"
        GenerateType.REPOSITORY -> "DAO.java"
        GenerateType.SERVICE -> "Service.java"
        GenerateType.SERVICE_IMPL -> "ServiceImpl.java"
        GenerateType.CONTROLLER -> "Controller.java"
        GenerateType.QUERY_DTO -> "QueryDTO.java"
        GenerateType.EXCEL_DTO -> "ExcelDTO.java"
    }
}