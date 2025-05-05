<#--
/**
 * 全局函数模板文件 - 包含各种常用的工具函数
 *
 * 该文件定义了在其他模板中可以使用的全局函数
 * 主要用于获取主键相关的信息和其他常用操作
 *
 * @author freemarker auto generator
 * @version 1.0
 */
-->

<#--
/**
 * 获取主键字段的Java属性名
 *
 * 遍历字段列表，找到标记为主键的字段，返回其Java属性名
 *
 * @param fieldList 字段列表
 * @return 主键字段的Java属性名
 */
-->
<#function getPrimaryName fieldList>
    <#list fieldList as fieldItem >
        <#if fieldItem.primaryKey>
            <#return fieldItem.name>
        </#if>
    </#list>
</#function>
<#--
/**
 * 获取主键字段的数据库列名
 *
 * 遍历字段列表，找到标记为主键的字段，返回其数据库列名
 *
 * @param fieldList 字段列表
 * @return 主键字段的数据库列名
 */
-->
<#function getColumnPrimaryName fieldList>
    <#list fieldList as fieldItem >
        <#if fieldItem.primaryKey>
            <#return fieldItem.columnName>
        </#if>
    </#list>
</#function>
<#--
/**
 * 获取主键字段的Java类型
 *
 * 遍历字段列表，找到标记为主键的字段，返回其Java类型
 *
 * @param fieldList 字段列表
 * @return 主键字段的Java类型，如String、Long等
 */
-->
<#function getPrimaryType fieldList>
    <#list fieldList as fieldItem >
        <#if fieldItem.primaryKey>
            <#return fieldItem.type>
        </#if>
    </#list>
</#function>