package top.zfq.bigdata.interview.basic;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.TreeMap;
import java.util.concurrent.ConcurrentSkipListSet;

/**
 * @ClassName BasicList
 * @Description TODO list
 * @Author ZFQ
 * @Date 2023/5/18 15:45
 * @Version 1.0
 */
public class BasicCollection {
    public static void main(String[] args) {
        //需要初始化
        //List一个接口
        List list = new ArrayList();
        list.add('a');
        list.add('c');
        list.add('e');
        Object[] toArray= list.toArray();
        for (int i = 0; i < toArray.length; i++) {
            System.out.println(toArray[i]);
        }

        //List为一种有序可重复的接口集合
             // ArrayList 查询效率高 底层是数组
            // LinkedList 增删效率高 底层双向链表
           // Vector 线程安全 线程安全但是效率较慢因为他的方法大多采用synchronized进行修饰 底层也是数组
        //Set为一种无序不重复的接口集合
         //HashSet 使用HashMap key 是实现的
        //LinkedHashSet 增删效率高
        //AbstractSet
            //TreeSet 增删效率高 红黑树实现
            //ConcurrentSkipListSet 线程安全
        //Map是采用键值对形式的接口集合
            //HashMap 标准 Map实现
            //TreeMap 红黑树


     }
}