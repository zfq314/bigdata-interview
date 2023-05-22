package zfq.bigdata.mybatis.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import zfq.bigdata.mybatis.bean.Employee;

import java.util.List;

/**
 * @ClassName EmployeeMapper
 * @Description TODO
 * @Author ZFQ
 * @Date 2023/5/22 10:50
 * @Version 1.0
 */
/*
        Dao层接口在Mybatis中习惯称为Mapper。
        在接口上使用@Select注解表明当前方法被调用时，会执行一个Select语句。
        在接口上使用@Delete注解表明当前方法被调用时，会执行一个Delete语句。
        在接口上使用@Update注解表明当前方法被调用时，会执行一个Update语句。
        在接口上使用@Insert注解表明当前方法被调用时，会执行一个Insert语句。

        */
    // 传参数 单个 可以随便传
    // 多个必须和属性对应的
public interface EmployeeMapper {

    @Select("select * from employee where id=#{id}")
    Employee getEmpById(Integer id);

    @Select("select * from employee")
    List<Employee> getAll();

    //@Insert("insert into employee(lastname,gender,email) values(#{lastName},#{gender),#{email})")
    @Insert("insert into employee(lastname,gender,email) values(#{lastName},#{gender},#{email})")
    void insertEmp (Employee employee);

    @Delete("delete from employee where id=#{id}")
    void deleteEmpById(Integer id);

    @Update("update employee set lastname=#{lastName},gender=#{gender},email=#{email} where id=#{id}")
    void updateEmpById(Employee employee);

}