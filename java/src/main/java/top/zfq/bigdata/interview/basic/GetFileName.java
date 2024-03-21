package top.zfq.bigdata.interview.basic;

import java.io.File;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

/**
 * @ClassName GetFileName
 * @Description TODO
 * @Author ZFQ
 * @Date 2024/2/24 下午 02:21
 * @Version 1.0
 */
public class GetFileName {
    public static void main(String[] args) {
        //获取文件路径文件夹下的全部文件列表
        System.out.println("文件有如下：");
        orderByName("D:\\桌面\\全国报表2.0\\4、同步数据的json");
    }

    public static void orderByName(String filePath) {
        File file = new File(filePath);
        File[] files = file.listFiles();
        List fileList = Arrays.asList(files);
        Collections.sort(fileList, new Comparator<File>() {
            @Override
            public int compare(File o1, File o2) {
                if (o1.isDirectory() && o2.isFile())
                    return -1;
                if (o1.isFile() && o2.isDirectory())
                    return 1;
                return o1.getName().compareTo(o2.getName());
            }
        });
        for (File file1 : files) {
            System.out.println(file1.getName());

        }
    }
}