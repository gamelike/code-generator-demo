package ${packageName}.model;

import com.ums.datasource.util.spring.Column;
import com.ums.datasource.util.spring.EntityValue;
import com.ums.datasource.util.spring.Id;
import com.ums.datasource.util.spring.Table;

import java.io.Serializable;
<#assign dateItems = fieldList?filter(item -> item.type == "Date")>
<#if dateItems?size gt 0>
import java.util.Date;
</#if>
import lombok.Setter;
import lombok.experimental.Accessors;

@Table(name = "${tableName}")
@Setter
@Accessors(chain = true)
public class ${entityName} extends EntityValue implements Serializable {
<#list fieldList as fieldItem >
    private ${fieldItem.type} ${fieldItem.name}
</#list>


<#if fieldList ? exists && fieldList ? size gt 0>
    <#list fieldList as fieldItem >
        <#if fieldItem.primaryKey>
        @Id
        </#if>
        @Column(name = "${fieldItem.columnName}")
        public ${fieldItem.type} get${fieldItem.name?cap_first}() {
        return ${fieldItem.name};
        }
    </#list>
</#if>
}
