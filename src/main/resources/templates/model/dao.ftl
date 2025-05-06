/**
 * 数据访问层代码模板 - 由freemarker自动生成
 *
 * 该类实现了${entityName}实体的数据库访问操作
 * 包含基本的CRUD操作以及扩展的查询方法
 * 继承BaseEntityDAO类，利用其提供的通用数据库操作方法
 *
 * @author freemarker auto generator
 * @version 1.0
 */
<#import "../global.ftl" as common>
package ${packageName}.dao;

import org.springframework.stereotype.Repository;

import ${packageName}.model.entity.${entityName};
import ${packageName}.model.dto.${entityName}QueryDTO;
import com.ums.datasource.util.spring.PageData;
import com.ums.datasource.util.BaseEntityDAO;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.util.StringUtils;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

/**
 * ${entityName}数据访问对象（DAO）
 *
 * 负责${entityName}实体的数据库访问操作
 * 继承BaseEntityDAO类，获得基本的CRUD操作能力
 * 并扩展实现特定于${entityName}的数据库操作
 */
@Repository
public class ${entityName}DAO extends BaseEntityDAO<${entityName}> {
    /**
     * 根据ID列表检查${entityName}记录是否存在
     *
     * 该方法用于批量检查多个ID对应的记录是否存在
     * 主要用于批量更新或删除前的验证
     *
     * @param ids 要检查的ID列表
     * @return 存在于数据库中的ID列表
     */
    public List<String> existsByIds(List<String> ids) {
        NamedParameterJdbcTemplate jdbcTemplate = new NamedParameterJdbcTemplate(getJdbcTemplate());
        String sql = """
            SELECT ${common.getColumnPrimaryName(fieldList)} FROM ${tableName}
            WHERE ${common.getColumnPrimaryName(fieldList)} IN (:ids)
        """;
        MapSqlParameterSource params = new MapSqlParameterSource();
        params.addValue("ids", ids);
        return jdbcTemplate.queryForList(sql, params, String.class);
    }

    /**
     * 分页查询${entityName}列表
     *
     * 根据提供的分页参数和查询条件，返回分页结果
     * 包含总记录数和当前页的数据列表
     *
     * @param queryDTO 分页查询条件，包含页码、每页记录数和查询条件
     * @return 分页数据对象，包含总记录数和当前页数据
     */
    public PageData<${entityName}> findByPage(${entityName}QueryDTO queryDTO) {
        // 初始化SQL查询语句和参数列表
        String sql = "SELECT t.* FROM ${tableName} t WHERE 1=1";
        List<Object> params = new ArrayList<>();
        // TODO 分页查询逻辑补充.
        // 调用父类的分页查询方法
        return super.queryPageData(params, sql, queryDTO.getPage(), queryDTO.getPerPage());
    }
}