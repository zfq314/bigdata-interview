package zfq.bigdata.mybatis.mapper;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.Test;
import zfq.bigdata.mybatis.bean.Employee;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;


public class EmployeeMapperTest {

//    SqlSession由于不是线程安全的，因此不能作为静态变量或实例变量，而应该在每个方法中单独获取，并且使用完成后关闭。不可以在多个方法中共享sqlSession。

    private SqlSessionFactory sqlSessionFactory;

    {
        String resource = "mybatis.xml";
        InputStream inputStream = null;
        try {
            inputStream = Resources.getResourceAsStream(resource);
        } catch (IOException e) {
            e.printStackTrace();
        }
        sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
    }

    @Test
    public void getEmpById() {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        try {
            EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
            Employee employee = mapper.getEmpById(10);
            System.out.println(employee);
        } finally {
            sqlSession.close();
        }
    }

    @Test
    public void getAll() {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        try {
            EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
            List<Employee> all = mapper.getAll();
            System.out.println(all);
        } finally {
            sqlSession.close();
        }
    }

    @Test
    public void insertEmp() {
     //       事务自动提交
        SqlSession sqlSession = sqlSessionFactory.openSession(true);
        Employee employee = new Employee(null, "smn", "famale", "smn@qq.com");
        try {
            EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
            mapper.insertEmp(employee);

        }finally {
            sqlSession.close();
        }
    }
    @Test
    public void deleteEmp(){
        SqlSession sqlSession = sqlSessionFactory.openSession(true);

        try {
            EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
            mapper.deleteEmpById(7);
        }finally {
            sqlSession.close();
        }
    }
    @Test
    public void updateEmpById(){
        SqlSession sqlSession = sqlSessionFactory.openSession(true);

        try {
            EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
            Employee employee = mapper.getEmpById(6);
            employee.setLastName("wife");
            employee.setEmail("hbb521@.com");
            mapper.updateEmpById(employee);
            System.out.println(mapper.getEmpById(6));
         }finally {
            sqlSession.close();
        }
    }
}