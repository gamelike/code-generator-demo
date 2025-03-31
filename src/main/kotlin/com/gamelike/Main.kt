package com.gamelike

import freemarker.template.Configuration
import java.io.File
import java.io.OutputStreamWriter
import java.util.TimeZone


/**
 * @author violet
 * @since 2025/3/31
 */
fun main() {
    val classInfo = ClassInfo(
        packageName = "com.gamelike",
        tableName = "user",
        entityName = "User",
        fieldList = listOf(
            FieldInfo("id", "String", true),
            FieldInfo("name", "String", false),
            FieldInfo("email", "String", false),
            FieldInfo("create_time", "Date", false),
            FieldInfo("update_time", "Date", false)
        )
    )
    val cfg = Configuration(Configuration.VERSION_2_3_34)
    val templateDir = File(
        Thread.currentThread().contextClassLoader.getResource("templates")?.toURI()
            ?: throw IllegalArgumentException("Template folder not found")
    )
    cfg.setDirectoryForTemplateLoading(templateDir)
    cfg.defaultEncoding = "UTF-8"
    cfg.fallbackOnNullLoopVariable = false
    cfg.sqlDateAndTimeTimeZone = TimeZone.getDefault()
    val entityTemplate = cfg.getTemplate("model/entity.ftl")
    val daoTemplate = cfg.getTemplate("model/dao.ftl")
    OutputStreamWriter(System.out).use {
        entityTemplate.process(classInfo, it)
        daoTemplate.process(classInfo, it)
    }
}