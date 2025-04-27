/* code generate by freemarker. */
package ${packageName}.controller;

import ${packageName}.model.dto.${entityName}PageDTO;
import ${packageName}.model.dto.${entityName}QueryDTO;
import ${packageName}.model.entity.${entityName};
import ${packageName}.service.${entityName}Service;
import com.ultrasafe.smart.service.web.log.DefaultOperation;
import com.ums.datasource.util.spring.PageData;
import com.ums.operation.log.core.OperationLog;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/v1/${entityName?lower_case}")
@Slf4j
@RequiredArgsConstructor
public class ${entityName}Controller {

    private final ${entityName}Service ${entityName?uncap_first}Service;

    @GetMapping("/page")
    public ResponseEntity<PageData<${entityName}>> queryPageData(${entityName}PageDTO pageDTO) {
        return ResponseEntity.ok(${entityName?uncap_first}Service.queryPageData(pageDTO));
    }

    @GetMapping("/list")
    public ResponseEntity<List<${entityName}>> queryList(${entityName}QueryDTO queryDTO) {
        return ResponseEntity.ok(${entityName?uncap_first}Service.queryList(queryDTO));
    }

    @GetMapping("{id}")
    public ResponseEntity<${entityName}> queryById(@PathVariable("id") String id) {
        return ResponseEntity.ok(${entityName?uncap_first}Service.queryById(id));
    }

    @GetMapping("/id-list")
    public ResponseEntity<List<${entityName}>> queryByIdList(List<String> idList) {
        return ResponseEntity.ok(${entityName?uncap_first}Service.queryByIdList(idList));
    }

    @PostMapping()
    @OperationLog(type = DefaultOperation.ADD, value = "添加${entityNameCN}")
    public ResponseEntity<Void> addPolicyWhitelist(@RequestBody ${entityName} ${entityName?uncap_first}) {
        ${entityName?uncap_first}Service.add(${entityName?uncap_first});
        return ResponseEntity.ok().build();
    }

    @PostMapping("/batch")
    @OperationLog(type = DefaultOperation.ADD, value = "批量添加${entityNameCN}")
    public ResponseEntity<Integer> addBatch(@RequestBody List<${entityName}> ${entityName?uncap_first}List) {
            return ResponseEntity.ok(${entityName?uncap_first}Service.addBatch(${entityName?uncap_first}List));
    }

    @DeleteMapping("{id}")
    @OperationLog(type = DefaultOperation.DELETE, value = "删除${entityNameCN}")
    public ResponseEntity<${entityName}> delete(@PathVariable("id") String id) {
        return ResponseEntity.ok(${entityName?uncap_first}Service.delete(id));
    }

    @DeleteMapping("/batch/id-list")
    @OperationLog(type = DefaultOperation.DELETE, value = "批量删除${entityNameCN}")
    public ResponseEntity<Integer> deleteBatch(@RequestBody List<String> idList) {
        return ResponseEntity.ok(${entityName?uncap_first}Service.deleteBatch(idList));
    }

    @PutMapping()
    @OperationLog(type = DefaultOperation.UPDATE, value = "编辑${entityNameCN}")
    public ResponseEntity<Void> update(@RequestBody ${entityName} ${entityName?uncap_first}) {
        ${entityName?uncap_first}Service.update(${entityName?uncap_first});
        return ResponseEntity.ok().build();
    }

    @PutMapping("/batch")
    @OperationLog(type = DefaultOperation.UPDATE, value = "批量编辑${entityNameCN}")
    public ResponseEntity<Integer> updateBatch(@RequestBody List<${entityName}> ${entityName?uncap_first}List) {
        return ResponseEntity.ok(${entityName?uncap_first}Service.updateBatch(${entityName?uncap_first}List));
    }

}