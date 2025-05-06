/**
 * 查询条件DTO模板 - 由freemarker自动生成
 *
 * 该类用于封装${entityName}实体的查询条件
 * 包含与实体字段对应的查询参数
 *
 * @author freemarker auto generator
 * @version 1.0
 */
package ${packageName}.model.dto;

import lombok.Data;
import lombok.experimental.Accessors;

import java.io.Serializable;
<#assign dateItems = fieldList?filter(item -> item.type == "Date")>
<#if dateItems?size gt 0>
import java.util.Date;
</#if>

/**
 * ${entityName}查询条件DTO
 * TODO: 需要根据实际情况修改
 *
 * 用于封装查询${entityName}实体的条件参数
 * 包含与实体字段对应的查询参数
 *
 * @Data Lombok注解，自动生成getter/setter、equals、hashCode和toString方法
 * @Accessors(chain = true) 支持链式调用，如obj.setField1().setField2()
 */
@Data
@Accessors(chain = true)
public class ${entityName}QueryDTO implements Serializable {
    // 基本查询字段
<#list fieldList as fieldItem>
    /**
     * ${fieldItem.columnName} 字段的查询条件
     * <#if fieldItem.primaryKey>
     * 主键字段查询条件
     * </#if>
     */
    private ${fieldItem.type} ${fieldItem.name};
</#list>

    private Integer page;
    private Integer perPage;
    private String sortField;
}