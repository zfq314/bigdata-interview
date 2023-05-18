#####  创建java项目模板
    mvn archetype:generate \
    -DarchetypeGroupId=org.apache.flink \
    -DarchetypeArtifactId=flink-quickstart-java \
    -DarchetypeVersion=1.15.3 \
    -DgroupId=cn.doitedu.flink \
    -DartifactId=flink-java \
    -Dversion=1.0 \
    -Dpackage=cn.doitedu.flink \
    -DinteractiveMode=false
#####  创建sacal项目模板
    mvn archetype:generate \
    -DarchetypeGroupId=org.apache.flink \
    -DarchetypeArtifactId=flink-quickstart-scala \
    -DarchetypeVersion=1.15.3 \
    -DgroupId=cn.doitedu.flink \
    -DartifactId=flink-scala \
    -Dversion=1.0 \
    -Dpackage=cn.doitedu.flink \
    -DinteractiveMode=false