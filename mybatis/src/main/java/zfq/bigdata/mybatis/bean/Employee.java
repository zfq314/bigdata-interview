package zfq.bigdata.mybatis.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @ClassName Employee
 * @Description TODO
 * @Author ZFQ
 * @Date 2023/5/22 10:45
 * @Version 1.0
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Employee {
    private Integer id;
    private String  lastName;
    private String  gender;
    private String  email;
}