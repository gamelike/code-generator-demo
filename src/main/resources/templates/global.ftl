<#function getPrimaryName fieldList>
    <#list fieldList as fieldItem >
        <#if fieldItem.primaryKey>
            <#return fieldItem.name>
        </#if>
    </#list>
</#function>
<#function getColumnPrimaryName fieldList>
    <#list fieldList as fieldItem >
        <#if fieldItem.primaryKey>
            <#return fieldItem.columnName>
        </#if>
    </#list>
</#function>
<#function getPrimaryType fieldList>
    <#list fieldList as fieldItem >
        <#if fieldItem.primaryKey>
            <#return fieldItem.type>
        </#if>
    </#list>
</#function>