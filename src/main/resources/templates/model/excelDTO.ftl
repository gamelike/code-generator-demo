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
import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.annotation.format.DateTimeFormat;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
<#assign dateItems = fieldList?filter(item -> item.type == "Date")>
<#if dateItems?size gt 0>
import java.util.Date;
</#if>

/**
 * ${entityName}Excel数据传输对象
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
@Accessors(chain = true)
public class ${entityName}ExcelDTO implements Serializable {
<#list fieldList as fieldItem>
    /**
     * ${fieldItem.columnName} 字段
     <#if fieldItem.primaryKey>
     * 主键字段
     </#if>
     */
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
     * 将实体对象转换为Excel DTO
     *
     * @param entity 实体对象
     * @return Excel DTO
     */
    public static ${entityName}ExcelDTO fromEntity(${entityName} entity) {
        return new ${entityName}ExcelDTO(entity);
    }

    /**
     * 将实体列表转换为Excel DTO列表
     *
     * @param entityList 实体列表
     * @return Excel DTO列表
     */
    public static List<${entityName}ExcelDTO> fromEntityList(List<${entityName}> entityList) {
        if (entityList == null) {
            return new ArrayList<>();
        }
        return entityList.stream()
            .map(${entityName}ExcelDTO::fromEntity)
            .collect(Collectors.toList());
    }

    /**
     * 将当前DTO转换为实体对象
     *
     * @return 实体对象
     */
    public ${entityName} toEntity() {
        ${entityName} entity = new ${entityName}();
        <#list fieldList as fieldItem>
        <#if !fieldItem.primaryKey>
        entity.set${fieldItem.name?cap_first}(this.${fieldItem.name});
        </#if>
        </#list>
        return entity;
    }

    /**
     * 将Excel DTO列表转换为实体列表
     *
     * @param dtoList Excel DTO列表
     * @return 实体列表
     */
    public static List<${entityName}> toEntityList(List<${entityName}ExcelDTO> dtoList) {
        if (dtoList == null) {
            return new ArrayList<>();
        }
        return dtoList.stream()
            .map(${entityName}ExcelDTO::toEntity)
            .collect(Collectors.toList());
    }
}
