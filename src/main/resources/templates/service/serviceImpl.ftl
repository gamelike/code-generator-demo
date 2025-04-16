/* code generated by freemarker */
package ${packageName}.service.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;
import com.ums.service.common.exception.BizInternalServerException;
import com.ums.service.common.exception.BizIllegalArgumentException;
import ${packageName}.service.${entityName}Service;
import ${packageName}.repository.${entityName}DAO;
import ${packageName}.model.entity.${entityName};
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class ${entityName}ServiceImpl implements ${entityName}Service {
    private final ${entityName}DAO ${entityName?uncap_first}DAO;

    /**
    * @param ${entityName} 更新或插入对应实体
    */
    @Override
    public ${entityName} queryById(<#list fieldList as fieldItem ><#if fieldItem.primaryKey>${fieldItem.type} id</#if></#list>) {
        if (ObjectUtils.isBlank(id)) {
            throw new BizIllegalArgumentException("id是空");
        }
        return ${entityName?uncap_first}DAO.queryById(id);
    }

    /**
    * @param ${entityName} 更新或插入对应实体
    */
    @Override
    public int upsert(${entityName} ${entityName?uncap_first}) {
        try {
            if (queryById(<#list fieldList as fieldItem ><#if fieldItem.primaryKey>${entityName?uncap_first}.get${fieldItem.name?cap_first}()</#if></#list>) == null) {
                ${entityName?uncap_first}DAO.add(${entityName?uncap_first});
                return 1;
            } else {
                ${entityName?uncap_first}DAO.update(${entityName?uncap_first});
                return 1;
            }
        } catch (Exception e) {
            log.error("upsert ${entityName} error", e);
            throw new BizInternalServerException("upsert ${entityName} error", e);
        }
    }

    @Override
    public int upsert(List<${entityName}> ${entityName?uncap_first}List) {
        try {
            List<String> existsIds = ${entityName?uncap_first}DAO.existsByIds(${entityName?uncap_first}List
                .stream()
                .map(${entityName}::get<#list fieldList as fieldItem ><#if fieldItem.primaryKey>${fieldItem.name?cap_first}</#if></#list>)
                .toList());
            List<${entityName}> insertList = ${entityName?uncap_first}List
                .stream()
                .filter(item -> !existsIds.contains(item.get<#list fieldList as fieldItem ><#if fieldItem.primaryKey>${fieldItem.name?cap_first}</#if></#list>()))
                .toList();
            List<${entityName}> updateList = ${entityName?uncap_first}List
                .stream()
                .filter(item -> existsIds.contains(item.get<#list fieldList as fieldItem ><#if fieldItem.primaryKey>${fieldItem.name?cap_first}</#if></#list>()))
                .toList();
            int insertCount = 0;
            if (!ObjectUtils.isEmpty(insertList)) {
                insertCount = ${entityName?uncap_first}DAO.add(insertList.toArray(${entityName}[]::new));
            }
            int updateCount = 0;
            if (!ObjectUtils.isEmpty(updateList)) {
                updateCount = ${entityName?uncap_first}DAO.update(updateList.toArray(${entityName}[]::new));
            }
            log.info("${entityName} insertCount: {}, updateCount: {}", insertCount, updateCount);
            return insertCount + updateCount;
        } catch (Exception e) {
            log.error("upsert ${entityName} error", e);
            throw new BizInternalServerException("batch upsert ${entityName} error", e);
        }
    }

    /**
    * @param id 根据主键id删除对应实体
    */
    @Override
    public int delete(<#list fieldList as fieldItem><#if fieldItem.primaryKey>${fieldItem.type}... id</#if></#list>) {
        if (ObjectUtils.isBlank(id)) {
            throw new BizIllegalArgumentException("id是空");
        }
        try {
            ${entityName?uncap_first}DAO.deleteById(id);
            return 1;
        } catch (Exception e) {
            log.error("delete ${entityName} error", e);
            throw new BizInternalServerException("delete ${entityName} error", e);
        }
    }
}