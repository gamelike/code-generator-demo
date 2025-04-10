/* code generate by freemarker. */
package ${packageName}.controller;

import ${packageName}.service.${entityName}Service;
import ${packageName}.model.${entityName};
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("v1")
@Slf4j
@RequiredArgsConstructor
public class ${entityName}Controller {

    private final ${entityName}Service ${entityName?uncap_first}Service;

    @GetMapping("{id}")
    public ResponseEntity<${entityName}> get(@PathVariable("id") String id) {
        return ResponseEntity.ok(${entityName?uncap_first}Service.queryById(id));
    }

    @DeleteMapping("{id}")
    public ResponseEntity<Void> delete(@PathVariable("id") String id) {
        ${entityName?uncap_first}Service.delete(id);
        return ResponseEntity.ok().build();
    }

    @PutMapping("new")
    public ResponseEntity<Void> new(@RequestBody ${entityName} ${entityName?uncap_first}) {
        ${entityName?uncap_first}Service.upsert(${entityName?uncap_first});
        return ResponseEntity.ok().build();
    }

    @PatchMapping("edit")
    public ResponseEntity<Void> edit(@RequestBody ${entityName} ${entityName?uncap_first}) {
        ${entityName?uncap_first}Service.upsert(${entityName?uncap_first});
        return ResponseEntity.ok().build();
    }
}