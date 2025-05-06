package ${packageName}.service.listener;

import ${packageName}.model.dto.${entityName}ExcelDTO;
import ${packageName}.model.entity.${entityName};
import ${packageName}.service.${entityName}Service;
import com.gamelike.util.SpringContextHolder;

import cn.idev.excel.read.listener.ReadListener;
import cn.idev.excel.context.AnalysisContext;
import lombok.extern.slf4j.Slf4j;
import org.springframework.util.ObjectUtils;
import com.ums.service.common.exception.BizInternalServerException;
import com.ums.service.common.exception.BizIllegalArgumentException;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * ${entityName}Excel导入监听器
 *
 * 用于处理FastExcel导入${entityName}数据的监听器
 * 实现了ReadListener接口，处理Excel读取过程中的数据
 * 提供数据校验、转换和保存功能
 *
 * @author freemarker auto generator
 * @version 1.0
 */
@Slf4j
public class ${entityName}ExcelImportListener implements ReadListener<${entityName}ExcelDTO> {

    /**
     * 有效的DTO列表，通过校验的数据
     */
    private final List<${entityName}ExcelDTO> validDTOs = new ArrayList<>();

    /**
     * 批处理大小，当累积的数据达到这个数量时进行一次批量保存
     */
    private static final int BATCH_SIZE = 500;

    /**
     * 获取${entityName}Service
     */
    private ${entityName}Service ${entityName?uncap_first}Service;

    @Override
    public void invoke(${entityName}ExcelDTO data, AnalysisContext context) {
        if (data == null) {
            return;
        }
        // 校验数据
        validateExcelDTO(data);
        // 校验通过，添加到有效列表
        validDTOs.add(data);
        // 当累积的有效数据达到批处理大小时，进行一次批量保存
        if (validDTOs.size() >= BATCH_SIZE) {
            batchSaveData();
        }
    }

    @Override
    public void doAfterAllAnalysed(AnalysisContext context) {
        // 处理剩余的有效数据
        if (!validDTOs.isEmpty()) {
            batchSaveData();
        }
    }

    /**
     * 批量保存数据
     */
    private void batchSaveData() {
        try {
            if (validDTOs.isEmpty()) {
                return;
            }
            // 转换为实体对象
            List<${entityName}> entities = validDTOs.stream()
                    .map(${entityName}ExcelDTO::toEntity)
                    .collect(Collectors.toList());
            // 批量保存
            ${entityName?uncap_first}Service.batchInsert(entities);
        } catch (Exception e) {
            log.error("批量保存数据失败", e);
            throw new BizInternalServerException(e.getMessage());
        } finally {
            // 清空已处理的数据
            validDTOs.clear();
        }
    }

    /**
     * 校验Excel DTO数据的有效性
     *
     * @param dto 要校验的Excel DTO
     * @throws IllegalArgumentException 如果数据无效
     */
    private void validateExcelDTO(${entityName}ExcelDTO dto) {
        if (dto == null) {
            throw new IllegalArgumentException("数据不能为空");
        }

        // 必填字段校验
<#list fieldList as fieldItem>
        if (ObjectUtils.isEmpty(dto.get${fieldItem.name?cap_first}())) {
            throw new BizIllegalArgumentException("${fieldItem.columnName}不能为空");
        }
</#list>

        // 数据格式校验（根据实际业务需求添加）
        // TODO 例如：日期格式、数值范围、字符串长度等

        // 业务规则校验（根据实际业务需求添加）
        // TODO 例如：关联数据有效性、业务逻辑约束等
    }
}