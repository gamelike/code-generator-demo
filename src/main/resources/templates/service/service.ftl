/* code generate by freemarker. */
package ${packageName}.service;

import ${packageName}.model.${entityName};

public interface ${entityName}Service {

    /**
    * @param ${entityName} 更新或插入对应实体
    */
    private ${entityName} queryById(<#list fieldList as fieldItem > <#if fieldItem.primaryKey>${fieldItem.type} ${fieldItem.name}</#if> </#list>);

    /**
    * @param ${entityName} 更新或插入对应实体
    */
    private int upsert(${entityName} ${entityName?uncap_first});

    /**
    * @param id 根据主键id删除对应实体
    */
    private int delete(<#list fieldList as fieldItem > <#if fieldItem.primaryKey>${fieldItem.type} ${fieldItem.name}</#if> </#list>);
}