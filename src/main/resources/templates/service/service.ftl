/* code generate by freemarker. */
<#import "../global.ftl" as common>
package ${packageName}.service;

import ${packageName}.model.entity.${entityName};
import java.util.List;

public interface ${entityName}Service {

    /**
    * @param id 根据主键查询对应实体
    * @return 返回对应的实体 {@link ${entityName}}
    */
    ${entityName} queryById(${common.getPrimaryType(fieldList)} id);

    /**
    * @param ${entityName?uncap_first} 插入对应实体
    * @return 插入成功，返回对应实体
    */
    ${entityName} insert(${entityName} ${entityName?uncap_first});

    /**
    * 批量插入实体
    *
    * @param ${entityName?uncap_first}List 批量插入实体
    * @return 插入实体后，受影响的行数
    */
    int batchInsert(List<${entityName}> ${entityName?uncap_first}List);


    /**
    * 更新实体
    *
    * @param ${entityName?uncap_first} 更新实体
    * @return 更新成功，返回对应实体
    */
    ${entityName} update(${entityName} ${entityName?uncap_first});

    /**
    * 批量更新实体
    *
    * @param ${entityName?uncap_first}List 批量插入实体
    * @return 更新实体后，受影响的行数
    */
    int batchUpdate(List<${entityName}> ${entityName?uncap_first}List);

    /**
    * @param id 根据主键id删除对应实体
    * @return 删除成功，返回对应实体
    */
    ${entityName} delete(${common.getPrimaryType(fieldList)} id);

    /**
    * @param ids 根据主键id删除对应实体
    * @return 批量删除实体后，受影响的行数
    */
    int batchDelete(List<${common.getPrimaryType(fieldList)}> ids);
}