/**
 * 实体类模板 - 由freemarker自动生成
 *
 * 该类对应数据库中的${tableName}表
 * 包含表中所有字段的属性和访问方法
 *
 * @author freemarker auto generator
 * @version 1.0
 */
package ${packageName}.model.entity;

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

/**
 * ${entityName}实体类
 *
 * 对应数据库中的${tableName}表
 * 继承EntityValue类，实现Serializable接口
 *
 * @Table 注解指定对应的数据库表名
 * @Setter 使用Lombok自动生成setter方法
 * @Accessors(chain = true) 支持链式调用，如obj.setField1().setField2()
 */
@Table(name = "${tableName}")
@Setter
@Accessors(chain = true)
public class ${entityName} extends EntityValue implements Serializable {
<#list fieldList as fieldItem >
    /**
     * ${fieldItem.columnName} 字段
     * <#if fieldItem.primaryKey>
     * 主键字段
     * </#if>
     */
    private ${fieldItem.type} ${fieldItem.name};
</#list>


<#if fieldList ? exists && fieldList ? size gt 0>
    <#list fieldList as fieldItem >
        <#if fieldItem.primaryKey>
    /**
     * 获取${fieldItem.columnName}字段值（主键）
     *
     * @return ${fieldItem.type} 类型的主键值
     */
    @Id
    <#else>
    /**
     * 获取${fieldItem.columnName}字段值
     *
     * @return ${fieldItem.type} 类型的字段值
     */
    </#if>
    @Column(name = "${fieldItem.columnName}")
    public ${fieldItem.type} get${fieldItem.name?cap_first}() {
        return ${fieldItem.name};
    }
    </#list>
</#if>
}
