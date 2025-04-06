package com.gamelike.model

data class ClassInfo(
    val packageName: String,
    val tableName: String,
    val entityName: String,
    val fieldList: List<FieldInfo>
)

data class FieldInfo(
    val columnName: String,
    val type: String,
    val primaryKey: Boolean,
) {

    constructor(columnName: String, type: String) : this(columnName, type, false)

    val name = columnName.split("_")
        .joinToString("") {
            it.replaceFirstChar { it.uppercase() }
        }

}


