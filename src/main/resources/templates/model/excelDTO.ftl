/**
 * Excel数据传输对象模板 - 由freemarker自动生成
 *
 * 该类用于Excel导入导出功能，映射${entityName}实体的数据结构
 * 包含与实体字段对应的属性，并添加Excel相关注解
 * 提供实体与DTO之间的转换方法
 *
 * @author freemarker auto generator
 * @version 1.0
 */
package ${packageName}.model.dto;

import ${packageName}.model.entity.${entityName};
import cn.idev.excel.annotation.ExcelProperty;
import cn.idev.excel.annotation.format.DateTimeFormat;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
<#assign dateItems = fieldList?filter(item -> item.type == "Date")>
<#if dateItems?size gt 0>
import java.util.Date;
</#if>

/**
 * ${entityName}Excel数据传输对象
 * TODO: 需要根据实际情况修改
 *
 * 用于Excel导入导出功能，映射${entityName}实体的数据结构
 * 包含与实体字段对应的属性，并添加Excel相关注解
 * 提供实体与DTO之间的转换方法
 *
 * @Data Lombok注解，自动生成getter/setter、equals、hashCode和toString方法
 * @NoArgsConstructor 无参构造函数
 * @Accessors(chain = true) 支持链式调用，如obj.setField1().setField2()
 */
@Data
@NoArgsConstructor
public class ${entityName}ExcelDTO implements Serializable {
<#list fieldList as fieldItem>
    <#if fieldItem.type == "Date">
    @DateTimeFormat("yyyy-MM-dd HH:mm:ss")
    </#if>
    @ExcelProperty("${fieldItem.columnName}")
    private ${fieldItem.type} ${fieldItem.name};
</#list>

    /**
     * 构造函数，从实体创建DTO
     *
     * @param entity 实体对象
     */
    public ${entityName}ExcelDTO(${entityName} entity) {
        if (entity != null) {
            <#list fieldList as fieldItem>
            this.${fieldItem.name} = entity.get${fieldItem.name?cap_first}();
            </#list>
        }
    }

    /**
     * 将Excel DTO转换为实体对象
     */
    public ${entityName} toEntity() {
        ${entityName} entity = new ${entityName}();
<#list fieldList as fieldItem>
        entity.set${fieldItem.name?cap_first}(this.${fieldItem.name});
</#list>
        return entity;
    }

}
