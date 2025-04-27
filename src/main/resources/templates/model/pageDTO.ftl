package ${packageName}.model.dto;

import ${packageName?substring(0, packageName?last_index_of('.'))}.common.dto.PageDTO;
import lombok.Data;
import lombok.experimental.Accessors;

import java.io.Serializable;

@Data
@Accessors(chain = true)
public class ${entityName}PageDTO extends PageDTO implements Serializable {
    // TODO 业务字段

}
