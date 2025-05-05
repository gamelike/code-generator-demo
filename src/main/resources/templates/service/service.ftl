/**
 * 服务接口模板 - 由freemarker自动生成
 *
 * 该接口定义了${entityName}实体的业务操作方法
 * 包含基本的CRUD操作以及批量处理方法
 *
 * @author freemarker auto generator
 * @version 1.0
 */
<#import "../global.ftl" as common>
package ${packageName}.service;

import ${packageName}.model.entity.${entityName};
import ${packageName}.model.dto.${entityName}QueryDTO;
import ${packageName}.model.dto.${entityName}PageDTO;
import ${packageName}.model.dto.${entityName}ExcelDTO;
import com.ums.datasource.util.spring.PageData;

import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import java.io.IOException;

/**
 * ${entityName}服务接口
 *
 * 定义了${entityName}实体的业务操作方法
 * 具体实现由${entityName}ServiceImpl类提供
 */
public interface ${entityName}Service {

    /**
     * 根据主键查询${entityName}实体
     *
     * @param id 主键ID
     * @return 返回对应的${entityName}实体，如果不存在则抛出异常
     * @throws com.ums.service.common.exception.BizResourceNotFoundException 当资源不存在时
     * @throws com.ums.service.common.exception.BizInternalServerException 当查询过程发生异常时
     */
    ${entityName} queryById(${common.getPrimaryType(fieldList)} id);

    /**
     * 创建新的${entityName}实体
     *
     * @param ${entityName?uncap_first} 要创建的${entityName}实体对象
     * @return 插入成功后的${entityName}实体，包含生成的主键ID
     * @throws com.ums.service.common.exception.BizInternalServerException 当插入过程发生异常时
     */
    ${entityName} insert(${entityName} ${entityName?uncap_first});

    /**
     * 批量创建${entityName}实体
     *
     * @param ${entityName?uncap_first}List 要创建的${entityName}实体对象列表
     * @return 插入成功后，受影响的行数
     * @throws com.ums.service.common.exception.BizInternalServerException 当插入过程发生异常时
     */
    int batchInsert(List<${entityName}> ${entityName?uncap_first}List);


    /**
     * 更新${entityName}实体
     *
     * @param ${entityName?uncap_first} 要更新的${entityName}实体对象，必须包含主键ID
     * @return 更新成功后的${entityName}实体
     * @throws com.ums.service.common.exception.BizResourceNotFoundException 当要更新的资源不存在时
     * @throws com.ums.service.common.exception.BizInternalServerException 当更新过程发生异常时
     */
    ${entityName} update(${entityName} ${entityName?uncap_first});

    /**
     * 批量更新${entityName}实体
     *
     * @param ${entityName?uncap_first}List 要更新的${entityName}实体对象列表，每个对象必须包含主键ID
     * @return 更新成功后，受影响的行数
     * @throws com.ums.service.common.exception.BizResourceNotFoundException 当要更新的资源不存在时
     * @throws com.ums.service.common.exception.BizInternalServerException 当更新过程发生异常时
     */
    int batchUpdate(List<${entityName}> ${entityName?uncap_first}List);

    /**
     * 根据主键ID删除${entityName}实体
     *
     * @param id 要删除的实体的主键ID
     * @return 删除成功后的${entityName}实体（删除前的数据）
     * @throws com.ums.service.common.exception.BizResourceNotFoundException 当要删除的资源不存在时
     * @throws com.ums.service.common.exception.BizInternalServerException 当删除过程发生异常时
     */
    ${entityName} delete(${common.getPrimaryType(fieldList)} id);

    /**
     * 批量删除${entityName}实体
     *
     * @param ids 要删除的实体的主键ID列表
     * @return 删除成功后，受影响的行数
     * @throws com.ums.service.common.exception.BizInternalServerException 当删除过程发生异常时
     */
    int batchDelete(List<${common.getPrimaryType(fieldList)}> ids);

    /**
     * 分页查询${entityName}列表
     *
     * @param queryDTO 分页查询条件，包含页码、每页记录数和查询条件
     * @return 分页数据，包含总记录数和当前页数据
     * @throws com.ums.service.common.exception.BizInternalServerException 当查询过程发生异常时
     */
    PageData<${entityName}> findByPage(${entityName}QueryDTO queryDTO);

    /**
     * 导出${entityName}数据到Excel
     *
     * TODO: 实现导出功能时需要注意以下几点：
     * 1. 参数校验：确保 outputStream 不为空
     * 2. 数据量控制：如果数据量过大，考虑分页导出或设置上限
     * 3. 异常处理：处理导出过程中可能出现的IO异常
     * 4. 性能优化：大数据量导出时注意内存使用
     *
     * @param queryDTO 查询条件，用于过滤要导出的数据
     * @param outputStream 输出流，用于写入Excel数据
     * @throws IOException 如果导出过程中发生IO异常
     * @throws IllegalArgumentException 如果参数无效
     */
    void exportToExcel(${entityName}QueryDTO queryDTO, OutputStream outputStream) throws IOException;

    /**
     * 从Excel导入${entityName}数据
     *
     * TODO: 实现导入功能时需要注意以下几点：
     * 1. 参数校验：确保 inputStream 不为空
     * 2. 数据校验：对Excel中的数据进行有效性校验，包括必填字段、数据格式等
     * 3. 事务处理：确保数据导入的原子性，如果部分数据无效应考虑是否回滚
     * 4. 重复数据处理：判断如何处理可能的重复数据（新增或更新）
     * 5. 错误报告：考虑返回详细的导入结果，包括成功/失败记录数量和具体错误信息
     *
     * @param inputStream 输入流，包含Excel数据
     * @return 导入的记录数
     * @throws IOException 如果导入过程中发生IO异常
     * @throws IllegalArgumentException 如果参数无效或Excel数据格式不正确
     */
    int importFromExcel(InputStream inputStream) throws IOException;

    /**
     * 生成并下载Excel导入模板
     *
     * TODO: 实现模板生成功能时需要注意以下几点：
     * 1. 模板头部：生成正确的列标题，与${entityName}ExcelDTO中的@ExcelProperty注解一致
     * 2. 示例数据：可以选择性地添加示例数据行，帮助用户理解如何填写
     * 3. 注释和说明：可以在模板中添加必要的注释和说明，如必填字段、数据格式等
     * 4. 样式设置：可以考虑设置单元格样式，如字体、颜色、背景色等
     *
     * @param outputStream 输出流，用于写入Excel模板数据
     * @throws IOException 如果生成模板过程中发生IO异常
     */
    void generateImportTemplate(OutputStream outputStream) throws IOException;

}