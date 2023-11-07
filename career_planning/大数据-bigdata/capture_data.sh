#! /bin/bash

if [ -n "$2" ] ;then
    do_date=$2
else
    do_date=`date -d '-1 day' +%F`
fi
sqoop=/data/program/sqoop-1.4.6/bin/sqoop


database=decent_cloud
passwd=dba@2022app
user=dba

import_data() {
	$sqoop import -D mapred.job.queue.name=default \
	--driver com.mysql.cj.jdbc.Driver \
	--connect "jdbc:mysql://10.2.12.46:3306/decent_cloud?tinyInt1isBit=false&serverTimezone=GMT%2B8&&useSSL=false&useUnicode=true&characterEncoding=utf-8" \
	--fields-terminated-by "\t" \
	--username $user \
    --password $passwd \
	--delete-target-dir \
	--null-string '\\N' \
	--null-non-string '\\N' \
	--target-dir /decent_cloud_database/$1/$do_date \
	--delete-target-dir \
	--num-mappers 1 \
	--fields-terminated-by "\t" \
	--query "$2"' and  $CONDITIONS;'
}
import_cpbszb(){
import_data cpbszb " select DjLsh,
DjBth,
DjState,
xh,
JJB,
CKMC,
CKBM,
fjgf,
zhl,
plmc,
YJPLBM,
YJPL,
EJPLBM,
EJPL,
SPTM,
GCKH,
BZGF,
fjje,
plbm,
ZSMC,
ZSSL,
ZSZL,
JSMC,
bzsm,
JSBM,
JS,
SPMC,
EWM,
CXM,
SFXG,
ZLB,
ZKJEB,
YFJGF,
GFZK,
SFDZ,
YJJCGF,
JPGF,
JGF,
TSGF,
LJJJE,
DSB,
MZB,
YFJGF2,
PLJJGF,
DBDJ,
category_identity,
purity_name from $database.cpbszb where 1=1"
}
import_cpbszh(){
import_data cpbszh " select DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
XSZKH,
wdmc,
djh,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
wdbm,
khbm,
csmc,
khmc,
ZKHBM,
ZKHBH,
ZKH,
YWY,
lxr,
KHZJM,
zjz,
dz,
replace(replace(bz,'\n',''),'\t','') bz,
zdrid,
zdr,
zdsj,
shr,
DATE_FORMAT(shsj,'%Y-%m-%d %H:%i:%s') shsj,
CSBM,
CS,
ckdh,
hjje,
HJJS,
lxdh,
JSMCB,
PLMCB,
ZL,
JJ,
ZDBC,
TMXY,
DJZT,
DATE_FORMAT(ZFRQ,'%Y-%m-%d') ZFRQ,
QSH,
JSH,
FZGF,
ssckbm,
BQJGHJ,
DBTBZ,
ZKJEH,
CKMCH,
DZCQS,
YJLBH,
YJPLBMH,
DATE_FORMAT(KDRQ,'%Y-%m-%d %H:%i:%s') KDRQ,
GZBZ,
THDH,
THDJM,
ZCJZ,
DATE_FORMAT(GZRQ,'%Y-%m-%d %H:%i:%s') GZRQ,
CPBBS,
WC,
QY,
DST,
SHMC,
SHBM,
QHXH,
DB,
BDB,
BTCKMC,
BTCKBM,
B2BXS,
FCDH,
WDXAJBQ,
LM,
DSCSHJ,
CZCSHJ,
MZ,
ZKQR,
push_status from $database.cpbszh where 1=1"
}
import_cwwykhb_eos(){
import_data cwwykhb_eos " select DjLsh,
DjBth,
DjState,
WDMC,
KHMC,
KHBM,
ZKH,
ZKHBS from $database.cwwykhb_eos where 1=1"
}
import_cwwykhh_eos(){
import_data cwwykhh_eos " select DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
GSWD,
CWMC,
CWKHBM,
WHR,
ZHWHSJ from $database.cwwykhh_eos where 1=1"
}
import_dkhhyb_eos(){
import_data dkhhyb_eos " select DjLsh,
DjBth,
DjState,
WDMC,
KHMC,
KHBM,
ZKH,
ZKHBS,
FB011 from $database.dkhhyb_eos where 1=1"
}
import_dkhhyh_eos(){
import_data dkhhyh_eos " select DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
GSWD,
CWMC,
CWKHBM,
XGR,
DATE_FORMAT(XGSJ,'%Y-%m-%d %H:%i:%s') XGSJ from $database.dkhhyh_eos where 1=1"
}
import_dydfkczbh(){
import_data dydfkczbh " select DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
WDBM,
WDMC,
SSCKBM,
SSCKMC,
KCZT,
SPTM,
SPMC,
CJTM,
GSKH,
GCKH,
SFQX,
CHJLDW,
GLFS,
XSJJFS,
DPL,
PLMC,
WSCB,
BZCB,
WDCB,
BQJG,
GG,
JSYS,
ZZ,
HHZ,
SHL,
JJZ,
JDJ,
JCB,
ZSBH,
ZSMC,
ZSYS,
ZSXZ,
ZSJD,
ZSQG,
ZSDC,
ZSPG,
ZSYG,
ZSSL,
ZSZL,
ZSJJFS,
ZSCBDJ,
ZSCBJE,
ZSGYSBM,
ZSGYSMC,
ZSBH1,
ZSMC1,
ZSYG1,
ZSPG1,
ZSDC1,
ZSQG1,
ZSJD1,
ZSYS1,
ZSXZ1,
ZSZL1,
ZSSL1,
ZSJJFS1,
ZSCBDJ1,
ZSCBJE1,
ZSGYSBM1,
ZSGYSMC1,
DYZSZ,
FSBH1,
FSMC1,
FSSL1,
FSZL1,
FSJJFS1,
FSCBDJ1,
FSCBJE1,
FSGYSBM1,
FSGYSMC1,
FSBH2,
FSMC2,
FSSL2,
FSZL2,
FSJJFS2,
FSCBDJ2,
FSCBJE2,
FSGYSBM2,
FSGYSMC2,
FSBH3,
FSMC3,
FSSL3,
FSZL3,
FSJJFS3,
FSCBDJ3,
FSCBJE3,
FSGYSBM3,
FSGYSMC3,
FSBH4,
FSMC4,
FSSL4,
FSZL4,
FSJJFS4,
FSCBDJ4,
FSCBJE4,
FSBH5,
FSMC5,
FSSL5,
FSZL5,
FSJJFS5,
FSCBDJ5,
FSCBJE5,
FSGYSBM5,
FSGYSMC5,
FSBH6,
FSMC6,
FSSL6,
FSZL6,
FSJJFS6,
FSCBDJ6,
FSCBJE6,
FSGYSBM6,
FSGYSMC6,
FSBH7,
FSMC7,
FSSL7,
FSZL7,
FSJJFS7,
FSCBDJ7,
FSCBJE7,
FSGYSBM7,
FSGYSMC7,
FSBH8,
FSMC8,
FSSL8,
FSZL8,
FSJJFS8,
FSCBDJ8,
FSCBJE8,
FSGYSBM8,
FSGYSMC8,
FSBH9,
FSMC9,
FSSL9,
FSZL9,
FSJJFS9,
FSCBDJ9,
FSCBJE9,
FSGYSBM9,
FSGYSMC9,
FSBH10,
FSMC10,
FSSL10,
FSZL10,
FSJJFS10,
FSCBDJ10,
FSCBJE10,
DYFSZ,
FSGYSBM10,
FSGYSMC10,
CPGJZS,
CPGJZS1,
CPSJZS,
LZZS,
ZSZ1,
ZSF,
PJBH1,
PJMC1,
PJSL1,
PJZL1,
PBJJFS1,
PJCBDJ1,
PJCBJE1,
PJGYSBM1,
PJGYSMC1,
PJBH2,
PJMC2,
PJSL2,
PJZL2,
PJJJFS2,
PJCBDJ2,
PJCBJE2,
PJGYSBM2,
PJGYSMC2,
PJBH3,
PJMC3,
PJSL3,
PJZL3,
PJJJFS3,
PJCBDJ3,
PJCBJE3,
PJGYSBM3,
PJGYSMC3,
BKF,
LSF,
PSF,
FDF,
XSF,
JBGF,
QBF,
JGF,
QTFY,
FJGF,
FJF,
EWM,
CSBM,
CSMC,
JSCZ,
XSCZ,
KHBM,
SSJE,
GYSMC,
KDDH,
KDDJ,
RKSWLX,
KTTM,
KTTMWSCB,
CPSX,
JGLX,
GSMC,
GZ,
TJ,
JP,
JGSHS,
HJJ,
HCB,
JSJE,
JCB2,
SHZ,
AJHS,
HJLX,
QCRK,
ZSDZ,
XSZK,
ZTDBJSJ,
FZLS,
XDDDH,
XLMC,
BZHFY,
ZQFY,
ZGPJFY,
ZGBZHFY,
ZGZQFY from $database.dydfkczbh where 1=1"
}
import_fjgfzkbb(){
import_data fjgfzkbb " select DjLsh,
DjBth,
DjState,
XHB,
GFJE,
ZKL,
LJJJE from $database.fjgfzkbb where 1=1"
}
import_fjgfzkbh(){
import_data fjgfzkbh " select DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
DATE_FORMAT(SWRQ,'%Y-%m-%d %H:%i:%s') SWRQ,
WDBM,
WDMC,
KHBM,
KHMC,
ZKHBM,
ZKHMC,
ZKHBH,
replace(replace(BZ,'\n',''),'\t','') BZ,
ZDR,
ZDRID,
DATE_FORMAT(ZDSJ,'%Y-%m-%d %H:%i:%s') ZDSJ,
XGR,
XGRID,
XGSJ from $database.fjgfzkbh where 1=1"
}
import_gfjkhyhbb(){
import_data gfjkhyhbb " select DjLsh,
DjBth,
DjState,
XH,
YJPLBM,
YJPLMC,
EJPLBM,
EJPLMC,
JBGF,
LJJGFB,
PLJJGF from $database.gfjkhyhbb where 1=1"
}
import_gfjkhyhbh(){
import_data gfjkhyhbh " select DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
DJH,
WDBM,
WDMC,
KHBM,
KHMC,
ZKHMC,
ZKHBH,
KHZK,
LJJGF,
ZDRID,
ZDR,
DATE_FORMAT(ZDSJ,'%Y-%m-%d %H:%i:%s') ZDSJ,
XGRID,
XGR,
DATE_FORMAT(XGSJ,'%Y-%m-%d %H:%i:%s') XGSJ,
replace(replace(BZ,'\n',''),'\t','') BZ,
ZQCE,
KHQY,
CSMC,
MKH,
PLJJGFH from $database.gfjkhyhbh where 1=1"
}
import_gfjpxgfbh(){
import_data gfjpxgfbh " select DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
DJH,
WDBM,
WDMC,
CKBM,
CKMC,
PLBM,
ZJM,
PLMC,
EJPLBM,
EJPLMC,
EJPLZJM,
JBGF,
ZDRID,
ZDR,
DATE_FORMAT(ZDSJ,'%Y-%m-%d %H:%i:%s') ZDSJ,
XGRID,
XGR,
DATE_FORMAT(XGSJ,'%Y-%m-%d %H:%i:%s') XGSJ from $database.gfjpxgfbh where 1=1"
}
import_hjwwgcddb(){
import_data hjwwgcddb " select DjLsh,
DjBth,
DjState,
XHB,
KSBMB,
KSMCB,
GCKHB,
GCBMB,
GCMCB,
GCZJMB,
DLBMB,
DLMCB,
YJPLBMB,
YJPLMCB,
EJPLBMB,
EJPLMCB,
BSBMB,
BSMCB,
BSSLB,
BSZLB,
JCGFB,
GGB,
DZB,
XDJSB,
ZJZB,
GYYQB,
BZSMB,
DDXHB,
LHJSB,
LHJZB,
ZTB,
SKUHD2B,
MHB,
KHPPB,
KHDDHB,
SFXP,
DKJZ from $database.hjwwgcddb where 1=1"
}
import_hjwwgcddh(){
import_data hjwwgcddh " select DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
WWDDH,
DJZT,
WDBM,
WDMC,
CKBM,
CKMC,
CSMC,
QZDD,
WZDD,
XQDD,
YJDD,
GFJDD,
ZJWGDD,
ZJWQDD,
ZYNR,
KHBM,
KHMC,
KHDM,
DATE_FORMAT(XDRQ,'%Y-%m-%d %H:%i:%s') XDRQ,
DATE_FORMAT(QWJHRQ,'%Y-%m-%d %H:%i:%s') QWJHRQ,
WWYY,
JSHJ,
JZHJ,
DDLX,
GD,
KD,
BZSM,
ZDRID,
ZDRM,
DATE_FORMAT(ZDSJ,'%Y-%m-%d %H:%i:%s') ZDSJ,
XGRID,
XGRM,
XGSJ,
SHRID,
SHRM,
SHSJ,
JZRID,
JZRM,
JZSJ,
XDWDBM,
XDWDMC,
DDBH,
GYSBM,
GYSMC,
WWDDLSH,
RKJSHJ,
RKJZHJ,
ZDRY,
ZDRYID,
ZDZXSJ,
HXLX,
YCJSHJ,
YCJZHJ,
GFWJDD,
GFWZDD,
SFRFID,
OMSDDH,
QZCCJDD,
WZCCJDD,
QY from $database.hjwwgcddh where 1=1"
}
import_khlsedbh_eos(){
import_data khlsedbh_eos " select DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
DJH,
DATE_FORMAT(RQ,'%Y-%m-%d %H:%i:%s') RQ,
WDBM,
WDMCH,
TYKHBM,
TYKHMC,
ZKHMCH,
LSED,
ZKH,
ZDRID,
ZDR,
DATE_FORMAT(ZDSJ,'%Y-%m-%d %H:%i:%s') ZDSJ,
SHRID,
SHR,
DATE_FORMAT(SHSJ,'%Y-%m-%d %H:%i:%s') SHSJ,
LSJZ,
JJJ,
SPDH from $database.khlsedbh_eos where 1=1"
}
import_khxxh(){
import_data khxxh " select DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
SRFS,
qy,
kmbm,
khbm,
khmc,
khjc,
khyh,
yhzh,
sh,
dwdz,
dwdh,
cz,
gszy,
zjm,
fr,
frsfzh,
zw,
sjhm,
bgdh,
dzyj,
lrrid,
lrrxm,
lrsj,
zhwhr,
zhwhsj,
zxhjsxs,
zxhxsxs,
xydj,
xyed,
xysm,
fkqx,
jjqx,
jszk,
wdmc,
gsmc,
WDLX,
sjxqbm,
sjxqmc,
djsbm,
djsxx,
sxqbm,
sxqxx,
replace(replace(BZ,'\n',''),'\t','') bz,
pqbm,
pqmc,
gfyh,
kh,
gys,
SD,
rll,
ywy,
lxhm,
XXDZ,
DHHM,
LXRH,
WZJMS,
KHKH,
HTKSSJ,
HTJZSJ,
JMF,
PPSYF,
BZJ,
SJHM1,
DPZZQC,
DPJC,
KHQKM,
CSKHLX,
SYZKH,
WYID,
CWZY,
YYZZSMJ,
SFZSMJ,
YYZZHM,
YYFW,
YYZZYXQ,
KHSFZSMJ,
KHFL,
PPMC,
WZMC,
XB,
QYXZ,
GSZCZJ,
NXSE,
LXBM,
LXMC,
PPBM,
TJR,
GLZZH,
TSJNR,
WXH,
XQAH,
CGFZR,
CGRXB,
CGRSFZH,
CGRSJHM,
CGRZW,
SQTHR,
THRXB,
THRSFZH,
THRSJHM,
THRZW,
SQSYXQ,
ZDJHDZ,
XZBM,
XZXX,
SFXS,
KHLX from $database.khxxh where 1=1"
}
import_khxxszb(){
import_data khxxszb " select DjLsh,
DjBth,
DjState,
xh,
khwd,
lxr,
lxdh,
lxdz,
zjme,
LXDHB,
SFQY,
KHBH,
FRB,
FRSFZB,
YYZZHMB,
YYFWB,
SSSF,
DATE_FORMAT(JDRQ,'%Y-%m-%d %H:%i:%s') JDRQ,
PQMCB,
KHLXB,
WXHB,
SQTHRB,
SQTHRXBB,
THRSFZHB,
THRSJHMB,
DPZZQCB,
DJSXXB,
SXJXXB,
FRSJHB,
QYXZB,
KHLXNB,
PPMCB,
BZB,
DATE_FORMAT(YYZZYXQB,'%Y-%m-%d %H:%i:%s') YYZZYXQB,
DKWTRB,
DKWTRYXKHB,
DKWTRB2,
DKWTRYXHMB2,
DKWTRYXKHB2,
DKWTRZXB,
DKWTRFXB,
DKWTRYXB,
DKWTRYXB2,
DKWTRFXB2,
DKWTRZXB2,
DKWTRYXHMB,
DATE_FORMAT(SQYXQB,'%Y-%m-%d %H:%i:%s') SQYXQB,
DATE_FORMAT(SQYXQB2,'%Y-%m-%d %H:%i:%s') SQYXQB2,
SQYXQZFB,
SQYXQZFB2,
DGDS,
YWGSDB from $database.khxxszb where 1=1"
}
import_khxxszh(){
import_data khxxszh " select DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
SRFS,
CSMC,
qy,
kmbm,
khbm,
khmc,
khjc,
khyh,
yhzh,
sh,
dwdz,
dwdh,
cz,
gszy,
zjm,
fr,
frsfzh,
zw,
sjhm,
bgdh,
dzyj,
lrrid,
lrrxm,
DATE_FORMAT(lrsj,'%Y-%m-%d %H:%i:%s') lrsj,
zhwhr,
DATE_FORMAT(zhwhsj,'%Y-%m-%d %H:%i:%s') zhwhsj,
zxhjsxs,
zxhxsxs,
xydj,
xyed,
xysm,
fkqx,
jjqx,
jszk,
wdmc,
gsmc,
sjxqbm,
sjxqmc,
djsbm,
djsxx,
sxqbm,
sxqxx,
replace(replace(BZ,'\n',''),'\t','') bz,
pqbm,
pqmc,
gfyh,
kh,
gys,
SD,
rll,
ywy,
lxhm,
XXDZ,
DHHM,
LXRH,
WZJMS,
KHKH,
DATE_FORMAT(HTKSSJ,'%Y-%m-%d %H:%i:%s') HTKSSJ,
DATE_FORMAT(HTJZSJ,'%Y-%m-%d %H:%i:%s') HTJZSJ,
JMF,
PPSYF,
BZJ,
SYZKH,
SJHM1,
DPZZQC,
KHQKM,
CSKHLX,
WYID,
YYZZHM,
YYFW,
DATE_FORMAT(YYZZYXQ,'%Y-%m-%d %H:%i:%s') YYZZYXQ,
XB,
WXH,
QYXZ,
GSZCZJ,
NXSE,
TJR,
GLZZH,
CGFZR,
CGRZJH,
CGRSJHM,
CGRXB,
CGRZW,
SQTHR,
THRSFZH,
THRSJHM,
THRXB,
THRZW,
DATE_FORMAT(SQSYXQ,'%Y-%m-%d %H:%i:%s') SQSYXQ,
ZDJHDZ,
DATE_FORMAT(TSJNR,'%Y-%m-%d %H:%i:%s') TSJNR,
XQAH,
KHLX,
PPLX,
LXBM,
PPBM,
KHLXH,
YWGSD,
DKWTRYXHM,
DKWTRYXKH,
DKWTRYXHM2,
DKWTRYXKH2,
DKWTRYX,
DKWTRFX,
DKWTRZX,
DKWTRYX2,
DKWTRFX2,
DKWTRZX2,
DG,
DKWTR,
DKWTR2,
DS,
DATE_FORMAT(SQYXQ,'%Y-%m-%d %H:%i:%s') SQYXQ,
SQYXQZF,
DATE_FORMAT(SQYXQ2,'%Y-%m-%d %H:%i:%s') SQYXQ2,
SQYXQZF2 from $database.khxxszh where 1=1"
}
import_kjdswwrkdb(){
import_data kjdswwrkdb " select DjLsh,
DjBth,
DjState,
XH,
TMH,
BSBM,
BSYS,
JDBM,
BSJD,
YSBM,
BSQGBM,
BSQG,
JS,
ZL,
DJ,
JJFS,
BZB,
XSGF,
BSDM,
SZD,
SZDBM,
GG,
BSMC,
JE,
PLMC,
PLBM,
DYZSZ,
DYFSZ from $database.kjdswwrkdb where 1=1"
}
import_kjdswwrkdh(){
import_data kjdswwrkdh " select DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
DATE_FORMAT(SWRQ,'%Y-%m-%d %H:%i:%s') SWRQ,
WDBM,
WDMC,
CKBM,
CKMC,
GYSBM,
GYSMC,
SWLX,
DJH,
JSHJ,
SZHJ,
JEHJ,
ZDRID,
ZDR,
DATE_FORMAT(ZDSJ,'%Y-%m-%d %H:%i:%s') ZDSJ,
SHRID,
SHR,
DATE_FORMAT(SHSJ,'%Y-%m-%d %H:%i:%s') SHSJ,
XGRID,
XGR,
DATE_FORMAT(XGSJ,'%Y-%m-%d %H:%i:%s') XGSJ,
replace(replace(BZ,'\n',''),'\t','') BZ from $database.kjdswwrkdh where 1=1"
}
import_kjksbmxxh(){
import_data kjksbmxxh " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
DJZT,
CDLY,
DATE_FORMAT(JDRQ,'%Y-%m-%d %H:%i:%s') JDRQ,
QY,
ddsy,
YWSY,
SFFSH,
SFTX,
TJ,
WDBM,
WDMC,
KSBM,
KSMC,
kssm,
ZJM,
DLGSBM,
DLGSMC,
DLBM,
DLMC,
DLZJM,
PLBM,
PLMC,
XSCZBM,
XSCZ,
JSCZBM,
JSCZ,
PXBM,
PXMC,
XPXBM,
XPXMC,
KSFGBM,
KSFG,
SJYSBM,
SJYS,
KSSXBM,
KSSX,
JWDBM,
JWD,
JGGYBM,
JGGY,
XFBM,
XF,
XSWZBM,
XSWZ,
ZFXBM,
ZFX,
ZTXZBM,
ZTXZ,
ZXBM,
ZX,
ZSBM,
JBBM,
JB,
CZMCBM,
CZMC,
JJFSBM,
JJFS,
BXBM,
BX,
FJGF,
FJXSGF,
JGF,
ZGF,
QXDZ,
ZSMC,
ZSQSZL,
ZSJZZL,
ZSZLD,
ZSSL,
ZSXZBM,
ZSXZ,
ZSGG,
FSBM1,
FSMC1,
FSXZ1,
FSSL1,
FSQSZL1,
FSJZZL1,
FSZLD1,
FSGG1,
FSBM2,
FSMC2,
FSXZ2,
FSSL2,
FSQSZL2,
FSJZZL2,
FSZLD2,
FSGG2,
FSBM3,
FSMC3,
FSXZ3,
FSSL3,
FSQSZL3,
FSJZZL3,
FSGG3,
FSBM4,
FSMC4,
FSXZ4,
FSSL4,
FSQSZL4,
FSJZZL4,
FSGG4,
FSBM5,
FSMC5,
FSXZ5,
FSSL5,
FSQSZL5,
FSJZZL5,
FSGG5,
FSBM6,
FSMC6,
FSXZ6,
FSSL6,
FSQSZL6,
FSJZZL6,
FSGG6,
jys,
QSZL,
JZZL,
QSJZ,
JZJZ,
GCBMH,
XLBM,
XLMC,
TXBM,
TXMC,
JYKH,
BQJM,
GCMCH,
GCKHH,
replace(replace(BZ,'\n',''),'\t','') BZ,
CJRID,
CJRM,
CJSJ,
WHRID,
WHRM,
DATE_FORMAT(WHSJ,'%Y-%m-%d %H:%i:%s') WHSJ,
XSJJFS,
CPSXBM,
CPSX,
SHRID,
SHR,
DATE_FORMAT(SHSJ,'%Y-%m-%d %H:%i:%s') SHSJ,
JCGFH,
GCKHZJM,
TZJS,
TP,
GSMC,
YGSMC,
TYR,
TYRID,
TYSJ
 from $database.kjksbmxxh where 1=1"
}
import_kjxsgfb(){
import_data kjxsgfb " select 
DjLsh,
DjBth,
DjState,
HH,
YS,
YSBM,
GF,
SJXSGF,
XSJXSGF,
GQXSGF from $database.kjxsgfb where 1=1"
}
import_kjxsgfh(){
import_data kjxsgfh " select DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
KSBM,
KSMC,
PLMC,
ZDR,
DATE_FORMAT(ZDSJ,'%Y-%m-%d %H:%i:%s') ZDSJ,
XGR,
XGSJ,
XH,
TSJJ,
DJGF,
GCKHH,
GCMC,
XSJJFS,
QY,
BQJM,
XSGF
 from $database.kjxsgfh where 1=1"
}
import_ksdskcbh(){
import_data ksdskcbh " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
SPTM,
BSMC,
GG,
JJFS,
XSGF from $database.ksdskcbh where 1=1"
}
import_ksxxh(){
import_data ksxxh " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
xh,
gskh,
ksmc,
lbbm,
kslb,
sgx,
ddsy,
dlmc,
gsmc,
plmc,
xlmc,
xlfl,
qsgg,
jzgg,
zssl,
zsqsz,
zsjzz,
fssl,
fsqsz,
fsjzz,
jzfw,
qsjz,
jzjz,
sjrq,
sjr,
zdrid,
zdrxm,
DATE_FORMAT(ZDSJ,'%Y-%m-%d %H:%i:%s') zdsj,
xgrid,
xgrm,
xgsj,
replace(replace(BZ,'\n',''),'\t','') bz,
sfjp,
bzjz,
zjm,
sm,
PPFL,
GJPL,
SFYT from $database.ksxxh where 1=1"
}
import_kxjczbh_eos(){
import_data kxjczbh_eos " select DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
WDBM,
WDMC,
KHBM,
KHMC,
ZKHMC,
KXED,
KQZE,
KXZQ,
KQZL,
KCEB,
HCKXED,
RXSZE,
TYKHBM,
TYKHMC,
TYZKH,
DRJYZE,
JZ,
KQJZ,
KQJE,
MXTS,
DQJZ,
DQJE
 from $database.kxjczbh_eos where 1=1"
}
import_kxkskcbh(){
import_data kxkskcbh " select DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
SPTM,
KSBM,
KSMC,
GCKH,
LB,
GG,
JS,
HSZ,
ZSZ,
HHZ,
JJZ,
SHL,
JDJ,
JZE,
JSYS,
ZSBH,
ZSMC,
ZSXZ,
ZSYS,
ZSJD,
ZSSL,
ZSZL,
ZSDJ,
JJFS,
ZSZJ,
FSBH1,
FSMC1,
FSXZ1,
FSYS1,
FSJD1,
FSSL1,
FSZL1,
FSDJ1,
JJFS1,
FSZJ1,
FSBH2,
FSMC2,
FSXZ2,
FSYS2,
FSJD2,
FSSL2,
FSZL2,
FSDJ2,
JJFS2,
FSZJ2,
FSBH3,
FSMC3,
FSXZ3,
FSYS3,
FSJD3,
FSSL3,
FSZL3,
FSDJ3,
JJFS3,
FSZJ3,
FSXZ4,
FSBH4,
FSMC4,
FSYS4,
FSJD4,
FSSL4,
FSZL4,
FSDJ4,
JJFS4,
FSZJ4,
FSBH5,
FSMC5,
FSXZ5,
FSYS5,
FSJD5,
FSSL5,
FSZL5,
FSDJ5,
JJFS5,
FSZJ5,
FSBH6,
FSMC6,
FSXZ6,
FSYS6,
FSJD6,
FSSL6,
FSZL6,
FSDJ6,
JJFS6,
FSZJ6,
XSF,
STFY,
STZFY,
PJMC1,
PJJS1,
PJZL1,
PJDJ1,
JJFS7,
PJJE1,
PJMC2,
PJJS2,
PJZL2,
PJDJ2,
JJFS8,
PJJE2,
PJMC3,
PJJS3,
PJZL3,
PJDJ3,
JJFS9,
PJJE3,
PJZFY,
ZSH,
ZSF,
JBGF,
FJGF,
BKF,
QTFY,
ZJE,
CGJE,
replace(replace(BZ,'\n',''),'\t','') BZ,
BQJE,
ZT,
BQCB,
DZCB,
GSCK,
WDMC,
CBYKJRK,
SPMC,
BQGF
 from $database.kxkskcbh where 1=1"
}
import_llmxzh_eos(){
import_data llmxzh_eos " select DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
WDBM,
WDMC,
ZKH,
khbm,
khmc,
KHZJM,
JZ
 from $database.llmxzh_eos where 1=1"
}
import_lscqmxbb_eos(){
import_data lscqmxbb_eos " select 
DjLsh,
DjBth,
DjState,
DATE_FORMAT(RQ,'%Y-%m-%d %H:%i:%s') RQ,
DRDQZK,
DRLX,
DRWDQZK,
DRDQJZ,
DRWDQJZ,
BYGF,
SYGF,
CCJZ,
DRXZLX,
DRCCF,
YJD,
QZXL,
WZXL,
XLHZ,
SYLX,
SCBS,
YCCJZ,
YLX,
SYQL,
SYZQK,
YCCF,
KMXCCJZ from $database.lscqmxbb_eos where 1=1"
}
import_lscqmxbh_eos(){
import_data lscqmxbh_eos " select DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
WDMC,
WDBM,
KHMC,
KHBM,
ZKH,
ZJM,
WYID,
YCBS,
CWBZ,
ZTYC
 from $database.lscqmxbh_eos where 1=1"
}
import_lsedzbh_eos(){
import_data lsedzbh_eos " select DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
WDBM,
WDMC,
KHBM,
KHMC,
ZKHMC,
LSED,
KQZE,
KXZQ,
KQZL,
TYKHMC,
TYZKH,
TYKHBM,
MXTS
 from $database.lsedzbh_eos where 1=1"
}
import_mxzh_djlsh(){
import_data mxzh_djlsh " select 
djlsh from $database.mxzh_djlsh where 1=1"
}
import_mxzh_hw(){
import_data mxzh_hw " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
kczt,
kdzt,
sptm,
zshm,
giazs,
wdmc,
ckmc,
gysbm,
gys,
ppmc,
dlmc,
jsmc,
plmc,
gckh,
gskh,
gg,
spmc,
splx,
xlmc,
jz,
hz,
jgf,
xsgf,
sxf,
zsys,
zsjd,
zsqg,
zssl,
zszl,
fsmc,
fssl,
fszl,
js,
sjcb,
sccb,
bzjg,
bqjg,
dw,
khh,
ykj,
jp,
gflx,
pjsm,
cfhh,
replace(replace(BZ,'\n',''),'\t','') bz,
rkrq,
rkdh,
rkdm,
gxrq,
gxdh,
pdzt,
pddh,
lsdh,
lsrq,
xsdj,
sjzk,
ml,
mjj,
lsje,
jsdh,
jsrq,
jsje,
khmc,
ZSMC,
CXM,
EWM,
EWMX,
LBDM,
ZSCB,
FSCB,
WXFY,
BZCB,
ZSGG,
WXDM from $database.mxzh_hw where 1=1"
}
import_oss_file(){
import_data oss_file " select id,
file_name,
url,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time
 from $database.oss_file where 1=1"
}
import_plxxh(){
import_data plxxh " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
plfl,
plbm,
plmc,
ddsy,
gsbm,
gsmc,
whrid,
whrxm,
whrq,
zhwhr,
zhwhrq,
djzl,
kmmc,
GJPL,
GJQY from $database.plxxh where 1=1"
}
import_plxxszb(){
import_data plxxszb " select 
DjLsh,
DjBth,
DjState,
PLBM,
PLMC,
PLDM from $database.plxxszb where 1=1"
}
import_plxxszh(){
import_data plxxszh " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
WDBM,
WDMC,
CKBM,
CKMC,
whrid,
whrxm,
DATE_FORMAT(whrq,'%Y-%m-%d %H:%i:%s') whrq,
zhwhr,
DATE_FORMAT(zhwhrq,'%Y-%m-%d %H:%i:%s') zhwhrq from $database.plxxszh where 1=1"
}
import_plxxszs(){
import_data plxxszs " select 
DjLsh,
DjBth,
DjSth,
DjState,
EJBM,
EJPL,
ZJM from $database.plxxszs where 1=1"
}
import_print_template(){
import_data print_template " select 
id,
template_name,
print_service_name,
print_page_weight,
print_page_height,
if_page_limit,
status,
excel_json_str,
def_font_size,
flow_str from $database.print_template where 1=1"
}
import_qrtz_blob_triggers(){
import_data qrtz_blob_triggers " select 
SCHED_NAME,
TRIGGER_NAME,
TRIGGER_GROUP,
BLOB_DATA from $database.qrtz_blob_triggers where 1=1"
}
import_qrtz_calendars(){
import_data qrtz_calendars " select 
SCHED_NAME,
CALENDAR_NAME,
CALENDAR from $database.qrtz_calendars where 1=1"
}
import_qrtz_cron_triggers(){
import_data qrtz_cron_triggers " select 
SCHED_NAME,
TRIGGER_NAME,
TRIGGER_GROUP,
CRON_EXPRESSION,
TIME_ZONE_ID,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time from $database.qrtz_cron_triggers where 1=1"
}
import_qrtz_fired_triggers(){
import_data qrtz_fired_triggers " select 
SCHED_NAME,
ENTRY_ID,
TRIGGER_NAME,
TRIGGER_GROUP,
INSTANCE_NAME,
FIRED_TIME,
SCHED_TIME,
PRIORITY,
STATE,
JOB_NAME,
JOB_GROUP,
IS_NONCONCURRENT,
REQUESTS_RECOVERY from $database.qrtz_fired_triggers where 1=1"
}
import_qrtz_job_details(){
import_data qrtz_job_details " select SCHED_NAME,
JOB_NAME,
JOB_GROUP,
DESCRIPTION,
JOB_CLASS_NAME,
IS_DURABLE,
IS_NONCONCURRENT,
IS_UPDATE_DATA,
REQUESTS_RECOVERY,
JOB_DATA
 from $database.qrtz_job_details where 1=1"
}
import_qrtz_locks(){
import_data qrtz_locks " select SCHED_NAME,
LOCK_NAME
 from $database.qrtz_locks where 1=1"
}
import_qrtz_paused_trigger_grps(){
import_data qrtz_paused_trigger_grps " select 
SCHED_NAME,
TRIGGER_GROUP from $database.qrtz_paused_trigger_grps where 1=1"
}
import_qrtz_scheduler_state(){
import_data qrtz_scheduler_state " select SCHED_NAME,
INSTANCE_NAME,
LAST_CHECKIN_TIME,
CHECKIN_INTERVAL
 from $database.qrtz_scheduler_state where 1=1"
}
import_qrtz_simple_triggers(){
import_data qrtz_simple_triggers " select 
SCHED_NAME,
TRIGGER_NAME,
TRIGGER_GROUP,
REPEAT_COUNT,
REPEAT_INTERVAL,
TIMES_TRIGGERED from $database.qrtz_simple_triggers where 1=1"
}
import_qrtz_simprop_triggers(){
import_data qrtz_simprop_triggers " select SCHED_NAME,
TRIGGER_NAME,
TRIGGER_GROUP,
STR_PROP_1,
STR_PROP_2,
STR_PROP_3,
INT_PROP_1,
INT_PROP_2,
LONG_PROP_1,
LONG_PROP_2,
DEC_PROP_1,
DEC_PROP_2,
BOOL_PROP_1,
BOOL_PROP_2
 from $database.qrtz_simprop_triggers where 1=1"
}
import_qrtz_triggers(){
import_data qrtz_triggers " select 
SCHED_NAME,
TRIGGER_NAME,
TRIGGER_GROUP,
JOB_NAME,
JOB_GROUP,
DESCRIPTION,
NEXT_FIRE_TIME,
PREV_FIRE_TIME,
PRIORITY,
TRIGGER_STATE,
TRIGGER_TYPE,
START_TIME,
END_TIME,
CALENDAR_NAME,
MISFIRE_INSTR,
JOB_DATA from $database.qrtz_triggers where 1=1"
}
import_qyqxfph_eos(){
import_data qyqxfph_eos " select DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
CZR,
CZRID,
QYMC,
XGR,
DATE_FORMAT(XGSJ,'%Y-%m-%d %H:%i:%s') XGSJ
 from $database.qyqxfph_eos where 1=1"
}
import_qzj(){
import_data qzj " select 
xh,
sf,
khmc,
replace(replace(BZ,'\n',''),'\t','') bz,
zy,
zkhyy,
sfks,
sqqx,
xtkhmc,
xtzkhmc,
customer_identity,
DATE_FORMAT(expired_date,'%Y-%m-%d') expired_date
 from $database.qzj where 1=1"
}
import_rp_category_daily_sale(){
import_data rp_category_daily_sale " select DATE_FORMAT(record_date,'%Y-%m-%d %H:%i:%s') record_date,
showroom_identity,
showroom_name,
category_identity,
category_name,
sale_weight,
daily_total,
weight_percent
 from $database.rp_category_daily_sale where 1=1"
}
import_rp_category_daily_sale_eos(){
import_data rp_category_daily_sale_eos " select DATE_FORMAT(record_date,'%Y-%m-%d %H:%i:%s') record_date,
showroom_identity,
showroom_name,
category_identity,
category_name,
sale_weight,
daily_total,
weight_percent
 from $database.rp_category_daily_sale_eos where 1=1"
}
import_rp_category_hour_sale(){
import_data rp_category_hour_sale " select DATE_FORMAT(record_date,'%Y-%m-%d %H:%i:%s') record_date,
showroom_identity,
showroom_name,
category_identity,
category_name,
hours,
sale_weight,
daily_total,
weight_percent
 from $database.rp_category_hour_sale where 1=1"
}
import_rp_category_monthly_sale(){
import_data rp_category_monthly_sale " select 
DATE_FORMAT(record_month,'%Y-%m-%d %H:%i:%s') record_month,
showroom_identity,
showroom_name,
category_identity,
category_name,
sale_weight,
monthly_total,
weight_percent from $database.rp_category_monthly_sale where 1=1"
}
import_rp_category_monthly_sale_eos(){
import_data rp_category_monthly_sale_eos " select 
DATE_FORMAT(record_month,'%Y-%m-%d %H:%i:%s') record_month,
showroom_identity,
showroom_name,
category_identity,
category_name,
sale_weight,
monthly_total,
weight_percent from $database.rp_category_monthly_sale_eos where 1=1"
}
import_rp_category_year_sale(){
import_data rp_category_year_sale " select DATE_FORMAT(record_year,'%Y-%m-%d %H:%i:%s') record_year,
showroom_identity,
showroom_name,
category_identity,
category_name,
sale_weight,
year_total,
weight_percent
 from $database.rp_category_year_sale where 1=1"
}
import_rp_category_year_sale_eos(){
import_data rp_category_year_sale_eos " select 
DATE_FORMAT(record_year,'%Y-%m-%d %H:%i:%s') record_year,
showroom_identity,
showroom_name,
category_identity,
category_name,
sale_weight,
year_total,
weight_percent from $database.rp_category_year_sale_eos where 1=1"
}
import_rp_counter_category_daily_sale(){
import_data rp_counter_category_daily_sale " select 
DATE_FORMAT(record_date,'%Y-%m-%d %H:%i:%s') record_date,
showroom_identity,
showroom_name,
counter_identity,
counter_name,
purity_identity,
purity_name,
genus_identity,
genus_name,
category_identity,
category_name,
sale_weight,
daily_total,
weight_percent from $database.rp_counter_category_daily_sale where 1=1"
}
import_rp_counter_category_daily_sale_eos(){
import_data rp_counter_category_daily_sale_eos " select 
DATE_FORMAT(record_date,'%Y-%m-%d %H:%i:%s') record_date,
showroom_identity,
showroom_name,
counter_identity,
counter_name,
purity_identity,
purity_name,
genus_identity,
genus_name,
category_identity,
category_name,
sale_weight,
daily_total,
weight_percent from $database.rp_counter_category_daily_sale_eos where 1=1"
}
import_rp_counter_category_hour_sale(){
import_data rp_counter_category_hour_sale " select DATE_FORMAT(record_date,'%Y-%m-%d %H:%i:%s') record_date,
showroom_identity,
showroom_name,
counter_identity,
counter_name,
purity_identity,
purity_name,
genus_identity,
genus_name,
category_identity,
category_name,
hours,
sale_weight,
daily_total,
weight_percent
 from $database.rp_counter_category_hour_sale where 1=1"
}
import_rp_counter_category_monthly_sale(){
import_data rp_counter_category_monthly_sale " select 
DATE_FORMAT(record_month,'%Y-%m-%d %H:%i:%s') record_month,
showroom_identity,
showroom_name,
counter_identity,
counter_name,
purity_identity,
purity_name,
genus_identity,
genus_name,
category_identity,
category_name,
sale_weight,
monthly_total,
weight_percent from $database.rp_counter_category_monthly_sale where 1=1"
}
import_rp_counter_category_monthly_sale_eos(){
import_data rp_counter_category_monthly_sale_eos " select 
DATE_FORMAT(record_month,'%Y-%m-%d %H:%i:%s') record_month,
showroom_identity,
showroom_name,
counter_identity,
counter_name,
purity_identity,
purity_name,
genus_identity,
genus_name,
category_identity,
category_name,
sale_weight,
monthly_total,
weight_percent from $database.rp_counter_category_monthly_sale_eos where 1=1"
}
import_rp_counter_category_year_sale(){
import_data rp_counter_category_year_sale " select 
DATE_FORMAT(record_year,'%Y-%m-%d %H:%i:%s') record_year,
showroom_identity,
showroom_name,
counter_identity,
counter_name,
purity_identity,
purity_name,
genus_identity,
genus_name,
category_identity,
category_name,
sale_weight,
year_total,
weight_percent from $database.rp_counter_category_year_sale where 1=1"
}
import_rp_counter_category_year_sale_eos(){
import_data rp_counter_category_year_sale_eos " select 
DATE_FORMAT(record_year,'%Y-%m-%d %H:%i:%s') record_year,
showroom_identity,
showroom_name,
counter_identity,
counter_name,
purity_identity,
purity_name,
genus_identity,
genus_name,
category_identity,
category_name,
sale_weight,
year_total,
weight_percent from $database.rp_counter_category_year_sale_eos where 1=1"
}
import_rp_counter_daily_sale(){
import_data rp_counter_daily_sale " select 
DATE_FORMAT(record_date,'%Y-%m-%d %H:%i:%s') record_date,
showroom_identity,
showroom_name,
counter_identity,
counter_name,
purity_identity,
purity_name,
genus_identity,
genus_name,
sale_weight,
daily_total,
weight_percent,
balance_qty from $database.rp_counter_daily_sale where 1=1"
}
import_rp_counter_daily_sale_eos(){
import_data rp_counter_daily_sale_eos " select DATE_FORMAT(record_date,'%Y-%m-%d %H:%i:%s') record_date,
showroom_identity,
showroom_name,
counter_identity,
counter_name,
purity_identity,
purity_name,
genus_identity,
genus_name,
sale_weight,
daily_total,
weight_percent,
balance_qty
 from $database.rp_counter_daily_sale_eos where 1=1"
}
import_rp_counter_hour_sale(){
import_data rp_counter_hour_sale " select DATE_FORMAT(record_date,'%Y-%m-%d %H:%i:%s') record_date,
showroom_identity,
showroom_name,
counter_identity,
counter_name,
purity_identity,
purity_name,
genus_identity,
genus_name,
hours,
sale_weight,
balance_qty
 from $database.rp_counter_hour_sale where 1=1"
}
import_rp_counter_monthly_sale(){
import_data rp_counter_monthly_sale " select 
DATE_FORMAT(record_month,'%Y-%m-%d %H:%i:%s') record_month,
showroom_identity,
showroom_name,
counter_identity,
counter_name,
purity_identity,
purity_name,
genus_identity,
genus_name,
sale_weight,
monthly_total,
weight_percent,
balance_qty from $database.rp_counter_monthly_sale where 1=1"
}
import_rp_counter_monthly_sale_eos(){
import_data rp_counter_monthly_sale_eos " select 
DATE_FORMAT(record_month,'%Y-%m-%d %H:%i:%s') record_month,
showroom_identity,
showroom_name,
counter_identity,
counter_name,
purity_identity,
purity_name,
genus_identity,
genus_name,
sale_weight,
monthly_total,
weight_percent,
balance_qty from $database.rp_counter_monthly_sale_eos where 1=1"
}
import_rp_counter_year_sale(){
import_data rp_counter_year_sale " select 
DATE_FORMAT(record_year,'%Y-%m-%d %H:%i:%s') record_year,
showroom_identity,
showroom_name,
counter_identity,
counter_name,
purity_identity,
purity_name,
genus_identity,
genus_name,
sale_weight,
year_total,
weight_percent,
balance_qty from $database.rp_counter_year_sale where 1=1"
}
import_rp_counter_year_sale_eos(){
import_data rp_counter_year_sale_eos " select 
DATE_FORMAT(record_year,'%Y-%m-%d %H:%i:%s') record_year,
showroom_identity,
showroom_name,
counter_identity,
counter_name,
purity_identity,
purity_name,
genus_identity,
genus_name,
sale_weight,
year_total,
weight_percent,
balance_qty from $database.rp_counter_year_sale_eos where 1=1"
}
import_rp_daily_counter_work(){
import_data rp_daily_counter_work " select 
DATE_FORMAT(record_date,'%Y-%m-%d %H:%i:%s') record_date,
showroom_identity,
showroom_name,
counter_identity,
counter_name,
user_identity,
user_name,
customer_qty,
create_package_qty,
create_package_weight from $database.rp_daily_counter_work where 1=1"
}
import_rp_daily_customer_buy(){
import_data rp_daily_customer_buy " select 
DATE_FORMAT(record_date,'%Y-%m-%d %H:%i:%s') record_date,
showroom_identity,
showroom_name,
customer_identity,
customer_name,
buy_weight,
total_weight,
weight_percent,
is_engrave,
is_label from $database.rp_daily_customer_buy where 1=1"
}
import_rp_daily_customer_buy_eos(){
import_data rp_daily_customer_buy_eos " select 
DATE_FORMAT(record_date,'%Y-%m-%d %H:%i:%s') record_date,
showroom_identity,
showroom_name,
customer_identity,
customer_name,
buy_weight,
total_weight,
weight_percent,
is_engrave,
is_label from $database.rp_daily_customer_buy_eos where 1=1"
}
import_rp_daily_package_diff(){
import_data rp_daily_package_diff " select 
DATE_FORMAT(record_date,'%Y-%m-%d %H:%i:%s') record_date,
showroom_identity,
showroom_name,
diff_qty,
diff_minutes from $database.rp_daily_package_diff where 1=1"
}
import_rp_daily_package_diff_eos(){
import_data rp_daily_package_diff_eos " select 
DATE_FORMAT(record_date,'%Y-%m-%d %H:%i:%s') record_date,
showroom_identity,
showroom_name,
diff_qty,
diff_minutes from $database.rp_daily_package_diff_eos where 1=1"
}
import_rp_daily_package_stay(){
import_data rp_daily_package_stay " select 
DATE_FORMAT(record_date,'%Y-%m-%d %H:%i:%s') record_date,
showroom_identity,
showroom_name,
customer_identity,
customer_name,
package_code,
stay_minutes,
is_out,
is_today from $database.rp_daily_package_stay where 1=1"
}
import_rp_daily_package_stay_eos(){
import_data rp_daily_package_stay_eos " select 
DATE_FORMAT(record_date,'%Y-%m-%d %H:%i:%s') record_date,
showroom_identity,
showroom_name,
customer_identity,
customer_name,
package_code,
stay_minutes,
is_out,
is_today from $database.rp_daily_package_stay_eos where 1=1"
}
import_rp_daily_salesman(){
import_data rp_daily_salesman " select 
DATE_FORMAT(record_date,'%Y-%m-%d %H:%i:%s') record_date,
showroom_identity,
showroom_name,
salesman_identity,
salesman_name,
customer_qty,
balance_qty,
balance_weight from $database.rp_daily_salesman where 1=1"
}
import_rp_hour_counter_work(){
import_data rp_hour_counter_work " select 
DATE_FORMAT(record_date,'%Y-%m-%d %H:%i:%s') record_date,
showroom_identity,
showroom_name,
counter_identity,
counter_name,
user_identity,
user_name,
hours,
customer_qty,
create_package_qty,
create_package_weight from $database.rp_hour_counter_work where 1=1"
}
import_rp_hour_salesman(){
import_data rp_hour_salesman " select 
DATE_FORMAT(record_date,'%Y-%m-%d %H:%i:%s') record_date,
showroom_identity,
showroom_name,
salesman_identity,
salesman_name,
hours,
customer_qty,
balance_qty,
balance_weight from $database.rp_hour_salesman where 1=1"
}
import_rp_monthly_counter_work(){
import_data rp_monthly_counter_work " select DATE_FORMAT(record_month,'%Y-%m-%d %H:%i:%s') record_month,
showroom_identity,
showroom_name,
counter_identity,
counter_name,
user_identity,
user_name,
customer_qty,
create_package_qty,
create_package_weight
 from $database.rp_monthly_counter_work where 1=1"
}
import_rp_monthly_customer_buy(){
import_data rp_monthly_customer_buy " select 
DATE_FORMAT(record_month,'%Y-%m-%d %H:%i:%s') record_month,
showroom_identity,
showroom_name,
customer_identity,
customer_name,
buy_weight,
total_weight,
weight_percent from $database.rp_monthly_customer_buy where 1=1"
}
import_rp_monthly_customer_buy_eos(){
import_data rp_monthly_customer_buy_eos " select 
DATE_FORMAT(record_month,'%Y-%m-%d %H:%i:%s') record_month,
showroom_identity,
showroom_name,
customer_identity,
customer_name,
buy_weight,
total_weight,
weight_percent from $database.rp_monthly_customer_buy_eos where 1=1"
}
import_rp_monthly_salesman(){
import_data rp_monthly_salesman " select 
DATE_FORMAT(record_month,'%Y-%m-%d %H:%i:%s') record_month,
showroom_identity,
showroom_name,
salesman_identity,
salesman_name,
customer_qty,
balance_qty,
balance_weight from $database.rp_monthly_salesman where 1=1"
}
import_rp_purity_daily_sale(){
import_data rp_purity_daily_sale " select DATE_FORMAT(record_date,'%Y-%m-%d %H:%i:%s') record_date,
showroom_identity,
showroom_name,
purity_identity,
purity_name,
sale_weight,
daily_total,
weight_percent
 from $database.rp_purity_daily_sale where 1=1"
}
import_rp_purity_daily_sale_eos(){
import_data rp_purity_daily_sale_eos " select 
DATE_FORMAT(record_date,'%Y-%m-%d %H:%i:%s') record_date,
showroom_identity,
showroom_name,
purity_identity,
purity_name,
sale_weight,
daily_total,
weight_percent from $database.rp_purity_daily_sale_eos where 1=1"
}
import_rp_purity_hour_sale(){
import_data rp_purity_hour_sale " select 
DATE_FORMAT(record_date,'%Y-%m-%d %H:%i:%s') record_date,
showroom_identity,
showroom_name,
purity_identity,
purity_name,
hours,
sale_weight,
daily_total,
weight_percent from $database.rp_purity_hour_sale where 1=1"
}
import_rp_purity_monthly_sale(){
import_data rp_purity_monthly_sale " select 
DATE_FORMAT(record_month,'%Y-%m-%d %H:%i:%s') record_month,
showroom_identity,
showroom_name,
purity_identity,
purity_name,
sale_weight,
monthly_total,
weight_percent from $database.rp_purity_monthly_sale where 1=1"
}
import_rp_purity_monthly_sale_eos(){
import_data rp_purity_monthly_sale_eos " select 
DATE_FORMAT(record_month,'%Y-%m-%d %H:%i:%s') record_month,
showroom_identity,
showroom_name,
purity_identity,
purity_name,
sale_weight,
monthly_total,
weight_percent from $database.rp_purity_monthly_sale_eos where 1=1"
}
import_rp_purity_weekly_sale(){
import_data rp_purity_weekly_sale " select 
DATE_FORMAT(record_week,'%Y-%m-%d %H:%i:%s') record_week,
showroom_identity,
showroom_name,
purity_identity,
purity_name,
sale_weight,
weekly_total,
weight_percent from $database.rp_purity_weekly_sale where 1=1"
}
import_rp_purity_year_sale(){
import_data rp_purity_year_sale " select 
DATE_FORMAT(record_year,'%Y-%m-%d %H:%i:%s') record_year,
showroom_identity,
showroom_name,
purity_identity,
purity_name,
sale_weight,
year_total,
weight_percent from $database.rp_purity_year_sale where 1=1"
}
import_rp_purity_year_sale_eos(){
import_data rp_purity_year_sale_eos " select 
DATE_FORMAT(record_year,'%Y-%m-%d %H:%i:%s') record_year,
showroom_identity,
showroom_name,
purity_identity,
purity_name,
sale_weight,
year_total,
weight_percent from $database.rp_purity_year_sale_eos where 1=1"
}
import_rp_sales_data_eos(){
import_data rp_sales_data_eos " select 
PACKAGE_CODE,
SHOWROOM_IDENTITY,
SHOWROOM_NAME,
COUNTER_IDENTITY,
COUNTER_NAME,
CREATE_USER_IDENTITY,
CREATE_USER_NAME,
SALESMAN_IDENTITY,
SALESMAN_NAME,
PURITY_IDENTITY,
PURITY_NAME,
GENUS_IDENTITY,
GENUS_NAME,
CATEGORY_IDENTITY,
CATEGORY_NAME,
DATE_FORMAT(PACKAGE_CREATE_TIME,'%Y-%m-%d %H:%i:%s') PACKAGE_CREATE_TIME,
DATE_FORMAT(PACKAGE_EXAMINE_TIME,'%Y-%m-%d %H:%i:%s') PACKAGE_EXAMINE_TIME,
ORDER_ID,
DATE_FORMAT(ORDER_CREATE_TIME,'%Y-%m-%d %H:%i:%s') ORDER_CREATE_TIME,
DATE_FORMAT(ORDER_EXAMINE_TIME,'%Y-%m-%d %H:%i:%s') ORDER_EXAMINE_TIME,
CUSTOMER_IDENTITY,
CUSTOMER_NAME,
SALE_WEIGHT,
DATE_FORMAT(LEAVE_COUNTER_TIME,'%Y-%m-%d %H:%i:%s') LEAVE_COUNTER_TIME,
IS_COMPLETE from $database.rp_sales_data_eos where 1=1"
}
import_rp_sales_data_eos_sync(){
import_data rp_sales_data_eos_sync " select 
package_code,
package_detail_seq,
showroom_code,
showroom_name,
counter_name,
create_user_id,
create_user_name,
salesman_name,
purity_code,
purity_name,
category_code,
genus_name,
category_name,
second_category_code,
second_category_name,
DATE_FORMAT(package_create_time,'%Y-%m-%d %H:%i:%s') package_create_time,
DATE_FORMAT(package_examine_time,'%Y-%m-%d %H:%i:%s') package_examine_time,
order_id,
DATE_FORMAT(order_create_time,'%Y-%m-%d %H:%i:%s') order_create_time,
DATE_FORMAT(order_examine_time,'%Y-%m-%d %H:%i:%s') order_examine_time,
customer_code_eos,
customer_name,
sale_weight,
is_complete from $database.rp_sales_data_eos_sync where 1=1"
}
import_rp_showroom_hour_record(){
import_data rp_showroom_hour_record " select DATE_FORMAT(record_date,'%Y-%m-%d %H:%i:%s') record_date,
showroom_identity,
showroom_name,
hours,
customer_qty,
balance_qty,
sale_weight
 from $database.rp_showroom_hour_record where 1=1"
}
import_rp_szztkhrxsbb(){
import_data rp_szztkhrxsbb " select 
DATE_FORMAT(record_date,'%Y-%m-%d') record_date,
xh,
khbm,
khmc,
plm,
jjjz,
jjje,
dljz,
dlje,
fcpzl,
hlzl,
hlgf,
rljz,
qxwx,
rlGF,
qxGF,
xqjs,
xqgf,
qtje,
hjzl,
hjje,
zqszl,
zqgf,
fjgf,
tsjz,
tsgf,
tsjs,
yyf from $database.rp_szztkhrxsbb where 1=1"
}
import_rp_szztxsrb(){
import_data rp_szztxsrb " select 
DATE_FORMAT(record_date,'%Y-%m-%d') record_date,
xh,
plm,
jjjz,
jjje,
dljz,
dlje,
fcpzl,
hlzl,
hlgf,
rljz,
qxwx,
rlgf,
qxGF,
xqjs,
xqgf,
qtje,
hjzl,
hjje,
zqszl,
zqgf,
fjgf from $database.rp_szztxsrb where 1=1"
}
import_rp_time_code(){
import_data rp_time_code " select 
time_code,
time_name,
time_type from $database.rp_time_code where 1=1"
}
import_rp_today_customer_buy(){
import_data rp_today_customer_buy " select 
DATE_FORMAT(record_date,'%Y-%m-%d %H:%i:%s') record_date,
showroom_identity,
showroom_name,
customer_identity,
customer_name,
buy_weight,
total_weight,
weight_percent,
is_engrave,
is_label from $database.rp_today_customer_buy where 1=1"
}
import_rp_total_package_stay(){
import_data rp_total_package_stay " select 
showroom_identity,
showroom_name,
package_qty,
stay_minutes from $database.rp_total_package_stay where 1=1"
}
import_rp_total_package_stay_eos(){
import_data rp_total_package_stay_eos " select 
showroom_identity,
showroom_name,
package_qty,
stay_minutes from $database.rp_total_package_stay_eos where 1=1"
}
import_rp_year_counter_work(){
import_data rp_year_counter_work " select 
DATE_FORMAT(record_year,'%Y-%m-%d %H:%i:%s') record_year,
showroom_identity,
showroom_name,
counter_identity,
counter_name,
user_identity,
user_name,
customer_qty,
create_package_qty,
create_package_weight from $database.rp_year_counter_work where 1=1"
}
import_rp_year_customer_buy(){
import_data rp_year_customer_buy " select 
DATE_FORMAT(record_year,'%Y-%m-%d %H:%i:%s') record_year,
showroom_identity,
showroom_name,
customer_identity,
customer_name,
buy_weight,
total_weight,
weight_percent from $database.rp_year_customer_buy where 1=1"
}
import_rp_year_customer_buy_eos(){
import_data rp_year_customer_buy_eos " select 
DATE_FORMAT(record_year,'%Y-%m-%d %H:%i:%s') record_year,
showroom_identity,
showroom_name,
customer_identity,
customer_name,
buy_weight,
total_weight,
weight_percent from $database.rp_year_customer_buy_eos where 1=1"
}
import_rp_year_salesman(){
import_data rp_year_salesman " select 
DATE_FORMAT(record_year,'%Y-%m-%d %H:%i:%s') record_year,
showroom_identity,
showroom_name,
salesman_identity,
salesman_name,
customer_qty,
balance_qty,
balance_weight from $database.rp_year_salesman where 1=1"
}
import_spxxkczh(){
import_data spxxkczh " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
PDZT,
KCZT,
WDBM,
WDMC,
CKBM,
CKMC,
SWLX,
CSBM,
CSMC,
XSCZBM,
XSCZMC,
JSCZBM,
JSCZMC,
SPTM,
SPMC,
CJTM,
GSKH,
GCKH,
KSMC,
SFQX,
DLBM,
DLMC,
PLBM,
PLMC,
CHJLDW,
GLFS,
XSJJFS,
GG,
JSYSBM,
JSYSMC,
WSCB,
BZCB,
WDCB,
BQJG,
SSJE,
ZZ,
HHJZ,
SHL,
FJSHL,
GSSH,
JJZ,
JDJ,
JCB,
BZJDJ,
BZJCB,
ZSBM,
ZSMC,
XZBM,
XZ,
YSBM,
YS,
JDBM,
JD,
PGBM,
PG,
QGBM,
QG,
YGBM,
YG,
DCBM,
DC,
ZSSL,
ZSZL,
ZSCB,
ZSBZCB,
DYZSZ,
FSBM,
FSMC,
FSSL,
FSZL,
DYFSZ,
FSCB,
FSBZCB,
PJMC,
PJSL,
PJZL,
PJCB,
PJBZCB,
CPGJZS,
CPGJZS1,
CPSJZS,
LZZS,
ZSZ1,
ZSF,
BKF,
FDF,
LSF,
PSF,
JBGF,
QBF,
XSF,
JGF,
QTFY,
FJGF,
FJF,
EWM,
KTWSCB,
KTBZCB,
ZHXH,
ZHKDDJH,
ZHKDDJ,
ZHLSH,
KHBM,
KHMC,
CPSX,
DATE_FORMAT(RKRQ,'%Y-%m-%d %H:%i:%s') RKRQ,
RKDH,
DATE_FORMAT(XSRQ,'%Y-%m-%d %H:%i:%s') XSRQ,
CGDH,
GYSBM,
GYSMC,
JGLX,
WWDDBH,
ZJMS,
CSHL,
WWGYSBM,
WWGYSMC,
XLMC,
GSMC,
GZ,
XSF1,
QTFY1,
ZSBH,
FSBH,
FSBH2,
GSGF,
replace(replace(BZ,'\n',''),'\t','') BZ,
ZSF0,
BQLX,
TJSP,
TJ,
JP,
JGSHS,
HJJ,
HCB,
JSJE,
JCB2,
SHZ,
AJHS,
HJLX,
QCRK,
ZSDZ,
XSZK,
ZTDBJSJ,
FZLS,
XDDDH,
BZHFY,
ZQFY,
ZGPJFY,
ZGBZHFY,
ZGZQFY,
WXDM from $database.spxxkczh where 1=1"
}
import_sys_announcement(){
import_data sys_announcement " select 
id,
titile,
msg_content,
DATE_FORMAT(start_time,'%Y-%m-%d %H:%i:%s') start_time,
DATE_FORMAT(end_time,'%Y-%m-%d %H:%i:%s') end_time,
sender,
priority,
msg_category,
msg_type,
send_status,
DATE_FORMAT(send_time,'%Y-%m-%d %H:%i:%s') send_time,
DATE_FORMAT(cancel_time,'%Y-%m-%d %H:%i:%s') cancel_time,
del_flag,
bus_type,
bus_id,
open_type,
open_page,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
user_ids,
msg_abstract from $database.sys_announcement where 1=1"
}
import_sys_announcement_send(){
import_data sys_announcement_send " select 
id,
annt_id,
user_id,
read_flag,
DATE_FORMAT(read_time,'%Y-%m-%d %H:%i:%s') read_time,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time from $database.sys_announcement_send where 1=1"
}
import_sys_batch_log(){
import_data sys_batch_log " select 
batch_command,
DATE_FORMAT(begin_time,'%Y-%m-%d %H:%i:%s') begin_time from $database.sys_batch_log where 1=1"
}
import_sys_category(){
import_data sys_category " select 
id,
pid,
name,
code,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
update_time,
sys_org_code,
has_child from $database.sys_category where 1=1"
}
import_sys_check_rule(){
import_data sys_check_rule " select 
id,
rule_name,
rule_code,
rule_json,
rule_description,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time from $database.sys_check_rule where 1=1"
}
import_sys_data_log(){
import_data sys_data_log " select id,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
update_time,
data_table,
data_id,
data_content,
data_version
 from $database.sys_data_log where 1=1"
}
import_sys_data_source(){
import_data sys_data_source " select 
id,
code,
name,
replace(replace(remark,'\n',''),'\t','') remark,
db_type,
db_driver,
db_url,
db_name,
db_username,
db_password,
create_by,
create_time,
update_by,
update_time,
sys_org_code from $database.sys_data_source where 1=1"
}
import_sys_depart(){
import_data sys_depart " select 
id,
parent_id,
depart_name,
depart_name_en,
depart_name_abbr,
depart_order,
description,
org_category,
org_type,
org_code,
mobile,
fax,
address,
memo,
status,
del_flag,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time from $database.sys_depart where 1=1"
}
import_sys_depart_permission(){
import_data sys_depart_permission " select 
id,
depart_id,
permission_id,
data_rule_ids from $database.sys_depart_permission where 1=1"
}
import_sys_depart_role(){
import_data sys_depart_role " select 
id,
depart_id,
role_name,
role_code,
description,
create_by,
create_time,
update_by,
update_time from $database.sys_depart_role where 1=1"
}
import_sys_depart_role_permission(){
import_data sys_depart_role_permission " select id,
depart_id,
role_id,
permission_id,
data_rule_ids
 from $database.sys_depart_role_permission where 1=1"
}
import_sys_depart_role_user(){
import_data sys_depart_role_user " select 
id,
user_id,
drole_id from $database.sys_depart_role_user where 1=1"
}
import_sys_dict(){
import_data sys_dict " select 
id,
dict_name,
dict_code,
description,
del_flag,
create_by,
create_time,
update_by,
update_time,
type from $database.sys_dict where 1=1"
}
import_sys_dict_item(){
import_data sys_dict_item " select 
id,
dict_id,
item_text,
item_value,
description,
sort_order,
status,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time from $database.sys_dict_item where 1=1"
}
import_sys_email(){
import_data sys_email " select 
id,
email,
type,
\`group\` from $database.sys_email where 1=1"
}
import_sys_fill_rule(){
import_data sys_fill_rule " select 
id,
rule_name,
rule_code,
rule_class,
rule_params,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time from $database.sys_fill_rule where 1=1"
}
import_sys_gateway_route(){
import_data sys_gateway_route " select 
id,
name,
uri,
predicates,
filters,
retryable,
strip_prefix,
persist,
show_api,
status,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
sys_org_code from $database.sys_gateway_route where 1=1"
}
import_sys_job(){
import_data sys_job " select 
id,
job_identity,
job_name,
job_code,
power_level from $database.sys_job where 1=1"
}
import_sys_log(){
import_data sys_log " select 
id,
log_type,
log_content,
operate_type,
userid,
username,
ip,
method,
request_url,
request_param,
request_type,
cost_time,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time from $database.sys_log where 1=1"
}
import_sys_permission(){
import_data sys_permission " select 
id,
parent_id,
name,
url,
component,
component_name,
redirect,
menu_type,
perms,
perms_type,
sort_no,
always_show,
icon,
is_route,
is_leaf,
keep_alive,
hidden,
description,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
del_flag,
rule_flag,
status,
internal_or_external from $database.sys_permission where 1=1"
}
import_sys_permission_202207102237(){
import_data sys_permission_202207102237 " select 
id,
parent_id,
name,
url,
component,
component_name,
redirect,
menu_type,
perms,
perms_type,
sort_no,
always_show,
icon,
is_route,
is_leaf,
keep_alive,
hidden,
description,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
del_flag,
rule_flag,
status,
internal_or_external from $database.sys_permission_202207102237 where 1=1"
}
import_sys_permission_data_rule(){
import_data sys_permission_data_rule " select 
id,
permission_id,
rule_name,
rule_column,
rule_conditions,
rule_value,
status,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
update_by from $database.sys_permission_data_rule where 1=1"
}
import_sys_position(){
import_data sys_position " select 
id,
code,
name,
post_rank,
company_id,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
sys_org_code from $database.sys_position where 1=1"
}
import_sys_quartz_job(){
import_data sys_quartz_job " select 
id,
create_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
del_flag,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
job_class_name,
cron_expression,
parameter,
description,
status from $database.sys_quartz_job where 1=1"
}
import_sys_role(){
import_data sys_role " select 
id,
role_name,
role_code,
description,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
platform_type from $database.sys_role where 1=1"
}
import_sys_role_permission(){
import_data sys_role_permission " select 
id,
role_id,
permission_id,
data_rule_ids from $database.sys_role_permission where 1=1"
}
import_sys_send_email(){
import_data sys_send_email " select 
id,
email,
type,
project from $database.sys_send_email where 1=1"
}
import_sys_sms(){
import_data sys_sms " select 
id,
es_title,
es_type,
es_receiver,
es_param,
es_content,
DATE_FORMAT(es_send_time,'%Y-%m-%d %H:%i:%s') es_send_time,
es_send_status,
es_send_num,
es_result,
replace(replace(remark,'\n',''),'\t','') remark,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time from $database.sys_sms where 1=1"
}
import_sys_sms_template(){
import_data sys_sms_template " select 
id,
template_name,
template_code,
template_type,
template_content,
template_test_json,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
update_by from $database.sys_sms_template where 1=1"
}
import_sys_system_config(){
import_data sys_system_config " select current_sys_date,
is_in_batch_run,
DATE_FORMAT(begin_batch_time,'%Y-%m-%d %H:%i:%s') begin_batch_time,
DATE_FORMAT(end_batch_time,'%Y-%m-%d %H:%i:%s') end_batch_time
 from $database.sys_system_config where 1=1"
}
import_sys_user(){
import_data sys_user " select id,
username,
realname,
password,
salt,
avatar,
birthday,
sex,
email,
phone,
org_code,
status,
del_flag,
third_id,
third_type,
activiti_sync,
work_no,
post,
telephone,
up_counter,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
user_identity,
depart_ids,
showroom_id,
showroom_counter_id,
showroom_identity,
showroom_counter_identity
 from $database.sys_user where 1=1"
}
import_sys_user_agent(){
import_data sys_user_agent " select 
id,
user_name,
agent_user_name,
start_time,
end_time,
status,
create_name,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_name,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
sys_org_code,
sys_company_code from $database.sys_user_agent where 1=1"
}
import_sys_user_depart(){
import_data sys_user_depart " select 
ID,
user_id,
dep_id from $database.sys_user_depart where 1=1"
}
import_sys_user_job(){
import_data sys_user_job " select 
id,
user_id,
user_identity,
job_id,
job_identity from $database.sys_user_job where 1=1"
}
import_sys_user_role(){
import_data sys_user_role " select 
id,
user_id,
role_id from $database.sys_user_role where 1=1"
}
import_szkhcqlxzzb_eos(){
import_data szkhcqlxzzb_eos " select 
DjLsh,
DjBth,
DjState,
LXB,
PL,
DATE_FORMAT(FSRQ,'%Y-%m-%d %H:%i:%s') FSRQ,
JE,
DJ,
ZQ,
BTLX,
DYGF,
SYGF,
CCJQ,
JXXH,
KQQK from $database.szkhcqlxzzb_eos where 1=1"
}
import_szkhcqlxzzf_eos(){
import_data szkhcqlxzzf_eos " select 
DjLsh,
DjFth,
DjState,
SWLX,
DATE_FORMAT(RQ,'%Y-%m-%d %H:%i:%s') RQ,
XMJE,
YJSJD from $database.szkhcqlxzzf_eos where 1=1"
}
import_szkhcqlxzzh_eos(){
import_data szkhcqlxzzh_eos " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
WDMC,
WDBM,
KHMC,
KHBM,
ZKH,
ZJM,
KHLX,
MXTS,
LL,
YDQJE,
WDQJE,
QLZL,
QLDJ,
LX,
DRLX,
DRCCF,
DYGFH,
SYGFH,
WDQQLZL,
WDQQLDJ,
CCF,
CCFQX,
WYID,
DRHKYE,
DRHLYE,
BTHKYE,
BTHLYE,
XLHZ,
HTR,
EDXL,
MXJZ,
QZJXL,
WZJXL,
QZJJJ,
CKJX,
YJD,
HTYDQ,
CCJZ,
YJYQ,
HTYSJCD,
SYWJLX,
XKH,
SYLX,
SYLXCL,
WDQJEPD,
CCMXJZ,
SYGFLX,
DECCF,
YCCJZ,
SYQL,
SYZQK,
KHZL from $database.szkhcqlxzzh_eos where 1=1"
}
import_szkhcqmxb_eos(){
import_data szkhcqmxb_eos " select 
DjLsh,
DjBth,
DjState,
DATE_FORMAT(RQ,'%Y-%m-%d %H:%i:%s') RQ,
ZL,
JE,
LXB,
ZE,
TS,
ZLQJ,
SCBS,
DATE_FORMAT(ZXRQB,'%Y-%m-%d %H:%i:%s') ZXRQB from $database.szkhcqmxb_eos where 1=1"
}
import_szkhcqmxf_eos(){
import_data szkhcqmxf_eos " select 
DjLsh,
DjFth,
DjState,
DATE_FORMAT(RQF,'%Y-%m-%d %H:%i:%s') RQF,
ZLF,
JEF,
LXF,
ZEF,
TSF,
ZLQJF,
SCBSF,
DATE_FORMAT(ZXRQ,'%Y-%m-%d %H:%i:%s') ZXRQ from $database.szkhcqmxf_eos where 1=1"
}
import_szkhcqmxh_eos(){
import_data szkhcqmxh_eos " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
WDBM,
WDMC,
KHBM,
KHMC,
ZKHBH,
ZKHMC,
QKJE,
QLZL,
QLJE,
LX,
JJ,
CQZE,
ZCQKTS,
KHBS,
KHLX,
YCBS from $database.szkhcqmxh_eos where 1=1"
}
import_szywqyhfb_eos(){
import_data szywqyhfb_eos " select 
DjLsh,
DjBth,
DjState,
SF from $database.szywqyhfb_eos where 1=1"
}
import_szywqyhff_eos(){
import_data szywqyhff_eos " select 
DjLsh,
DjFth,
DjState,
KHMC,
KHBM,
ZKHMC,
SCBS,
XH from $database.szywqyhff_eos where 1=1"
}
import_szywqyhfh_eos(){
import_data szywqyhfh_eos " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
QYMC,
ZDR,
DATE_FORMAT(ZDSJ,'%Y-%m-%d %H:%i:%s') ZDSJ,
SHR,
DATE_FORMAT(SHSJ,'%Y-%m-%d %H:%i:%s') SHSJ,
DATE_FORMAT(RQ,'%Y-%m-%d %H:%i:%s') RQ,
WDMC from $database.szywqyhfh_eos where 1=1"
}
import_t_approve_record(){
import_data t_approve_record " select 
id,
approve_type,
data_id,
from_name,
table_name,
create_user,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time from $database.t_approve_record where 1=1"
}
import_t_auto_export(){
import_data t_auto_export " select 
sql,
email,
fileName,
is_delete from $database.t_auto_export where 1=1"
}
import_t_b_menu(){
import_data t_b_menu " select 
id,
name,
path,
type,
is_default,
sort,
is_show from $database.t_b_menu where 1=1"
}
import_t_basic_purity(){
import_data t_basic_purity " select id,
basic_purity_identity,
basic_purity_name
 from $database.t_basic_purity where 1=1"
}
import_t_batch_approve_temp(){
import_data t_batch_approve_temp " select 
sale_identity
 from $database.t_batch_approve_temp where 1=1"
}
import_t_bf_account_type_category(){
import_data t_bf_account_type_category " select 
id,
account_type_category_code,
account_type_category_identity,
account_type_category_name,
work_fee,
effective_date,
status,
type,
rq from $database.t_bf_account_type_category where 1=1"
}
import_t_bf_aging_gold_price_basics(){
import_data t_bf_aging_gold_price_basics " select 
id,
showroom_name,
gold_price,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_aging_gold_price_basics where 1=1"
}
import_t_bf_aging_gold_price_maintain_bill(){
import_data t_bf_aging_gold_price_maintain_bill " select 
id,
aging_gold_price_maintain_identity,
aging_gold_price_maintain_code,
showroom_name,
gold_price,
date,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_aging_gold_price_maintain_bill where 1=1"
}
import_t_bf_allocate_transfer(){
import_data t_bf_allocate_transfer " select 
id,
allocate_transfer_identity,
allocate_transfer_code,
showroom_name,
purity_identity,
purity_name,
category_help_code,
category_name,
basic_work_fee,
average_cost,
rule,
allocate_transfer_price,
replace(replace(remark,'\n',''),'\t','') remark,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
status,
rq from $database.t_bf_allocate_transfer where 1=1"
}
import_t_bf_allocation_fee(){
import_data t_bf_allocation_fee " select 
id,
allocation_fee_identity,
allocation_fee_code,
showroom_name,
apply_scene,
swlx,
purity_identity,
purity_name,
genus_range,
allocate_transfer_code,
work_fee_basic,
worl_fee_style,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
cost,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_allocation_fee where 1=1"
}
import_t_bf_allocation_fee_add_price(){
import_data t_bf_allocation_fee_add_price " select 
id,
allocation_fee_identity,
start_price,
end_price,
price,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_allocation_fee_add_price where 1=1"
}
import_t_bf_ancient_law_cus_discount(){
import_data t_bf_ancient_law_cus_discount " select 
id,
cus_discount_identity,
cus_discount_code,
showroom_identity,
counter_identity,
purity_identity,
customer_identity,
customer_code,
parent_customer_identity,
parent_customer_code,
customer_discount,
unit_other_work_fee,
child_customer_seq,
replace(replace(remark,'\n',''),'\t','') remark,
unit_batch_price,
transfer_owed_diff_price,
create_by,
create_by_name,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
update_by_name,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_ancient_law_cus_discount where 1=1"
}
import_t_bf_ancient_law_cus_discount_detail(){
import_data t_bf_ancient_law_cus_discount_detail " select 
id,
cus_discount_identity,
cus_discount_detail_identity,
first_genus_identity,
first_genus_name,
second_genus_identity,
second_genus_name,
base_work_fee,
other_work_fee,
batch_price,
status from $database.t_bf_ancient_law_cus_discount_detail where 1=1"
}
import_t_bf_area(){
import_data t_bf_area " select 
id,
area_identity,
area_code,
area_name,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
showroom_name,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_area where 1=1"
}
import_t_bf_bank_deposit_bill_sz(){
import_data t_bf_bank_deposit_bill_sz " select 
id,
bank_eposit_identity,
bank_eposit_code,
showroom_code,
showroom_name,
cus_debit_code,
total_price,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
status,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time from $database.t_bf_bank_deposit_bill_sz where 1=1"
}
import_t_bf_bank_deposit_bill_sz_detail(){
import_data t_bf_bank_deposit_bill_sz_detail " select 
id,
bank_eposit_detail_identity,
bank_eposit_identity,
ckfs,
zcyh,
zczh,
zchm,
crwd,
crwdbm,
crfs,
cryh,
cryhbm,
crhm,
crzh,
cryhgs,
je,
replace(replace(BZ,'\n',''),'\t','') bz,
cwsh from $database.t_bf_bank_deposit_bill_sz_detail where 1=1"
}
import_t_bf_buy_cus_item(){
import_data t_bf_buy_cus_item " select 
id,
buy_cus_item_identity,
buy_cus_item_code,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
approve_status,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
showroom_name,
counter_identity,
replace(replace(remark,'\n',''),'\t','') remark,
customer_identity,
parent_customer_identity,
total_number,
total_weight,
total_label_price,
total_price,
record_book_by,
DATE_FORMAT(record_book_time,'%Y-%m-%d %H:%i:%s') record_book_time,
credit_code,
record_book_status,
business_type,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
basic_purity_name,
print_count,
tech_purity_name,
tech_purity_code,
DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_buy_cus_item where 1=1"
}
import_t_bf_buy_cus_item_detail(){
import_data t_bf_buy_cus_item_detail " select 
id,
buy_cus_item_detail_identity,
buy_cus_item_identity,
purity_identity,
number,
weight,
work_fee,
label_price,
unit_price,
work_fee_price,
if_update_work_fee,
price,
basic_work_fee,
basic_work_fee_price,
additional_work_fee,
additional_work_fee_price,
gold_price,
gold_income,
gold_stone_code,
gold_stone_name from $database.t_bf_buy_cus_item_detail where 1=1"
}
import_t_bf_buy_cus_material(){
import_data t_bf_buy_cus_material " select 
id,
buy_cus_code,
buy_cus_identity,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
showroom_name,
counter_identity,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
total_gold_weight,
replace(replace(remark,'\n',''),'\t','') remark,
customer_identity,
parent_customer_identity,
total_price,
customer_credit,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
basic_purity_name,
tech_purity_name,
tech_purity_code,
print_count,
DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_buy_cus_material where 1=1"
}
import_t_bf_buy_cus_material_detail(){
import_data t_bf_buy_cus_material_detail " select 
id,
buy_cus_detail_identity,
buy_cus_identity,
purity_identity,
gold_weight,
price,
unit_price from $database.t_bf_buy_cus_material_detail where 1=1"
}
import_t_bf_buyback_material(){
import_data t_bf_buyback_material " select 
id,
settlement_code,
settlement_time,
settlement_date,
settlement_type,
showroom_name,
genus_name,
purity_name,
customer_identity,
parent_customer_identity,
settlement_weight,
settlement_unit_price,
settlement_price,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
replace(replace(remarks,'\n',''),'\t','') remarks,
area,
approve_status,
inlaid,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
print_count,
DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_buyback_material where 1=1"
}
import_t_bf_change_outsource(){
import_data t_bf_change_outsource " select 
id,
change_outsource_code,
change_outsource_identity,
showroom_name,
customer_identity,
parent_customer_identity,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
counter_name,
counter_identity,
total_gold_weight,
total_price,
replace(replace(remark,'\n',''),'\t','') remark,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
basic_purity_name,
print_count,
tech_purity_name,
tech_purity_code,
DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_change_outsource where 1=1"
}
import_t_bf_change_outsource_detail(){
import_data t_bf_change_outsource_detail " select 
id,
change_outsource_detail_identity,
change_outsource_identity,
change_weight,
change_purity_name,
unit_price,
price,
replace(replace(remark,'\n',''),'\t','') remark from $database.t_bf_change_outsource_detail where 1=1"
}
import_t_bf_change_purity(){
import_data t_bf_change_purity " select 
id,
change_purity_code,
change_purity_identity,
showroom_name,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
replace(replace(remark,'\n',''),'\t','') remark,
weight,
price,
number_of_units,
counter_identity,
counter_name,
out_purity_identity,
out_purity_name,
in_purity_identity,
in_purity_name,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_change_purity where 1=1"
}
import_t_bf_collect_money_account(){
import_data t_bf_collect_money_account " select 
id,
showroom_name,
bank_name,
bank_code,
bank_card,
replace(replace(remark,'\n',''),'\t','') remark,
is_delete,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
bank_belonging,
zhmc,
zhzh,
zhlx from $database.t_bf_collect_money_account where 1=1"
}
import_t_bf_collect_money_style(){
import_data t_bf_collect_money_style " select 
id,
collect_money_style,
collect_money_code,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_collect_money_style where 1=1"
}
import_t_bf_current_wholesale_gold_price(){
import_data t_bf_current_wholesale_gold_price " select 
id,
current_wholesale_identity,
current_wholesale_history_detail_identity,
showroom_identity,
purity_identity,
purity_name,
gold_price,
small_unit_price,
large_unit_price,
base_work_fee,
small_base_work_fee,
large_base_work_fee,
purification_fee,
small_purification_fee,
large_purification_fee,
small_attach_work_fee,
large_attach_work_fee,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_current_wholesale_gold_price where 1=1"
}
import_t_bf_current_wholesale_gold_price_history(){
import_data t_bf_current_wholesale_gold_price_history " select 
id,
current_wholesale_history_identity,
showroom_identity,
create_by,
create_by_name,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
approve_by_name,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_current_wholesale_gold_price_history where 1=1"
}
import_t_bf_current_wholesale_gold_price_history_detail(){
import_data t_bf_current_wholesale_gold_price_history_detail " select id,
current_wholesale_history_identity,
current_wholesale_history_detail_identity,
purity_identity,
purity_name,
gold_price,
small_unit_price,
large_unit_price,
base_work_fee,
small_base_work_fee,
large_base_work_fee,
purification_fee,
small_purification_fee,
large_purification_fee,
small_attach_work_fee,
large_attach_work_fee,
status
 from $database.t_bf_current_wholesale_gold_price_history_detail where 1=1"
}
import_t_bf_cus_credit_receipt(){
import_data t_bf_cus_credit_receipt " select 
id,
cus_credit_receipt_identity,
cus_credit_receipt_code,
showroom_name,
customer_identity,
parent_customer_identity,
total_price,
replace(replace(remark,'\n',''),'\t','') remark,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
approve_status,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
borrow_money,
withdraw_money,
credit_code,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
basic_purity_name,
tech_purity_name,
tech_purity_code from $database.t_bf_cus_credit_receipt where 1=1"
}
import_t_bf_cus_credit_receipt_detail(){
import_data t_bf_cus_credit_receipt_detail " select 
id,
cus_credit_receipt_detail_identity,
cus_credit_receipt_identity,
collect_money_style,
bank,
price,
replace(replace(remark,'\n',''),'\t','')  remark from $database.t_bf_cus_credit_receipt_detail where 1=1"
}
import_t_bf_cus_debit_receipt(){
import_data t_bf_cus_debit_receipt " select 
id,
cus_debit_identity,
cus_debit_code,
customer_identity,
parent_customer_identity,
showroom_name,
receivable_price,
receivable_gold_weight,
reduced_price,
reference_price,
total_price,
total_receivable_price,
replace(replace(remark,'\n',''),'\t','')  remark,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
today_sell_price,
today_received_price,
yestoday_receivable_price,
today_settle,
sell_price,
today_price,
history_price,
verify_material_price,
verify_sell_price,
service_charge,
free_of_interest,
rate_of_interest,
DATE_FORMAT(debt_time,'%Y-%m-%d %H:%i:%s') debt_time,
yestoday_price_date,
yestoday_price,
DATE_FORMAT(practical_price_time,'%Y-%m-%d %H:%i:%s')practical_price_time,
month_rate_of_interest,
raw_material_identity,
price,
disburser_one,
disburser_number_one,
disburser_two,
disburser_number_two,
status,
price999,
price9999,
price99999,
price18k,
price22k,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
basic_purity_name,
tech_purity_name,
tech_purity_code from $database.t_bf_cus_debit_receipt where 1=1"
}
import_t_bf_cus_debit_receipt_detail(){
import_data t_bf_cus_debit_receipt_detail " select 
id,
cus_debit_identity,
cus_debit_detail_identity,
price_identity,
bank_name,
bank_identity,
account,
detail_price,
detail_today_price,
detail_history_price,
detail_service_charge,
detail_remark,
check_finance,
money_order_code,
money_order_people,
money_order_account,
money_order_card from $database.t_bf_cus_debit_receipt_detail where 1=1"
}
import_t_bf_cus_debit_receipt_record(){
import_data t_bf_cus_debit_receipt_record " select 
id,
recoed_sale_identity,
other_identity,
sale_code,
sale_name,
DATE_FORMAT(sale_time,'%Y-%m-%d %H:%i:%s') sale_time,
sale_type,
customer_identity,
parent_customer_identity,
sale_price,
this_price,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
csmc,
ysjzf,
bchxje,
syysje,
yslsh,
ysbth,
khzjm,
wfje from $database.t_bf_cus_debit_receipt_record where 1=1"
}
import_t_bf_cust_return_jewelry(){
import_data t_bf_cust_return_jewelry " select 
id,
return_code,
return_identity,
date_this,
showroom_identity,
showroom_name,
counter_identity,
counter_name,
source_counter_name,
source_counter_identity,
customer_identity,
customer_code,
if_child,
parent_customer_identity,
child_customer_seq,
purity_identity,
gold_price_amount_sum,
number_of_objects_sum,
work_fee_amount_sum,
gold_weight_sum,
replace(replace(remark,'\n',''),'\t','')  remark,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
if_show_remark,
if_outside,
if_five_g,
print_count,
area,
amount_sum,
xq_code,
pay_no_amount,
pay_ok_amount,
process_type,
status,
gold_avg_price,
form_total_amount,
customer_base_code,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
basic_purity_name,
DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_cust_return_jewelry where 1=1"
}
import_t_bf_cust_return_jewelry_detail(){
import_data t_bf_cust_return_jewelry_detail " select 
id,
return_identity,
return_detail_identity,
gold_weight,
work_fee_type,
transfer_owed_identity,
default_work_fee,
purity_identity,
purity_name,
first_product_style,
first_product_style_identity,
second_product_style,
second_product_style_identity,
number_of_objects,
base_work_fee,
base_work_fee_amount,
attach_work_fee,
attach_work_fee_amount,
source_attach_work_fee,
hang_out_unit_price,
hang_out_fee,
return_work_fee_sub_total,
label_price,
content,
gold_price_amount,
deduction_product_weight,
remain_gold_weight,
if_update_work_fee_amount,
replace(replace(remark,'\n',''),'\t','')  remark,
work_fee_discount,
other_price,
if_update_discount,
status,
transfer_owed_diff_price,
material_explain_name,
transfer_owed_diff_price_total,
gold_price,
small_base_work_fee,
large_base_work_fee,
unit_price from $database.t_bf_cust_return_jewelry_detail where 1=1"
}
import_t_bf_customer_credit_base(){
import_data t_bf_customer_credit_base " select 
id,
credit_base_code,
credit_base_identity,
showroom_name,
customer_identity,
parent_customer_identity,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
credit_base_date,
gold_weight,
credit_base_quota,
year,
month,
day,
gold_price,
DATE_FORMAT(update_date,'%Y-%m-%d %H:%i:%s') update_date,
update_credit_base_quota,
credit_base_status,
DATE_FORMAT(take_effect_date,'%Y-%m-%d %H:%i:%s') take_effect_date,
same_customer_purity,
kckxed,
kcebfb,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_customer_credit_base where 1=1"
}
import_t_bf_customer_the_bill(){
import_data t_bf_customer_the_bill " select 
id,
customer_the_bill_code,
customer_the_bill_identity,
showroom_name,
out_customer_identity,
out_parent_customer_identity,
financial_settlement_time,
adjust_weight,
adjust_month_price,
adjust_capital,
replace(replace(remark,'\n',''),'\t','')  remark,
in_customer_identity,
in_parent_customer_identity,
inner_customer_identity,
inner_customer_name,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
interest_adjustments,
status,
financial_client_code,
financial_client_name,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
out_tech_purity_name,
out_tech_purity_code,
in_tech_purity_name,
in_tech_purity_code from $database.t_bf_customer_the_bill where 1=1"
}
import_t_bf_deliver_goods_from(){
import_data t_bf_deliver_goods_from " select 
id,
deliver_goods_code,
deliver_goods_identity,
area,
refer_to_start_date,
refer_to_end_date,
if_no_mine_company,
if_franchisee,
purity_identity,
showroom_identity,
customer_identity,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
total_number,
total_gold_weight,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
replace(replace(remark,'\n',''),'\t','')  remark,
collection_company,
gross_weight,
package_number,
delivery_by_first,
delivery_by_second,
sign_for,
sign_status,
date_this,
print_by,
DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
print_count from $database.t_bf_deliver_goods_from where 1=1"
}
import_t_bf_deliver_goods_from_detail(){
import_data t_bf_deliver_goods_from_detail " select 
id,
deliver_goods_identity,
deliver_goods_detail_identity,
sale_identity,
sale_code,
sale_date,
parent_customer_identity,
product_style,
purity_identity,
gold_weight,
sale_number,
customer_identity,
customer_code,
child_customer_code,
replace(replace(remark,'\n',''),'\t','')  remark,
status from $database.t_bf_deliver_goods_from_detail where 1=1"
}
import_t_bf_dkhhy_b(){
import_data t_bf_dkhhy_b " select 
bid,
dkhhy_b_identity,
dkhhy_h_identity,
wdmc,
customer_identity,
parent_customer_identity,
zkhbs,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_user_id,
create_user_name,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
update_user_id,
update_user_name,
djlsh,
djbth,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
id from $database.t_bf_dkhhy_b where 1=1"
}
import_t_bf_dkhhy_h(){
import_data t_bf_dkhhy_h " select 
id,
dkhhy_h_identity,
showroom_name,
customer_identity,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_user_id,
create_user_name,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
update_user_id,
update_user_name,
djlsh,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
status from $database.t_bf_dkhhy_h where 1=1"
}
import_t_bf_dzddydy(){
import_data t_bf_dzddydy " select 
id,
dzddydy_identity,
wdmc,
customer_identity,
khbm,
khmc,
zkh,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
qzqkje,
qzqlzl,
sjqkje,
sjqlzl,
wjqkje,
wjqlzl,
wyid from $database.t_bf_dzddydy where 1=1"
}
import_t_bf_financial_block_list(){
import_data t_bf_financial_block_list " select 
id,
financial_block_list_code,
financial_block_list_identity,
showroom_name,
customer_type,
customer_identity,
parent_customer_identity,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_financial_block_list where 1=1"
}
import_t_bf_five_g_cus_discount(){
import_data t_bf_five_g_cus_discount " select 
id,
five_g_cus_discount_identity,
five_g_cus_discount_code,
showroom_identity,
customer_identity,
customer_code,
parent_customer_identity,
parent_customer_code,
child_customer_seq,
customer_discount,
other_price,
transfer_owed_diff_price,
create_by,
create_by_name,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
update_by_name,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
replace(replace(remark,'\n',''),'\t','')  remark,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_five_g_cus_discount where 1=1"
}
import_t_bf_gold_inlay_transfer_in(){
import_data t_bf_gold_inlay_transfer_in " select 
id,
inlay_transfer_in_identity,
inlay_transfer_in_code,
inlay_transfer_out_code,
transfer_out_showroom,
transfer_out_counter_name,
transfer_out_counter_identity,
transfer_in_showroom,
transfer_in_counter_name,
transfer_in_counter_identity,
total_number,
total_weight,
rkdh,
drdh,
replace(replace(remark,'\n',''),'\t','')  remark,
total_work_fee,
total_stone_weight,
wxqx,
purity_name,
ztdbjsj,
jxydblx,
yyyxh,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
settlement_approve,
status,
eos_head_key,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
DATE_FORMAT(out_time,'%Y-%m-%d %H:%i:%s') out_time,
receive_id from $database.t_bf_gold_inlay_transfer_in where 1=1"
}
import_t_bf_gold_inlay_transfer_in_detail(){
import_data t_bf_gold_inlay_transfer_in_detail " select 
id,
inlay_transfer_in_identity,
inlay_transfer_in_detail_identity,
product_code,
product_name,
metalwork_name,
category_name,
factory_code,
company_code,
purity_name,
main_stone_name,
main_stone_weight,
main_stone_specs,
gold_weight,
label_price,
number,
replace(replace(remark,'\n',''),'\t','')  remark,
transfer_type,
type_code,
series_name,
outside,
goods_weight,
processing_charges,
jp,
ztdbjsjb,
eos_body_key,
receive_id,
receive_detail_id from $database.t_bf_gold_inlay_transfer_in_detail where 1=1"
}
import_t_bf_gold_inlay_transfer_out(){
import_data t_bf_gold_inlay_transfer_out " select 
id,
inlay_transfer_out_identity,
inlay_transfer_out_code,
transfer_out_showroom,
transfer_out_counter_name,
transfer_out_counter_identity,
transfer_in_showroom,
transfer_in_counter_name,
transfer_in_counter_identity,
total_number,
total_weight,
rkdh,
drdh,
replace(replace(remark,'\n',''),'\t','')  remark,
total_work_fee,
total_stone_weight,
wxqx,
purity_name,
ztdbjsj,
jxydblx,
yyyxh,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
DATE_FORMAT(out_time,'%Y-%m-%d %H:%i:%s') out_time,
receive_id,
transfer_type from $database.t_bf_gold_inlay_transfer_out where 1=1"
}
import_t_bf_gold_inlay_transfer_out_detail(){
import_data t_bf_gold_inlay_transfer_out_detail " select 
id,
inlay_transfer_out_identity,
inlay_transfer_out_detail_identity,
product_code,
product_name,
metalwork_name,
category_name,
factory_code,
company_code,
purity_name,
main_stone_name,
main_stone_weight,
main_stone_specs,
gold_weight,
label_price,
number,
replace(replace(remark,'\n',''),'\t','')  remark,
transfer_type,
type_code,
series_name,
outside,
goods_weight,
processing_charges,
jp,
ztdbjsjb,
receive_id,
receive_detail_id from $database.t_bf_gold_inlay_transfer_out_detail where 1=1"
}
import_t_bf_gold_transfer_change(){
import_data t_bf_gold_transfer_change " select 
id,
inlay_change_identity,
inlay_change_code,
transfer_out_showroom,
transfer_out_counter_name,
transfer_out_counter_identity,
transfer_in_showroom,
transfer_in_counter_name,
transfer_in_counter_identity,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
total_number,
total_weight,
total_label_price,
purity_name,
dydf,
DATE_FORMAT(out_time,'%Y-%m-%d %H:%i:%s') out_time,
transfer_in_code,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_gold_transfer_change where 1=1"
}
import_t_bf_gold_transfer_change_detail(){
import_data t_bf_gold_transfer_change_detail " select 
id,
inlay_change_identity,
inlay_change_detail_identity,
inlay_transfer_in_code,
purity_name,
genus_name,
number,
gold_weight,
label_price,
swlx,
inlay_transfer_out_code,
DATE_FORMAT(out_time,'%Y-%m-%d %H:%i:%s') out_time from $database.t_bf_gold_transfer_change_detail where 1=1"
}
import_t_bf_gold_transfer_in(){
import_data t_bf_gold_transfer_in " select 
id,
transfer_in_code,
transfer_out_code,
transfer_out_identity,
transfer_in_identity,
transfer_out_showroom,
transfer_out_counter_name,
transfer_out_counter_identity,
transfer_in_showroom,
transfer_in_counter_name,
transfer_in_counter_identity,
purity_name,
genus_name,
exhibition_type,
technology_type,
total_number,
total_label_price,
total_weight,
total_price,
total_additional_labour_price,
replace(replace(remark,'\n',''),'\t','')  remark,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
if_print_remark,
status,
crdj,
eos_head_key,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
DATE_FORMAT(out_time,'%Y-%m-%d %H:%i:%s') out_time,
print_count,
receive_id,
DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_gold_transfer_in where 1=1"
}
import_t_bf_gold_transfer_in_detail(){
import_data t_bf_gold_transfer_in_detail " select 
id,
transfer_in_identity,
transfer_out_detail_identity,
transfer_in_detail_identity,
product_code,
first_category_name,
second_category_name,
number,
in_weight,
basic_price,
additional_labour_price,
price,
label_price,
out_weight,
transfer_type,
replace(replace(remark,'\n',''),'\t','')  remark,
unit_price,
eos_body_key,
discount_work_fee,
receive_id,
receive_detail_id from $database.t_bf_gold_transfer_in_detail where 1=1"
}
import_t_bf_gold_transfer_out(){
import_data t_bf_gold_transfer_out " select 
id,
transfer_out_code,
transfer_out_identity,
transfer_out_showroom,
transfer_out_counter_name,
transfer_out_counter_identity,
transfer_in_showroom,
transfer_in_counter_name,
transfer_in_counter_identity,
purity_name,
genus_name,
exhibition_type,
technology_type,
total_number,
total_label_price,
total_weight,
total_price,
total_additional_labour_price,
replace(replace(remark,'\n',''),'\t','')  remark,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
if_print_remark,
is_print,
status,
DATE_FORMAT(shipments_date,'%Y-%m-%d') shipments_date,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
DATE_FORMAT(drrq,'%Y-%m-%d %H:%i:%s') drrq,
print_count,
receive_id,
transfer_type,
DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time,
scan_status,
DATE_FORMAT(scan_time,'%Y-%m-%d %H:%i:%s') scan_time,
sacn_by from $database.t_bf_gold_transfer_out where 1=1"
}
import_t_bf_gold_transfer_out_detail(){
import_data t_bf_gold_transfer_out_detail " select 
id,
transfer_out_identity,
transfer_out_detail_identity,
product_code,
transfer_style,
first_category_name,
second_category_name,
number,
weight,
basic_price,
additional_labour_price,
price,
label_price,
transfer_type,
rllx,
replace(replace(remark,'\n',''),'\t','')  remark,
if_update_price,
xsfjgf,
discount_work_fee,
discount_price,
unit_price,
htm,
average_cost,
receive_id,
receive_detail_id from $database.t_bf_gold_transfer_out_detail where 1=1"
}
import_t_bf_gold_transfer_out_print(){
import_data t_bf_gold_transfer_out_print " select 
id,
gold_transfer_out_print_identity,
gold_transfer_out_print_code,
genus_name,
purity_name,
transfer_out_showroom,
transfer_in_showroom,
transfer_in_counter_name,
total_number,
total_label_price,
total_weight,
total_price,
total_additional_labour_price,
DATE_FORMAT(deliver_goods_time,'%Y-%m-%d %H:%i:%s') deliver_goods_time,
replace(replace(remark,'\n',''),'\t','')  remark,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s')  create_time,
approve_by,
dycs,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s')  approve_time,
approve_status,
batch_setting_basic_price,
status,
bthshj,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
total_unit_price,
print_count,
DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_gold_transfer_out_print where 1=1"
}
import_t_bf_gold_transfer_out_print_detail(){
import_data t_bf_gold_transfer_out_print_detail " select 
id,
transfer_out_print_identity,
transfer_out_code,
transfer_out_detail_print_identity,
transfer_out_counter_name,
transfer_in_showroom,
transfer_in_counter_name,
genus_name,
category_name,
number,
weight,
additional_labour_price,
basic_price,
price,
label_price,
old_price,
transfer_type,
transfer_style,
xsfjgf,
discount_work_fee,
discount_price,
product_code,
replace(replace(remark,'\n',''),'\t','')  remark,
unit_price,
old_basic_price,
add_basic_price,
transfer_out_detail_identity from $database.t_bf_gold_transfer_out_print_detail where 1=1"
}
import_t_bf_hard_gold_cus_discount(){
import_data t_bf_hard_gold_cus_discount " select 
id,
hard_gold_cus_discount_identity,
showroom_identity,
customer_identity,
customer_code,
parent_customer_identity,
parent_customer_code,
customer_discount,
other_price,
transfer_owed_diff_price,
create_by,
create_by_name,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
update_by_name,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
replace(replace(remark,'\n',''),'\t','')  remark,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_hard_gold_cus_discount where 1=1"
}
import_t_bf_hard_gold_default_work_fee(){
import_data t_bf_hard_gold_default_work_fee " select 
id,
hard_gold_default_work_fee_identity,
default_work_fee,
transfer_owed_diff_price,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_hard_gold_default_work_fee where 1=1"
}
import_t_bf_hard_gold_work_fee(){
import_data t_bf_hard_gold_work_fee " select 
id,
hard_gold_work_fee_identity,
showroom_identity,
customer_identity,
customer_code,
child_customer_seq,
help_code,
if_child,
parent_customer_identity,
parent_customer_code,
create_by,
create_by_name,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
update_by_name,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
replace(replace(remark,'\n',''),'\t','')  remark,
default_work_fee,
transfer_owed_diff_price,
if_used,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_hard_gold_work_fee where 1=1"
}
import_t_bf_initial_inventory_bill(){
import_data t_bf_initial_inventory_bill " select 
id,
initial_inventory_identity,
initial_inventory_code,
showroom_name,
inventory_date,
year,
month,
day,
storage_name,
fineness_name,
category_name,
initial_packages,
initial_amount,
initial_gold_weight,
balance_packages,
balance_amount,
balance_gold_weight,
profit_loss_packages,
profit_loss_amount,
profit_loss_gold_weight,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
replace(replace(remark,'\n',''),'\t','')  remarks,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
status from $database.t_bf_initial_inventory_bill where 1=1"
}
import_t_bf_inlaid_metal_average_daily(){
import_data t_bf_inlaid_metal_average_daily " select 
id,
average_daily_identity,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s')  create_time,
inlaid_metal_code,
average_daily,
DATE_FORMAT(date,'%Y-%m-%d') date,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_inlaid_metal_average_daily where 1=1"
}
import_t_bf_interest_st_adj_item(){
import_data t_bf_interest_st_adj_item " select 
id,
adjust_item_identity,
showroom_name,
day_rate,
interest_free_days,
DATE_FORMAT(contract_date,'%Y-%m-%d')  contract_date,
storage_fee,
month_extension_time,
rated_sales,
interest_free_gold_weight,
storage_fee_term,
effective_date,
customer_identity,
parent_customer_identity,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
category_info_code,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
customer_type,
customer_type_code,
tech_purity_name,
tech_purity_code,
payment_days,
overday_rate from $database.t_bf_interest_st_adj_item where 1=1"
}
import_t_bf_khlsedb(){
import_data t_bf_khlsedb " select 
id,
khlsedb_identity,
djh,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
wdbm,
wdmch,
customer_identity,
PARENT_customer_identity,
lsed,
zkh,
zdrid,
zdr,
DATE_FORMAT(zdsj,'%Y-%m-%d %H:%i:%s') zdsj,
shrid,
shr,
DATE_FORMAT(shsj,'%Y-%m-%d %H:%i:%s') shsj,
lsjz,
jjj,
spdh,
approve_status,
status from $database.t_bf_khlsedb where 1=1"
}
import_t_bf_material_explain(){
import_data t_bf_material_explain " select 
id,
material_explain_identity,
material_explain_code,
material_explain_name,
type_code,
type_name,
status,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
if_convert from $database.t_bf_material_explain where 1=1"
}
import_t_bf_other_showroom_customer_block_list(){
import_data t_bf_other_showroom_customer_block_list " select 
id,
other_showroom_customer_block_code,
other_showroom_customer_block_identity,
showroom_name,
customer_identity,
parent_customer_identity,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_other_showroom_customer_block_list where 1=1"
}
import_t_bf_pay_cus_material(){
import_data t_bf_pay_cus_material " select 
id,
pay_cus_code,
pay_cus_identity,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
showroom_name,
counter_identity,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
total_gold_weight,
total_price,
gold_average_price,
replace(replace(remark,'\n',''),'\t','')  remark,
customer_identity,
parent_customer_identity,
customer_credit,
allow_sale,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
tech_purity_name,
tech_purity_code,
print_count,
DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_pay_cus_material where 1=1"
}
import_t_bf_pay_cus_material_detail(){
import_data t_bf_pay_cus_material_detail " select 
id,
pay_cus_detail_identity,
pay_cus_identity,
purity_identity,
gold_weight,
replace(replace(remarks,'\n',''),'\t','')  remarks from $database.t_bf_pay_cus_material_detail where 1=1"
}
import_t_bf_pay_outsource(){
import_data t_bf_pay_outsource " select 
id,
pay_outsource_identity,
pay_outsource_code,
showroom_name,
customer_identity,
parent_customer_identity,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
counter_name,
counter_identity,
total_gold_weight,
today_return_weight,
today_pay_weight,
today_put_weight,
replace(replace(remark,'\n',''),'\t','') remark,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
print_count,
tech_purity_name,
tech_purity_code,
DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_pay_outsource where 1=1"
}
import_t_bf_pay_outsource_detail(){
import_data t_bf_pay_outsource_detail " select 
id,
pay_outsource_detail_identity,
pay_outsource_identity,
pay_purity_name,
pay_gold_weight,
replace(replace(remark,'\n',''),'\t','')  remark from $database.t_bf_pay_outsource_detail where 1=1"
}
import_t_bf_payment_order(){
import_data t_bf_payment_order " select 
id,
payment_order_code,
payment_order_identity,
showroom_name,
customer_identity,
parent_customer_identity,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
replace(replace(remark,'\n',''),'\t','')  remark,
total_payment,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
tech_purity_code,
tech_purity_name from $database.t_bf_payment_order where 1=1"
}
import_t_bf_payment_order_detail(){
import_data t_bf_payment_order_detail " select 
id,
payment_order_identity,
payment_order_detail_identity,
payment_name,
payment_identity,
bank_name,
bank_identity,
price,
replace(replace(remark,'\n',''),'\t','')  remark from $database.t_bf_payment_order_detail where 1=1"
}
import_t_bf_purify(){
import_data t_bf_purify " select 
id,
purify_identity,
purify_code,
showroom_identity,
showroom_name,
create_user,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_user,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
replace(replace(remark,'\n',''),'\t','')  remark,
status from $database.t_bf_purify where 1=1"
}
import_t_bf_purify_detail(){
import_data t_bf_purify_detail " select 
id,
purify_detail_identity,
purify_identity,
purity_name,
material_explain,
percent_start,
percent_end,
purity_price,
if_convert from $database.t_bf_purify_detail where 1=1"
}
import_t_bf_raw_material(){
import_data t_bf_raw_material " select 
id,
raw_material_code,
raw_material_identity,
raw_material_time,
showroom_name,
customer_identity,
parent_customer_identity,
temporary_money_identity,
temporary_money_code,
neight,
price,
replace(replace(remark,'\n',''),'\t','') remark,
old_material,
meterial999,
meterial9999,
meterial99999,
meteria18k,
meteria22k,
price999,
price9999,
price99999,
price18k,
price22k,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_raw_material where 1=1"
}
import_t_bf_ready_money(){
import_data t_bf_ready_money " select 
id,
purity_name,
purity_identity,
work_fee_type,
work_fee,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_ready_money where 1=1"
}
import_t_bf_receive_meterial(){
import_data t_bf_receive_meterial " select id,
receive_meterial_identity,
DATE_FORMAT(record_date,'%Y-%m-%d') record_date,
receive_meterial_code,
showroom_code,
showroom_name,
receive_gold_weight,
sum_amount,
sales_no,
area_name,
is_convert,
show_memo,
today_sale_gold_weith,
is_customer_meterial,
today_customer_receive_weight,
amount_paid,
amount_unpaid,
print_qty,
DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time,
customer_identity,
parent_customer_identity,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
replace(replace(remarks,'\n',''),'\t','')  remarks,
remaining_gold_weight_total,
letter_codes,
gold_price,
total_transactions,
status,
is_before_date_receive,
real_receive_date,
counter_identity,
counter_code,
counter_name,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
basic_purity_name,
customer39_weight,
customer49_weight,
customer59_weight,
customer18k_weight,
customer22k_weight,
customer_codes,
tech_purity_name,
tech_purity_code,
print_count,
s39,
s49,
s59,
c39,
c49,
c59,
c5g
 from $database.t_bf_receive_meterial where 1=1"
}
import_t_bf_receive_meterial_detail(){
import_data t_bf_receive_meterial_detail " select 
id,
receive_meterial_detail_identity,
receive_meterial_identity,
line,
purity_name,
material_explain_name,
incoming_gold_weight,
percentage,
material_content,
day_of_gold,
purify_amount,
purify_expense,
amount,
replace(replace(remarks,'\n',''),'\t','') remarks,
the_convert_costs,
the_convert_amount,
material_gold_weight,
remaining_gold_weight,
purity_identity,
material_explain_code,
convert_purity_name,
convert_gold_weight,
cor_material_fee,
cor_material_fee_amount,
category_name,
category_code from $database.t_bf_receive_meterial_detail where 1=1"
}
import_t_bf_remark(){
import_data t_bf_remark " select 
id,
remark_identity,
remark_code,
remark_name,
remark_help_code,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_remark where 1=1"
}
import_t_bf_repair(){
import_data t_bf_repair " select 
id,
repair_code,
repair_identity,
repair_type,
sale_identity,
showroom_name,
customer_identity,
parent_customer_identity,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
owe_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
gold_weight,
price,
money,
replace(replace(remarks,'\n',''),'\t','') remarks,
status,
sale_code,
tech_purity_name,
tech_purity_code,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
print_count,
purity_name,
purity_code,
DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_repair where 1=1"
}
import_t_bf_retreat(){
import_data t_bf_retreat " select 
id,
retreat_code,
retreat_identity,
sale_identity,
retreat_type,
showroom_name,
customer_identity,
parent_customer_identity,
DATE_FORMAT(owe_time,'%Y-%m-%d %H:%i:%s') owe_time,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
gold_weight,
price,
money,
replace(replace(remarks,'\n',''),'\t','') remarks,
status,
sale_code,
tech_purity_name,
tech_purity_code,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
print_count,
purity_name,
purity_code,
DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_retreat where 1=1"
}
import_t_bf_sales_ticket_print_zds(){
import_data t_bf_sales_ticket_print_zds " select 
id,
print_zds_identity,
jsjzhj,
khllysje,
khtsyfje,
sales_ticket_print_zds_code,
bzh,
csmch,
plmch,
qtfy,
fysm,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
wdmc,
wdlx,
lljzhj,
jehj,
xjsq,
zdhs,
tsjzhj,
tzgf,
tzgfh,
bqjehj,
fjgfzkh,
create_by,
create_time,
customer_identity,
parent_customer_identity,
status,
print_count,
DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_sales_ticket_print_zds where 1=1"
}
import_t_bf_sales_ticket_print_zds_detail(){
import_data t_bf_sales_ticket_print_zds_detail " select 
id,
print_zds_detail_identity,
print_zds_identity,
xh,
ckmc,
plmc,
jsb,
jz,
fjgf,
tzfjgf,
fjgfje,
fs,
csmcf,
plmcf,
jzf,
dj,
gf,
gfje,
bzf,
bzb,
yjpl from $database.t_bf_sales_ticket_print_zds_detail where 1=1"
}
import_t_bf_settlement(){
import_data t_bf_settlement " select 
id,
inlaid,
settlement_time,
settlement_type,
showroom_name,
genus_name,
purity_name,
customer_identity,
parent_customer_identity,
settlement_weight,
settlement_unit_price,
settlement_price,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
replace(replace(remarks,'\n',''),'\t','')  remarks,
area,
settlement_code,
approve_status,
settlement_date,
customer_coding,
customer_no,
purity_code,
genus_code,
showroom_identity,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
print_count,
DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time from $database.t_bf_settlement where 1=1"
}
import_t_bf_settlement_adjustment_price(){
import_data t_bf_settlement_adjustment_price " select 
id,
settlement_adjustment_price_identity,
settlement_adjustment_price_code,
purity_identity,
purity_name,
category_name,
genus_name,
full_gold_price,
other_price,
basic_work_fee,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_settlement_adjustment_price where 1=1"
}
import_t_bf_stock_transfer_bill(){
import_data t_bf_stock_transfer_bill " select 
id,
stock_transfer_identity,
stock_transfer_code,
DATE_FORMAT(date,'%Y-%m-%d') date,
showroom_code,
showroom_name,
settlement_type,
out_counter_identity,
out_purity_identity,
out_purity_name,
into_counter_identity,
amount_gold_weight,
number_electronic_scale,
transfer_instructions,
transfer_type,
product_package_no,
amount_tag_price,
in_purity_identity,
in_purity_name,
into_stock_fineness_name,
into_stock_fineness_code,
fiveD_tag,
bookkeeping_by,
bookkeeping_time,
bookkeeping_status,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
replace(replace(remarks,'\n',''),'\t','') remarks,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
status,
is_sysgen,
relation_code from $database.t_bf_stock_transfer_bill where 1=1"
}
import_t_bf_stock_transfer_bill_detail(){
import_data t_bf_stock_transfer_bill_detail " select 
id,
stock_transfer_detail_identity,
stock_transfer_identity,
sequence,
bar_code,
number_of_packages,
gold_weight,
content,
tag_price,
stock_gold_weight,
replace(replace(remarks,'\n',''),'\t','') remarks,
transfer_type,
coding,
out_expenses,
in_expenses,
category_code,
category_name,
purity_code,
purity_name from $database.t_bf_stock_transfer_bill_detail where 1=1"
}
import_t_bf_stock_transfer_bill_detail_hw(){
import_data t_bf_stock_transfer_bill_detail_hw " select 
id,
stock_transfer_detail_identity,
stock_transfer_identity,
sequence,
bar_code,
number_of_packages,
gold_weight,
content,
tag_price,
stock_gold_weight,
replace(replace(remarks,'\n',''),'\t','') remarks,
transfer_type,
coding,
out_expenses,
in_expenses,
category_code,
category_name,
purity_code,
purity_name from $database.t_bf_stock_transfer_bill_detail_hw where 1=1"
}
import_t_bf_stock_transfer_bill_hw(){
import_data t_bf_stock_transfer_bill_hw " select 
id,
stock_transfer_identity,
stock_transfer_code,
DATE_FORMAT(date,'%Y-%m-%d') date,
showroom_code,
showroom_name,
settlement_type,
out_counter_identity,
out_purity_identity,
out_purity_name,
into_counter_identity,
amount_gold_weight,
number_electronic_scale,
transfer_instructions,
transfer_type,
product_package_no,
amount_tag_price,
in_purity_identity,
in_purity_name,
into_stock_fineness_name,
into_stock_fineness_code,
fiveD_tag,
bookkeeping_by,
bookkeeping_time,
bookkeeping_status,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
replace(replace(remarks,'\n',''),'\t','') remarks,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
status from $database.t_bf_stock_transfer_bill_hw where 1=1"
}
import_t_bf_szztgzspd(){
import_data t_bf_szztgzspd " select 
id,
h_identity,
wdmc,
djhm,
DATE_FORMAT(xdrq,'%Y-%m-%d') xdrq,
DATE_FORMAT(gzrq,'%Y-%m-%d') gzrq,
tykhbm,
tykhmc,
customer_identity,
parent_customer_identity,
bzsm,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
cancellation,
status,
xqjs,
xqjz,
xqje,
yjjz,
yjje,
qzjz,
qzje,
wzjz,
wzje,
wjjz,
wjje,
wgjz,
wgje,
gfjz,
gfje,
zjwqjz,
zjwqje,
gfwzjz,
gfwzje,
qzccjjz,
qzccjje,
wzccjjz,
wzccjje,
jys,
gzzt,
gzzt_status,
gzrid,
gzrm,
DATE_FORMAT(gzsj,'%Y-%m-%d %H:%i:%s')  gzsj,
zfrid,
zfrm,
zfsj,
qy,
qzds,
wzds,
yjds,
xqds,
wjds,
wgds,
gfjds,
zjwqds,
gfwzds,
qzccjds,
wzccjds from $database.t_bf_szztgzspd where 1=1"
}
import_t_bf_szztgzspd_detail(){
import_data t_bf_szztgzspd_detail " select 
id,
sale_code,
b_identity,
h_identity,
customer_identity,
parent_customer_identity,
purity_identity,
csgs,
js,
jz,
zje,
bzsm from $database.t_bf_szztgzspd_detail where 1=1"
}
import_t_bf_temporary_money_form(){
import_data t_bf_temporary_money_form " select 
id,
temporary_money_code,
temporary_money_identity,
showroom_name,
customer_identity,
parent_customer_identity,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
print_time_code,
credit_gold_weight,
credit_total_price,
DATE_FORMAT(contract_time,'%Y-%m-%d %H:%i:%s') contract_time,
credit_gold_price,
debt_material_desc,
debt_price_desc,
today_material_shipment,
today_price_shipment,
penal_sum,
exceed_price,
exceed_total_price,
temporary_ratify_price,
thousand_wage,
myriad_wage,
five_nine_wage,
plan_repayment_date_one,
plan_repayment_date_two,
plan_repayment_date_three,
plan_material_one,
plan_material_two,
plan_material_three,
plan_repayment_one,
plan_repayment_two,
plan_repayment_three,
replace(replace(remarks,'\n',''),'\t','') remark,
salesman,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
bdze,
zcqkts,
dzhyhf from $database.t_bf_temporary_money_form where 1=1"
}
import_t_bf_the_bill(){
import_data t_bf_the_bill " select 
id,
the_bill_code,
the_bill_identity,
showroom_name,
customer_identity,
parent_customer_identity,
inner_customer_identity,
inner_customer_name,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
replace(replace(remark,'\n',''),'\t','') remark,
DATE_FORMAT(financial_settlement_time,'%Y-%m-%d %H:%i:%s') financial_settlement_time,
adjust_weight,
adjust_month_price,
adjust_capital,
status,
salesman,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
tech_purity_name,
tech_purity_code,
adjust_type,
adjust_interest from $database.t_bf_the_bill where 1=1"
}
import_t_bf_transfer_owed_work_fee_change(){
import_data t_bf_transfer_owed_work_fee_change " select 
id,
update_transfer_owed_work_fee_identity,
update_transfer_owed_work_fee_code,
showroom_identity,
unit_transfer_owed_identity,
unit_work_fee_change_type,
unit_work_fee_change_type_value,
change_reason,
if_unit_change,
change_date,
create_by,
create_by_name,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
update_by_name,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
approve_by,
approve_by_name,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_transfer_owed_work_fee_change where 1=1"
}
import_t_bf_transfer_owed_work_fee_change_detail(){
import_data t_bf_transfer_owed_work_fee_change_detail " select 
id,
update_transfer_owed_work_fee_identity,
update_transfer_owed_work_fee_detail_identity,
work_fee_input_identity,
work_fee_input_code,
work_fee_input_detail_identity,
customer_code,
customer_name,
customer_identity,
parent_customer_code,
parent_customer_name,
parent_customer_identity,
purity_identity,
purity_name,
source_transfer_owed_identity,
now_transfer_owed_identity,
source_work_fee,
now_work_fee,
if_xq,
status from $database.t_bf_transfer_owed_work_fee_change_detail where 1=1"
}
import_t_bf_transfer_owed_work_fee_from(){
import_data t_bf_transfer_owed_work_fee_from " select 
id,
transfer_owed_code,
transfer_owed_help_code,
transfer_owed_identity,
work_fee_type,
replace(replace(remark,'\n',''),'\t','') remark,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
purity_identity,
purity_name,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
purity_code from $database.t_bf_transfer_owed_work_fee_from where 1=1"
}
import_t_bf_transfer_owed_work_fee_input(){
import_data t_bf_transfer_owed_work_fee_input " select 
id,
work_fee_input_code,
work_fee_input_identity,
showroom_identity,
customer_code,
customer_identity,
parent_customer_code,
parent_customer_identity,
child_customer_seq,
replace(replace(remark,'\n',''),'\t','') remark,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
status,
rq from $database.t_bf_transfer_owed_work_fee_input where 1=1"
}
import_t_bf_transfer_owed_work_fee_input_bak_0702(){
import_data t_bf_transfer_owed_work_fee_input_bak_0702 " select id,
work_fee_input_code,
work_fee_input_identity,
showroom_identity,
customer_code,
customer_identity,
parent_customer_code,
parent_customer_identity,
child_customer_seq,
replace(replace(remark,'\n',''),'\t','') remark,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq
 from $database.t_bf_transfer_owed_work_fee_input_bak_0702 where 1=1"
}
import_t_bf_transfer_owed_work_fee_input_detail(){
import_data t_bf_transfer_owed_work_fee_input_detail " select 
id,
work_fee_input_identity,
work_fee_input_detail_identity,
purity_identity,
purity_name,
transfer_owed_identity,
work_fee_type,
work_fee,
status from $database.t_bf_transfer_owed_work_fee_input_detail where 1=1"
}
import_t_bf_transfer_owed_work_fee_input_detail_bak(){
import_data t_bf_transfer_owed_work_fee_input_detail_bak " select 
id,
work_fee_input_identity,
work_fee_input_detail_identity,
purity_identity,
purity_name,
transfer_owed_identity,
work_fee_type,
work_fee,
status from $database.t_bf_transfer_owed_work_fee_input_detail_bak where 1=1"
}
import_t_bf_transfer_owed_work_fee_input_detail_bak_0702(){
import_data t_bf_transfer_owed_work_fee_input_detail_bak_0702 " select 
id,
work_fee_input_identity,
work_fee_input_detail_identity,
purity_identity,
purity_name,
transfer_owed_identity,
work_fee_type,
work_fee,
status from $database.t_bf_transfer_owed_work_fee_input_detail_bak_0702 where 1=1"
}
import_t_bf_transfer_type(){
import_data t_bf_transfer_type " select 
id,
code,
name,
status from $database.t_bf_transfer_type where 1=1"
}
import_t_bf_warehouse_type(){
import_data t_bf_warehouse_type " select 
id,
warehouse_type_identity,
warehouse_type_code,
warehouse_type_name,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
status from $database.t_bf_warehouse_type where 1=1"
}
import_t_bf_weighing_form(){
import_data t_bf_weighing_form " select 
id,
weighing_identity,
weighing_code,
weighing_date,
showroom_name,
showroom_code,
counter_identity,
counter_name,
type_name,
purity_name,
purity_identity,
approve_by,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
replace(replace(remark,'\n',''),'\t','') remark,
type_warehouse,
number,
total_label,
total_gold_weight,
total,
electron_number,
customer_inventory,
status,
tray_difference,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_weighing_form where 1=1"
}
import_t_bf_weighing_form_appendage(){
import_data t_bf_weighing_form_appendage " select 
id,
weighing_appendage_identity,
weighing_identity,
billing_date,
package_form_code,
gross_weight,
number,
label_wage,
customer_name,
parent_customer_name,
replace(replace(remarks,'\n',''),'\t','') remarks,
form_type,
rq from $database.t_bf_weighing_form_appendage where 1=1"
}
import_t_bf_weighing_form_appendage_check(){
import_data t_bf_weighing_form_appendage_check " select 
id,
weighing_appendage_identity,
weighing_identity,
billing_date,
package_form_code,
gross_weight,
number,
label_wage,
customer_name,
parent_customer_name,
replace(replace(remarks,'\n',''),'\t','') remarks,
form_type,
weighing_code,
rq from $database.t_bf_weighing_form_appendage_check where 1=1"
}
import_t_bf_weighing_form_check(){
import_data t_bf_weighing_form_check " select 
id,
weighing_identity,
weighing_code,
weighing_date,
showroom_name,
showroom_code,
counter_identity,
counter_name,
type_name,
purity_name,
purity_identity,
approve_by,
approve_time,
approve_status,
create_by,
create_time,
replace(replace(remark,'\n',''),'\t','') remark,
type_warehouse,
number,
total_label,
total_gold_weight,
total,
electron_number,
customer_inventory,
status,
tray_difference,
tray_gold_weight,
tray_difference_total,
check_total,
rq from $database.t_bf_weighing_form_check where 1=1"
}
import_t_bf_weighing_form_detail(){
import_data t_bf_weighing_form_detail " select 
id,
weighing_detail_identity,
weighing_identity,
gross_weight,
plate_num,
skin_weight,
gold_weight_detail,
number,
label_wage,
customer_identity,
parent_customer_identity,
choose_date,
replace(replace(remarks,'\n',''),'\t','') remarks,
first_category_name,
first_category_identity,
second_category_name,
second_category_identity from $database.t_bf_weighing_form_detail where 1=1"
}
import_t_bf_weighing_form_detail_check(){
import_data t_bf_weighing_form_detail_check " select 
id,
weighing_detail_identity,
weighing_identity,
gross_weight,
plate_num,
skin_weight,
gold_weight_detail,
number,
label_wage,
customer_identity,
parent_customer_identity,
choose_date,
replace(replace(remarks,'\n',''),'\t','') remarks,
first_category_name,
first_category_identity,
second_category_name,
second_category_identity,
weighing_code,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq from $database.t_bf_weighing_form_detail_check where 1=1"
}
import_t_bf_with_sign(){
import_data t_bf_with_sign " select 
id,
with_sign_code,
with_sign_name,
with_sign_identity,
status,
rq from $database.t_bf_with_sign where 1=1"
}
import_t_bf_xq_single_return(){
import_data t_bf_xq_single_return " select 
id,
xq_single_return_identity,
xq_single_return_code,
DATE_FORMAT(open_date,'%Y-%m-%d %H:%i:%s') open_date,
DATE_FORMAT(date_this,'%Y-%m-%d %H:%i:%s') date_this,
if_print_remark,
showroom_identity,
showroom_name,
purity_identity,
purity_name,
purity_percent,
customer_code,
customer_identity,
customer_name,
parent_customer_code,
parent_customer_identity,
parent_customer_name,
out_of_stock_code,
total_number,
label_price_total,
total_amount,
total_weight,
detail_address,
replace(replace(remark,'\n',''),'\t','') remark,
counter_identity,
counter_name,
package_i_small_code,
create_by,
create_by_name,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
approve_by,
approve_by_name,
DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time,
approve_status,
status,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
total_return_work_fee from $database.t_bf_xq_single_return where 1=1"
}
import_t_bf_xq_single_return_detail(){
import_data t_bf_xq_single_return_detail " select 
id,
xq_single_return_identity,
xq_single_return_detail_identity,
xh,
package_i_small_code,
product_bar_code,
if_record_count,
additional_work_fee,
weight,
counter_identity,
counter_name,
product_style,
purity_identity,
purity_name,
first_genus_name,
second_genus_name,
factory_code,
label_price,
amount,
master_stone_name,
master_stone_number,
master_stone_weight,
gold_stone_name,
replace(replace(remark,'\n',''),'\t','') remark,
gold_stone_code,
number,
product_name,
qr_code,
search_code,
discount_rate,
discount_unit_price,
package_code,
big_category,
sale_work_fee,
receive_date,
receive_code,
receive_name,
account_date,
account_code,
customer_identity,
customer_code,
customer_name,
parent_customer_identity,
parent_customer_name,
base_work_fee,
base_work_fee_amount,
additional_work_fee_amount,
refer_to_amount,
status from $database.t_bf_xq_single_return_detail where 1=1"
}
import_t_buyer(){
import_data t_buyer " select 
id,
buyer_identity,
wechat_desc,
buyer_name,
create_date,
openid,
phone from $database.t_buyer where 1=1"
}
import_t_category(){
import_data t_category " select 
id,
category_identity,
category_code,
category_name,
category_help_code,
parent_id,
parent_identity,
deep_level,
path_str,
create_user_id,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
modify_user_id,
DATE_FORMAT(modify_date,'%Y-%m-%d %H:%i:%s') modify_date,
pic_url,
code_seq from $database.t_category where 1=1"
}
import_t_category_classify(){
import_data t_category_classify " select 
id,
classify_identity,
category_code,
category_name,
productcategory_id,
productcategory_identity,
maincategory_id,
maincategory_identity,
fineness_id,
fineness_identity,
itemownership_id,
itemownership_identity,
itemcategory_id,
itemcategory_identity,
stylecategory_id,
stylecategory_identity,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time from $database.t_category_classify where 1=1"
}
import_t_category_counter_info(){
import_data t_category_counter_info " select 
id,
showroom_name,
counter_identity,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
category_info_code from $database.t_category_counter_info where 1=1"
}
import_t_category_labour(){
import_data t_category_labour " select 
id,
category_labour_code,
showroom_counter_id,
showroom_counter_identity,
category_id,
category_identity,
purity_id,
purity_identity,
genus_id,
genus_identity,
item_id,
item_identity,
additional_labour,
standard_labour,
is_deleted,
second_category_identity,
category_name,
first_category_name,
second_category_name,
help_code from $database.t_category_labour where 1=1"
}
import_t_category_labour_error_bak(){
import_data t_category_labour_error_bak " select 
id,
category_labour_code,
showroom_counter_id,
showroom_counter_identity,
category_id,
category_identity,
purity_id,
purity_identity,
genus_id,
genus_identity,
item_id,
item_identity,
additional_labour,
standard_labour,
is_deleted,
second_category_identity,
category_name from $database.t_category_labour_error_bak where 1=1"
}
import_t_check_account(){
import_data t_check_account " select 
id,
counter_name,
counter_identity,
weight,
number,
price,
eos_weight,
eos_number,
eos_price,
DATE_FORMAT(check_date,'%Y-%m-%d %H:%i:%s') check_date,
create_user,
check_diff_user from $database.t_check_account where 1=1"
}
import_t_check_account_detail(){
import_data t_check_account_detail " select 
id,
counter_name,
counter_identity,
weight,
number,
price,
DATE_FORMAT(check_date,'%Y-%m-%d %H:%i:%s') check_date,
create_user from $database.t_check_account_detail where 1=1"
}
import_t_check_counter(){
import_data t_check_counter " select 
id,
counter_name,
counter_identity,
xh,
type,
purity_identity from $database.t_check_counter where 1=1"
}
import_t_check_quality_detial(){
import_data t_check_quality_detial " select 
id,
receive_identity,
receive_code,
order_identity,
order_code,
product_code,
product_name,
product_style,
company_code,
factory_code,
outsource_code,
piece_weight,
zj_weight,
zj_number,
zj_end,
zj_remark,
zj_weight_receive,
zj_number_receive,
zj_weight_back,
zj_number_back,
zj_weight_back_receive,
zj_number_back_receive,
zj_status_before,
zj_status,
status,
zj_code,
receive_detial_id,
icp_jcz,
hsj_jcz,
replace(replace(remark,'\n',''),'\t','') remark,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time from $database.t_check_quality_detial where 1=1"
}
import_t_check_quality_status(){
import_data t_check_quality_status " select 
id,
number,
check_style,
status from $database.t_check_quality_status where 1=1"
}
import_t_child_customer(){
import_data t_child_customer " select 
id,
customer_id,
customer_identity,
child_customer_identity,
child_customer_name,
child_customer_code,
child_customer_seq,
contact_name,
phone_no,
phone_no_b,
customer_address,
help_code,
active_flag,
legal_person,
id_code,
province,
data_date,
ty_customer_code,
djlsh,
djbth,
license_code,
license_desc,
license_range,
DATE_FORMAT(license_time,'%Y-%m-%d %H:%i:%s') license_time from $database.t_child_customer where 1=1"
}
import_t_child_customer_bdiff(){
import_data t_child_customer_bdiff " select 
DjLsh,
DjBth,
id,
customer_id,
customer_identity,
child_customer_identity,
child_customer_name,
child_customer_code,
child_customer_seq,
enableb,
telephone_numberb,
active_flag,
legalb,
legal_idb,
business_license_numberb,
business_scopeb,
province,
file_date,
area_nameb,
customer_typeb,
wechatb,
authorize_pickerb,
authorize_picker_sexb,
pickup_person_idb,
pickup_person_phoneb,
store_license_full_nameb,
city_level_informationb,
city_county_informationb,
legal_mobilephone_numberb,
enterprise_natureb,
customer_typenb,
brand_nameb,
noteb,
business_license_validityb,
payment_principalb,
payment_principal_bank_card_numberb,
payment_principalb2,
payment_principal_bank_account_nameb2,
payment_principal_bank_card_numberb2,
payment_principal_sub_branchb,
payment_principal_branchb,
payment_principal_bankb,
payment_principal_bankb2,
payment_principal_branchb2,
payment_principal_sub_branchb2,
payment_principal_bank_account_nameb,
validity_period_authorizationb,
validity_period_authorizationb2,
authorization_validity_characterb,
authorization_validity_characterb2,
public_private,
business_belongsb,
phone_no_b from $database.t_child_customer_bdiff where 1=1"
}
import_t_child_customer_bsame(){
import_data t_child_customer_bsame " select 
DjLsh,
DjBth,
id,
customer_id,
customer_identity,
child_customer_identity,
child_customer_name,
child_customer_code,
child_customer_seq,
contact_name,
phone_no,
customer_address,
help_code from $database.t_child_customer_bsame where 1=1"
}
import_t_child_customer_id_djbth(){
import_data t_child_customer_id_djbth " select 
id,
djbth from $database.t_child_customer_id_djbth where 1=1"
}
import_t_client_discount(){
import_data t_client_discount " select 
id,
client_discount_identity,
showroom_identity,
showroom_name,
customer_identity,
customer_code,
discount_class,
settle_discount,
mosaic_discount,
general_discount,
hight_quality_discount,
special_discount,
metal_work_stone_discount,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
is_enable,
eos_head_key,
eos_body_key from $database.t_client_discount where 1=1"
}
import_t_columns(){
import_data t_columns " select 
id,
project_type,
subject_type,
subject_name,
column_code,
column_name,
column_width,
order_no,
del_flag,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time from $database.t_columns where 1=1"
}
import_t_counter_account(){
import_data t_counter_account " select 
id,
counter_identity,
counter_name,
day_begin_weight,
day_end_weight,
current_weight,
transfer_out_weigth,
stock_transfer_out_weight,
stock_transfer_in_weight,
sale_from_weight,
move_counter_weight,
data_id,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
content,
replace(replace(remark,'\n',''),'\t','') remark from $database.t_counter_account where 1=1"
}
import_t_counter_account_5ga(){
import_data t_counter_account_5ga " select 
id,
counter_identity,
counter_name,
day_begin_weight,
day_end_weight,
current_weight,
transfer_out_weigth,
stock_transfer_out_weight,
stock_transfer_in_weight,
sale_from_weight,
move_counter_weight,
data_id,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
content,
replace(replace(remark,'\n',''),'\t','') remark from $database.t_counter_account_5ga where 1=1"
}
import_t_counter_like(){
import_data t_counter_like " select 
id,
fast_package_id,
fast_package_identity,
customer_id,
custoer_identity,
showroom_counter_id,
showroom_counter_identity,
counter_user_id,
counter_user_identity,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
DATE_FORMAT(modify_date,'%Y-%m-%d %H:%i:%s') modify_date,
like_values,
replace(replace(remark,'\n',''),'\t','') remark from $database.t_counter_like where 1=1"
}
import_t_counter_message(){
import_data t_counter_message " select 
id,
message_identity,
code,
salesman_identity,
counter_identity,
customer_identity,
message_content,
message_type,
net_weight,
gross_weight,
leave_counter_weight,
is_read,
is_reject,
is_delete,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
replace(replace(remarks,'\n',''),'\t','') remarks,
product_code,
is_scand from $database.t_counter_message where 1=1"
}
import_t_counter_sale_plan(){
import_data t_counter_sale_plan " select 
id,
sale_plan_identity,
counter_identity,
counter_name,
plan_year,
plan_type,
plan_sale_total,
plan_date_number,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
create_user_identity,
DATE_FORMAT(update_date,'%Y-%m-%d %H:%i:%s') update_date,
update_user_identity from $database.t_counter_sale_plan where 1=1"
}
import_t_cover_customer_log(){
import_data t_cover_customer_log " select 
id,
operate_id,
operate_name,
DATE_FORMAT(operate_time,'%Y-%m-%d %H:%i:%s') operate_time,
operate_msg from $database.t_cover_customer_log where 1=1"
}
import_t_cpbszb(){
import_data t_cpbszb " select 
DjLsh,
DjBth,
DjState,
xh,
JJB,
CKMC,
CKBM,
fjgf,
zhl,
plmc,
YJPLBM,
YJPL,
EJPLBM,
EJPL,
SPTM,
GCKH,
BZGF,
fjje,
plbm,
ZSMC,
ZSSL,
ZSZL,
JSMC,
bzsm,
JSBM,
JS,
SPMC,
EWM,
CXM,
SFXG,
ZLB,
ZKJEB,
YFJGF,
GFZK,
SFDZ,
YJJCGF,
JPGF,
JGF,
TSGF,
LJJJE,
DATE_FORMAT(etl_dt,'%Y-%m-%d %H:%i:%s') etl_dt from $database.t_cpbszb where 1=1"
}
import_t_cpbszb_log(){
import_data t_cpbszb_log " select 
id,
DjBth,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
status,
DjLsh,
package_i_identity,
package_i_code,
fast_package_identity,
xh from $database.t_cpbszb_log where 1=1"
}
import_t_cpbszh(){
import_data t_cpbszh " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
XSZKH,
wdmc,
djh,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
wdbm,
khbm,
csmc,
khmc,
ZKHBM,
ZKHBH,
ZKH,
YWY,
lxr,
KHZJM,
zjz,
dz,
replace(replace(BZ,'\n',''),'\t','') bz,
zdrid,
zdr,
DATE_FORMAT(zdsj,'%Y-%m-%d %H:%i:%s') zdsj,
shr,
DATE_FORMAT(shsj,'%Y-%m-%d %H:%i:%s') shsj,
CSBM,
CS,
ckdh,
hjje,
HJJS,
lxdh,
JSMCB,
PLMCB,
ZL,
JJ,
ZDBC,
TMXY,
DJZT,
DATE_FORMAT(ZFRQ,'%Y-%m-%d') ZFRQ,
QSH,
JSH,
FZGF,
ssckbm,
BQJGHJ,
DBTBZ,
ZKJEH,
CKMCH,
DZCQS,
YJLBH,
YJPLBMH,
DATE_FORMAT(KDRQ,'%Y-%m-%d %H:%i:%s') KDRQ,
GZBZ,
THDH,
THDJM,
ZCJZ,
GZRQ,
CPBBS,
WC,
QY,
DST,
SHMC,
SHBM,
QHXH,
DB,
BDB,
BTCKMC,
BTCKBM,
B2BXS,
FCDH,
WDXAJBQ,
LM,
fast_package_identity,
DATE_FORMAT(etl_dt,'%Y-%m-%d %H:%i:%s') etl_dt,
order_identity,
package_code from $database.t_cpbszh where 1=1"
}
import_t_cpbszh_log(){
import_data t_cpbszh_log " select 
id,
DjLsh,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
fast_package_identity,
order_identity,
package_code,
status,
sales_order,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
sales_type,
salesman_identity,
kdsj from $database.t_cpbszh_log where 1=1"
}
import_t_cpbszh_log_detail(){
import_data t_cpbszh_log_detail " select 
id,
djlsh,
fast_package_identity,
sales_order,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
sales_type,
salesman_identity from $database.t_cpbszh_log_detail where 1=1"
}
import_t_custom_column(){
import_data t_custom_column " select 
id,
column_id,
project_type,
subject_type,
subject_name,
col,
column_name,
column_width,
order_no,
login_user,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
update_by,
iz_selected,
iz_disable,
del_flag from $database.t_custom_column where 1=1"
}
import_t_customer(){
import_data t_customer " select 
id,
customer_identity,
input_type,
active_flag,
subject_code,
customer_code,
customer_name,
customer_short_name,
bank_name,
bank_account,
tax_amount,
address,
phone_no,
fax_no,
web_url,
help_code,
legal_person,
id_code,
position,
mobile_phone,
office_phone,
email,
create_user_code,
create_user_ame,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
modify_user_code,
modify_user_name,
show_balance_rate,
show_sale_rate,
credit_level,
credit_quato,
credit_desc,
pay_time_limit,
price_pay_limit,
balance_rate,
branch_name,
company_name,
branch_type,
province,
province_code,
city,
city_code,
county,
county_desc,
town,
town_desc,
memo,
area_code,
area_name,
labour_discount,
is_customer,
is_supplier,
is_provincial,
day_interest_rate,
salesman_name,
salesman_phone,
address_detail,
contact_no,
contact_name,
sex,
is_five,
customer_card_code,
DATE_FORMAT(contract_begin_date,'%Y-%m-%d %H:%i:%s') contract_begin_date,
DATE_FORMAT(contract_end_date,'%Y-%m-%d %H:%i:%s') contract_end_date,
alliance_amount,
brand_amount,
deposit_amount,
mobile_phone1,
license_desc,
shop_short_name,
customer_debt_name,
test_customer_type,
is_child,
uniq_id,
is_finance,
license_code,
license_range,
license_time,
customer_class,
position_name,
company_nature,
registered_capital,
year_sale_amount,
nature_code,
nature_name,
brand_code,
brand_name,
references_customer,
child_customer,
spec_events_day,
wechat_no,
interest,
buyer_name,
buyer_sex,
buyer_id_code,
buyer_mobile_no,
buyer_position,
delivery_name,
delivery_sex,
delivery_id_code,
delivery_mobile_no,
delivery_position,
authorization_date,
receive_address,
is_display,
customer_type,
of_area,
authorize_payer,
payer_bank_count,
payer_credit_card,
payer_bank_name,
payer_bank_branch,
payer_bank_sub_branch,
authorize_active_date,
authorize_active_str,
authorize_payerb,
payerb_bank_count,
payerb_credit_card,
payerb_bank_name,
payerb_bank_branch,
payerb_bank_sub_branch,
authorize_active_dateb,
authorize_active_strb,
is_official,
is_personal,
data_date,
ty_customer_code,
purity_name,
customer_classification,
djlsh from $database.t_customer where 1=1"
}
import_t_customer_additional(){
import_data t_customer_additional " select 
id,
customer_additional_identity,
customer_identity,
company_nature,
registered_capital,
year_sale_amount,
customer_type_code,
customer_type_name,
brand_code,
brand_name,
references_customer,
relation_sub_account,
spec_events_day,
wechat_no,
interest,
buyer_name,
buyer_sex,
buyer_id_code,
buyer_mobile_no,
buyer_position,
delivery_name,
delivery_sex,
delivery_id_code,
delivery_mobile_no,
delivery_position,
authorization_active_date,
receive_address from $database.t_customer_additional where 1=1"
}
import_t_customer_alliance(){
import_data t_customer_alliance " select 
id,
customer_alliance_identity,
customer_identity,
contract_begin_time,
contract_end_time,
alliance_amount,
brand_amount,
deposit_amount from $database.t_customer_alliance where 1=1"
}
import_t_customer_authorizetopay(){
import_data t_customer_authorizetopay " select 
id,
customer_authorizetopa_identity,
customer_identity,
payer_bank_count,
payer_credit_card,
payer_bank_count2,
payer_credit_card2,
payer_bank_name,
payer_bank_branch,
payer_bank_sub_branch,
payer_bank_name2,
payer_bank_branch2,
payer_bank_sub_branch2,
authorize_payer,
authorize_payer2,
is_official,
is_personal,
authorize_active_date,
authorize_active_str,
authorize_active_date2,
authorize_active_str2 from $database.t_customer_authorizetopay where 1=1"
}
import_t_customer_base(){
import_data t_customer_base " select 
id,
customer_identity,
input_type,
purity_name,
active_flag,
subject_code,
customer_code,
customer_name,
customer_short_name,
bank_name,
bank_account,
tax_amount,
address,
phone_no,
fax_no,
web_url,
help_code,
legal_person,
id_code,
position,
mobile_phone,
office_phone,
email,
create_user_code,
create_user_name,
create_date,
modify_user_code,
modify_user_name,
show_balance_rate,
show_sale_rate,
credit_level,
credit_quato,
credit_desc,
pay_time_limit,
price_pay_limit,
balance_rate,
branch_name,
company_name,
province_code,
province,
city_code,
city,
county_code,
county,
memo,
area_code,
area_name,
labour_discount,
is_customer,
is_supplier,
is_provincial,
day_interest_rate,
salesman_name,
salesman_phone,
address_detail,
contact_no,
contact_name,
is_five,
customer_card_code,
mobile_phone1,
license_desc,
customer_debt_name,
test_customer_type,
uniq_id from $database.t_customer_base where 1=1"
}
import_t_customer_buyer(){
import_data t_customer_buyer " select 
id,
customer_id,
customer_identity,
buyer_id,
buyer_identity,
is_defualt from $database.t_customer_buyer where 1=1"
}
import_t_customer_counter_fastout(){
import_data t_customer_counter_fastout " select 
id,
identity,
customer_identity,
counter_identity,
is_default from $database.t_customer_counter_fastout where 1=1"
}
import_t_customer_discount(){
import_data t_customer_discount " select 
id,
customer_identity,
purity_identity,
purity_name,
counter_identity,
counter_name,
discount_remark,
is_discount,
djlsh from $database.t_customer_discount where 1=1"
}
import_t_customer_discount_detail(){
import_data t_customer_discount_detail " select 
id,
discount_id,
additional_labour,
discount_number from $database.t_customer_discount_detail where 1=1"
}
import_t_customer_discount_detail_hs(){
import_data t_customer_discount_detail_hs " select 
id,
discount_hs_id,
additional_labour,
discount_number,
additional_money,
status,
sequence from $database.t_customer_discount_detail_hs where 1=1"
}
import_t_customer_discount_hjxq_temp(){
import_data t_customer_discount_hjxq_temp " select 
customer_code,
mosaic_discount,
general_discount,
hight_quality_discount,
special_discount from $database.t_customer_discount_hjxq_temp where 1=1"
}
import_t_customer_discount_hs(){
import_data t_customer_discount_hs " select 
id,
customer_identity,
customer_code,
customer_name,
purity_identity,
purity_name,
is_discount,
discount_remark,
voucher_id,
DATE_FORMAT(voucher_time,'%Y-%m-%d %H:%i:%s') voucher_time,
voucher_name,
inter,
update_id,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
status from $database.t_customer_discount_hs where 1=1"
}
import_t_customer_discount_kjxq_temp(){
import_data t_customer_discount_kjxq_temp " select 
customer_code,
metal_work_stone_discount,
general_discount,
hight_quality_discount,
special_discount from $database.t_customer_discount_kjxq_temp where 1=1"
}
import_t_customer_discount_sync(){
import_data t_customer_discount_sync " select 
customer_code,
showroom_code,
seq,
is_discount,
data_date from $database.t_customer_discount_sync where 1=1"
}
import_t_customer_engrave(){
import_data t_customer_engrave " select 
id,
engrave_identity,
counter_identity,
customer_identity,
engrave_content,
is_default,
is_deleted,
DATE_FORMAT(expired_date,'%Y-%m-%d') expired_date,
if_expired,
is_enable,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
DATE_FORMAT(update_date,'%Y-%m-%d %H:%i:%s') update_date,
purity_identity from $database.t_customer_engrave where 1=1"
}
import_t_customer_exhibitsales_sync(){
import_data t_customer_exhibitsales_sync " select 
id,
customer_code,
showroom_code,
KHLXH from $database.t_customer_exhibitsales_sync where 1=1"
}
import_t_customer_gemset_discount(){
import_data t_customer_gemset_discount " select 
customer_identity,
khbm,
zkhmc,
kxdydf_ph_discount,
kxdydf_jp_discount,
kxdydf_tj_discount,
kx_discount,
ks_discount,
ks_discount_desc,
hx_discount,
hx_discount_desc,
hjdydf_ph_discount,
hjdydf_jp_discount,
hjdydf_tj_discount,
id,
create_user,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
children_customer_identity from $database.t_customer_gemset_discount where 1=1"
}
import_t_customer_gemset_discount_fail(){
import_data t_customer_gemset_discount_fail " select 
id,
customer_identity,
khbm,
zkhmc,
children_customer_identity,
kx_discount,
ks_discount,
ks_discount_desc,
fail_message from $database.t_customer_gemset_discount_fail where 1=1"
}
import_t_customer_gemset_discount_history(){
import_data t_customer_gemset_discount_history " select 
customer_identity,
khbm,
zkhmc,
kx_discount,
ks_discount,
old_kx_discount,
old_ks_discount,
ks_discount_desc,
hx_discount_desc,
id,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
create_user,
children_customer_identity from $database.t_customer_gemset_discount_history where 1=1"
}
import_t_customer_icon(){
import_data t_customer_icon " select 
id,
icon_code,
customer_name,
icon_url from $database.t_customer_icon where 1=1"
}
import_t_customer_license(){
import_data t_customer_license " select 
id,
customer_license_identity,
customer_identity,
license_scan,
legal_person_id_card_scan,
legal_person_sex,
license_code,
license_range,
DATE_FORMAT(license_time,'%Y-%m-%d %H:%i:%s') license_time,
customer_id_card_scan from $database.t_customer_license where 1=1"
}
import_t_customer_phone_cp(){
import_data t_customer_phone_cp " select 
customer_code,
customer_name,
seq,
is_child,
phone1,
phone2,
phone3,
phone4,
active_flag,
parent_code,
DATE_FORMAT(data_date,'%Y-%m-%d %H:%i:%s') data_date,
child_customer_code from $database.t_customer_phone_cp where 1=1"
}
import_t_customer_phone_sync(){
import_data t_customer_phone_sync " select 
customer_code,
seq,
is_child,
phone1,
phone2,
phone3,
phone4,
active_flag,
parent_code,
is_new,
djlsh,
customer_name,
DATE_FORMAT(data_date,'%Y-%m-%d %H:%i:%s') data_date,
child_customer_code from $database.t_customer_phone_sync where 1=1"
}
import_t_customer_require_time(){
import_data t_customer_require_time " select 
id,
showroom_code,
user_code,
DATE_FORMAT(start_time,'%Y-%m-%d %H:%i:%s') start_time,
DATE_FORMAT(end_time,'%Y-%m-%d %H:%i:%s') end_time,
DATE_FORMAT(etl_dt,'%Y-%m-%d %H:%i:%s') etl_dt,
require_frequency from $database.t_customer_require_time where 1=1"
}
import_t_customer_salesman(){
import_data t_customer_salesman " select 
id,
customer_id,
customer_identity,
salesman_id,
salesman_identity,
reception_salesman_identity,
is_deleted,
reception_salesman_id from $database.t_customer_salesman where 1=1"
}
import_t_customer_tag(){
import_data t_customer_tag " select 
id,
tag_identity,
counter_identity,
customer_identity,
tag_content,
is_deleted,
is_default from $database.t_customer_tag where 1=1"
}
import_t_customer_type(){
import_data t_customer_type " select 
id,
customer_type_identity,
customer_type_code,
customer_type_name,
is_deleted,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time from $database.t_customer_type where 1=1"
}
import_t_customer_wait(){
import_data t_customer_wait " select 
id,
wait_identity,
fast_package_id,
fast_package_identity,
is_end,
is_delete,
create_user_id,
create_date,
modify_user_id,
modify_date from $database.t_customer_wait where 1=1"
}
import_t_daily_interrest_err_log(){
import_data t_daily_interrest_err_log " select 
DATE_FORMAT(run_time,'%Y-%m-%d %H:%i:%s') run_time,
pro_name,
err_msg from $database.t_daily_interrest_err_log where 1=1"
}
import_t_daily_interrest_log(){
import_data t_daily_interrest_log " select 
DATE_FORMAT(run_time,'%Y-%m-%d %H:%i:%s') run_time,
pro_name,
log_info from $database.t_daily_interrest_log where 1=1"
}
import_t_default_discount_mosaic(){
import_data t_default_discount_mosaic " select 
id,
default_discount_mosaic_identity,
showroom_identity,
counter_identity,
mosaic_discount,
eos_head_key,
eos_body_key,
hj_dydf_ph_discount,
hj_dydf_jp_discount from $database.t_default_discount_mosaic where 1=1"
}
import_t_delay_region(){
import_data t_delay_region " select 
id,
province,
salesman_role_identity,
area_identity from $database.t_delay_region where 1=1"
}
import_t_delay_task(){
import_data t_delay_task " select 
id,
task_identity,
handler_user,
handler_user_type,
customer_identity,
package_type,
estimate_time,
delay_status,
comments,
is_end,
DATE_FORMAT(end_time,'%Y-%m-%d %H:%i:%s') end_time,
create_user,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
delat_code,
DATE_FORMAT(initial_create_time,'%Y-%m-%d %H:%i:%s') initial_create_time,
DATE_FORMAT(approval_time,'%Y-%m-%d %H:%i:%s') approval_time,
status,
auto_type from $database.t_delay_task where 1=1"
}
import_t_delay_task_detail(){
import_data t_delay_task_detail " select 
id,
task_identity,
package_code,
weight from $database.t_delay_task_detail where 1=1"
}
import_t_deposit_delivery(){
import_data t_deposit_delivery " select 
id,
delivery_identity,
delivery_code,
DATE_FORMAT(delivery_time,'%Y-%m-%d %H:%i:%s') delivery_time,
print_content,
create_identity,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
showroom_identity from $database.t_deposit_delivery where 1=1"
}
import_t_deposit_jewelry(){
import_data t_deposit_jewelry " select 
id,
deposit_identity,
jewelry_purity_name,
jewelry_weight from $database.t_deposit_jewelry where 1=1"
}
import_t_deposit_order(){
import_data t_deposit_order " select 
id,
deposit_identity,
deposit_code,
deposit_type,
goods_source,
receiver_type,
receiver_factory_name,
receiver_dept,
receiver_name,
deposit_number,
deposit_remarks,
customer_code,
customer_identity,
customer_name,
children_customer_name,
jewelry_type,
jewelry_weight,
create_identity,
create_name,
sf_code,
delivery_code,
DATE_FORMAT(delivery_time,'%Y-%m-%d %H:%i:%s') delivery_time,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
marking_status,
deposit_status,
is_delete,
deposit_registration_type,
showroom_identity,
delivery_user_identity,
delivery_user_name,
first_name from $database.t_deposit_order where 1=1"
}
import_t_deposit_setting(){
import_data t_deposit_setting " select 
id,
name,
children_name,
type,
showroom_identity from $database.t_deposit_setting where 1=1"
}
import_t_djjz_procedure_excute_err_log(){
import_data t_djjz_procedure_excute_err_log " select 
id,
procedure_name,
procedure_describe,
DATE_FORMAT(excute_time,'%Y-%m-%d %H:%i:%s') excute_time,
excute_user,
bill_identity,
bill_code,
err_msg from $database.t_djjz_procedure_excute_err_log where 1=1"
}
import_t_download(){
import_data t_download " select 
id,
down_identity,
file_name,
file_path,
message,
handle_status,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
DATE_FORMAT(end_time,'%Y-%m-%d %H:%i:%s') end_time,
create_user from $database.t_download where 1=1"
}
import_t_email_config(){
import_data t_email_config " select 
id,
email_key,
email_username,
val_status from $database.t_email_config where 1=1"
}
import_t_eos_fail(){
import_data t_eos_fail " select 
id,
fast_package_identity,
showroom_code,
order_identity,
customer_identity,
salesman_identity,
number from $database.t_eos_fail where 1=1"
}
import_t_eos_order(){
import_data t_eos_order " select 
id,
order_identity,
order_code,
purity_name,
estimate_time,
supplier_identity,
supplier_name,
supplier_source,
supplier_type,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
status,
customer_name,
customer_code,
engrave_content,
customer_showroom,
order_type,
counter_name,
engrave_code,
djlsh,
variety,
end_reason,
return_identity,
source_order_type,
if_receive_happen,
order_total_number,
order_total_weight,
receiving_status,
kgd,
is_have_recall,
djh,
khmc,
khdm,
ppmc from $database.t_eos_order where 1=1"
}
import_t_eos_order_detial(){
import_data t_eos_order_detial " select 
id,
order_identity,
order_code,
product_photo,
product_code,
product_bar_code,
product_name,
product_style,
category_code,
transfer_settlement_price,
gold_stone_name,
company_code,
factory_code,
purity_name,
master_stone_name,
piece_weight,
gold_weight,
order_number,
order_weight,
work_fee,
estimate_time,
technology_unit_price,
color_gold_weight,
label_price,
metal_color,
contain_loss_weight,
total_weight,
loss_rate,
net_gold_weight,
unit_gold_weight,
price,
jade_stone_size,
price_interval_lowest,
price_interval_highest,
stone_unit,
master_stone_number,
master_stone_weight,
master_stone_unit_price,
valuation_method,
valuation_method_one,
side_stone_name_one,
side_stone_number_one,
side_stone_weight_one,
side_stone_unit_price_one,
valuation_method_two,
side_stone_name_two,
side_stone_number_two,
side_stone_weight_two,
side_stone_unit_price_two,
stone_fee,
stone_total_fee,
base_work_fee,
attach_work_fee,
make_up_fee,
other_fee,
total_fee,
style_category,
specification_name,
label_name,
if_boutique,
if_receive_ok,
return_identity,
first_category,
second_category,
djbth,
djlsh,
return_detail_id,
receive_payment_type,
receiving_detail_status,
receive_code,
receive_detail_id,
djh,
realddbh,
fee_type,
htm,
khmc,
khdm,
hz,
bqm,
specifications,
workmanship,
ppmc from $database.t_eos_order_detial where 1=1"
}
import_t_estimate_update_log(){
import_data t_estimate_update_log " select 
id,
user_id,
package_code,
estimate_time,
create_time,
reason_for_application from $database.t_estimate_update_log where 1=1"
}
import_t_fast_counter(){
import_data t_fast_counter " select 
id,
counter_identity,
showroom_counter_id,
showroom_counter_identity,
item_id,
item_identity,
showroom_id,
showroom_identity,
status,
is_delete from $database.t_fast_counter where 1=1"
}
import_t_fast_cus(){
import_data t_fast_cus " select 
id,
customer_identity,
customer_name,
customer_code,
is_child,
phone1,
phone2,
phone3,
phone4,
contact_man,
parent_customer_identity,
is_discount,
is_engrave,
is_tag,
is_fast_out,
company_name,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
province,
mobile_contact_person,
replace(replace(remarks,'\n',''),'\t','') remarks,
DATE_FORMAT(data_date,'%Y-%m-%d %H:%i:%s') data_date,
ty_customer_code,
purity_name,
is_extends,
is_exhibition from $database.t_fast_cus where 1=1"
}
import_t_fast_customer(){
import_data t_fast_customer " select 
id,
customer_identity,
customer_name,
customer_code,
is_child,
phone1,
phone2,
phone3,
phone4,
contact_man,
parent_customer_identity,
is_discount,
is_engrave,
is_tag,
is_fast_out,
company_name,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
province,
mobile_contact_person,
replace(replace(remarks,'\n',''),'\t','') remarks,
DATE_FORMAT(data_date,'%Y-%m-%d %H:%i:%s') data_date,
ty_customer_code,
purity_name,
is_extends,
is_exhibition,
area_identity,
technology_purity_identity,
showroom_identity,
label_show_original_price,
status from $database.t_fast_customer where 1=1"
}
import_t_fast_customer_log(){
import_data t_fast_customer_log " select 
id,
customer_identity,
customer_name,
customer_code,
is_child,
phone1,
phone2,
phone3,
phone4,
contact_man,
parent_customer_identity,
is_discount,
is_engrave,
is_tag,
is_fast_out,
company_name,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
province,
mobile_contact_person,
replace(replace(remarks,'\n',''),'\t','') remarks,
DATE_FORMAT(data_date,'%Y-%m-%d %H:%i:%s') data_date,
insert_date,
log_identity from $database.t_fast_customer_log where 1=1"
}
import_t_fast_customer_queue(){
import_data t_fast_customer_queue " select 
id,
customer_identity,
serial_number,
is_handle,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
is_urgent from $database.t_fast_customer_queue where 1=1"
}
import_t_fast_item(){
import_data t_fast_item " select 
item_id,
item_identity,
item_code,
item_name,
additional_labour,
standard_labour,
genus_id,
genus_identity,
category_id,
category_identity,
purity_id,
purity_identity,
status,
is_delete from $database.t_fast_item where 1=1"
}
import_t_fast_order(){
import_data t_fast_order " select 
id,
order_identity,
package_number,
processed_number,
customer_identity,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
is_complete,
replace(replace(remarks,'\n',''),'\t','') remarks,
gold_price,
serial_number,
is_urgent,
settlement_method,
is_suspend,
customer_confirmation_time,
sales_status_id,
counter_name,
wait_number,
update_time,
salesman_identity,
DATE_FORMAT(confirm_time,'%Y-%m-%d %H:%i:%s') confirm_time,
DATE_FORMAT(completion_time,'%Y-%m-%d %H:%i:%s') completion_time from $database.t_fast_order where 1=1"
}
import_t_fast_order_purity(){
import_data t_fast_order_purity " select 
id,
order_purity_identity,
order_identity,
purity_identity,
purity_code,
purity_name,
deduction_weight from $database.t_fast_order_purity where 1=1"
}
import_t_fast_package(){
import_data t_fast_package " select 
id,
fast_package_identity,
package_code,
package_name,
status_id,
showroom_identity,
customer_id,
customer_identity,
counter_user_id,
counter_user_identity,
initial_package_code,
net_weight,
gross_weight,
purity_id,
purity_identity,
showroom_counter_id,
showroom_counter_identity,
additional_labour_amount,
standard_labour_amount,
status,
is_delete,
replace(replace(remarks,'\n',''),'\t','') remarks,
marking_identity,
create_date,
is_urgent,
DATE_FORMAT(confirmatio_time,'%Y-%m-%d %H:%i:%s') confirmatio_time,
is_lm,
sales_status_id,
DATE_FORMAT(customer_require_time,'%Y-%m-%d %H:%i:%s') customer_require_time,
DATE_FORMAT(customer_confirmation_time,'%Y-%m-%d %H:%i:%s') customer_confirmation_time,
DATE_FORMAT(leave_counter_time,'%Y-%m-%d %H:%i:%s') leave_counter_time,
settlement_method,
update_user,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
is_fast_out,
order_identity,
print_label,
is_print,
is_stay,
stay_identity,
is_return,
is_b2b,
additional_labour_no_discount_amount,
salesman_identity,
delay_number,
is_visible,
delay_status,
disable_delay,
DATE_FORMAT(rq,'%Y-%m-%d') estimate_time,
delay_salesman_identity,
delay_care,
goods_picker,
goods_picker_phone,
return_goods,
package_i_type,
current_data_type,
DATE_FORMAT(business_require_time,'%Y-%m-%d %H:%i:%s') business_require_time,
sale_code,
kdsj,
if_sale_status,
DATE_FORMAT(gzrq,'%Y-%m-%d %H:%i:%s') gzrq from $database.t_fast_package where 1=1"
}
import_t_fast_package_delete(){
import_data t_fast_package_delete " select 
id,
customer_identity,
package_code,
reason,
create_user,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time from $database.t_fast_package_delete where 1=1"
}
import_t_fast_package_engrave(){
import_data t_fast_package_engrave " select 
id,
engrave_identity,
engrave_content,
customer_require_time,
net_weight,
gross_weight,
counter_code,
customer_identity,
showroom_counter_identity,
replace(replace(remarks,'\n',''),'\t','') remarks,
code,
engrave_status,
DATE_FORMAT(creat_time,'%Y-%m-%d %H:%i:%s') creat_time,
is_fast_out,
operation_content,
batch_code,
engrave_staff,
quality_staff,
qualitycon_staff,
DATE_FORMAT(receive_time,'%Y-%m-%d %H:%i:%s') receive_time,
DATE_FORMAT(complete_time,'%Y-%m-%d %H:%i:%s') complete_time from $database.t_fast_package_engrave where 1=1"
}
import_t_fast_package_flowing(){
import_data t_fast_package_flowing " select 
id,
flowing_identity,
fast_package_identity,
package_code,
net_weight,
type,
is_now,
replace(replace(remarks,'\n',''),'\t','') remarks,
create_user_id,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
modify_user_id,
DATE_FORMAT(modify_date,'%Y-%m-%d %H:%i:%s') modify_date from $database.t_fast_package_flowing where 1=1"
}
import_t_fast_package_i(){
import_data t_fast_package_i " select 
id,
package_i_identity,
fast_package_id,
package_i_code,
fast_package_identity,
category_id,
category_identity,
item_qty,
net_weight,
genus_id,
genus_identity,
additional_labour,
standard_labour,
gross_weight,
status,
is_delete,
package_status,
replace(replace(remarks,'\n',''),'\t','') remarks,
is_discount,
packing_paper_number,
plastic_bag_number,
manual_input_number,
automatic_input_number,
gross_manual_input_number,
gross_automatic_input_number,
dif_reason,
is_return,
additional_labour_discount,
additional_labour_discount_amount,
technology_num,
technology_unit_price,
technology_count_price,
genus_name,
price_method,
product_code,
metal_color,
stone_color,
specs,
gold_weight,
parts_weight,
total_stone_weight,
main_stone_weight,
auxiliary_stone_weight,
total_weight,
loss,
gold_costs,
label_price,
fixed_price,
sales_fee,
product_type,
product_name,
certificate_no,
clarity,
contains_consumption_weight,
help_remember_code,
total_number,
company_model_code,
category_second_identity,
discount,
discount_price,
stone_costs,
gold_unit_price,
special_discount,
sales_discount_fee,
stone_encrusted_fee,
stone_total_fee,
parts_cost_amount_total_fee,
main_stone_prices,
auxiliary_stone_price,
auxiliary_stone_total_price,
main_stone_price,
is_dydf_counter,
is_fixed_price,
other_price,
batch_price from $database.t_fast_package_i where 1=1"
}
import_t_fast_package_i_plastic(){
import_data t_fast_package_i_plastic " select 
id,
package_i_identity,
plastic_number,
plastic_size,
plastic_id,
plastic_name from $database.t_fast_package_i_plastic where 1=1"
}
import_t_fast_package_i_product(){
import_data t_fast_package_i_product " select 
id,
fast_package_prodct_identity,
fast_package_item_id,
fast_package_item_identity,
main_item_id,
main_item_identity,
item_qty,
net_weight,
additional_labour,
standard_labour,
status,
is_delete,
product_code,
genus_name,
first_genus_name,
second_genus_name,
factory_code,
label_price,
replace(replace(remarks,'\n',''),'\t','') remarks,
is_high_quality,
discount,
discount_price,
fast_package_identity from $database.t_fast_package_i_product where 1=1"
}
import_t_fast_package_operation_log(){
import_data t_fast_package_operation_log " select 
id,
operation_identity,
operation_content,
operation_type,
create_user,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time from $database.t_fast_package_operation_log where 1=1"
}
import_t_fast_package_reason(){
import_data t_fast_package_reason " select 
id,
showroom_identity,
delete_reason,
del_flag from $database.t_fast_package_reason where 1=1"
}
import_t_fast_package_record(){
import_data t_fast_package_record " select 
id,
fast_package_record_identity,
fast_package_identity,
package_code,
package_name,
status_id,
customer_identity,
counter_user_identity,
initial_package_code,
net_weight,
gross_weight,
purity_identity,
showroom_counter_identity,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
DATE_FORMAT(data_date,'%Y-%m-%d %H:%i:%s') data_date from $database.t_fast_package_record where 1=1"
}
import_t_fast_package_status(){
import_data t_fast_package_status " select 
id,
status_code,
status_name from $database.t_fast_package_status where 1=1"
}
import_t_fast_package_tag(){
import_data t_fast_package_tag " select 
id,
tag_identity,
tag_content,
customer_require_time,
net_weight,
gross_weight,
customer_identity,
counter_code,
showroom_counter_identity,
replace(replace(remarks,'\n',''),'\t','') remarks,
code,
tag_status,
is_fast_out,
operation_content,
batch_code,
DATE_FORMAT(creat_time,'%Y-%m-%d %H:%i:%s') creat_time,
DATE_FORMAT(receive_time,'%Y-%m-%d %H:%i:%s') receive_time,
DATE_FORMAT(complete_time,'%Y-%m-%d %H:%i:%s') complete_time,
tag_staff from $database.t_fast_package_tag where 1=1"
}
import_t_fast_package_temporary(){
import_data t_fast_package_temporary " select 
id,
package_identity,
package_code,
initial_package_code,
customer_identity,
package_desc,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
replace(replace(remarks,'\n',''),'\t','') remarks,
net_weight,
create_by_name,
create_by,
goods_picker,
goods_picker_phone,
operation_by,
DATE_FORMAT(operation_by_time,'%Y-%m-%d %H:%i:%s') operation_by_time,
operation_by_name,
counter_identity from $database.t_fast_package_temporary where 1=1"
}
import_t_fast_package_update_customer(){
import_data t_fast_package_update_customer " select 
id,
package_code,
initial_package_code,
is_print,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date from $database.t_fast_package_update_customer where 1=1"
}
import_t_fast_technology_price(){
import_data t_fast_technology_price " select 
id,
technology_identity,
package_i_identity,
technology_num,
technology_unit_price,
technology_count_price from $database.t_fast_technology_price where 1=1"
}
import_t_finance_customer_info(){
import_data t_finance_customer_info " select 
id,
finance_customer_info_identity,
showroom_identity,
showroom_name,
finance_customer_code,
finance_customer_name,
create_time,
create_user_id,
create_user_name,
update_time,
update_user_id,
update_user_name,
is_delete,
djlsh from $database.t_finance_customer_info where 1=1"
}
import_t_finance_customer_relation(){
import_data t_finance_customer_relation " select 
id,
finance_customer_relation_identity,
finance_customer_info_identity,
showroom_identity,
showroom_name,
customer_identity,
customer_code,
parent_customer_identity,
parent_customer_name,
customer_name,
child_customer_name,
is_main_customer,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_user_id,
create_user_name,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
update_user_id,
update_user_name,
is_delete,
djlsh,
djbth from $database.t_finance_customer_relation where 1=1"
}
import_t_fjgfzkbb_sync(){
import_data t_fjgfzkbb_sync " select 
djlsh,
gfje,
zkl from $database.t_fjgfzkbb_sync where 1=1"
}
import_t_fjgfzkbh_sync(){
import_data t_fjgfzkbh_sync " select 
djlsh,
khmc,
khbm,
replace(replace(BZ,'\n',''),'\t','') bz,
zkhmc,
zkhbh,
csgs,
khbm_jds,
khmc_jds from $database.t_fjgfzkbh_sync where 1=1"
}
import_t_gemstone_attribute(){
import_data t_gemstone_attribute " select 
id,
purity_name,
gold_gem_code,
gold_gem_name from $database.t_gemstone_attribute where 1=1"
}
import_t_genus(){
import_data t_genus " select 
id,
genus_identity,
genus_code,
genus_name,
genus_help_code,
create_user_id,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
modify_user_id,
DATE_FORMAT(modify_date,'%Y-%m-%d %H:%i:%s') modify_date from $database.t_genus where 1=1"
}
import_t_gf_area_customer(){
import_data t_gf_area_customer " select 
id,
area_identity,
customer_identity,
is_child,
is_delete from $database.t_gf_area_customer where 1=1"
}
import_t_history_data_move_log(){
import_data t_history_data_move_log " select 
DATE_FORMAT(run_time,'%Y-%m-%d %H:%i:%s') run_time,
msg_info from $database.t_history_data_move_log where 1=1"
}
import_t_hw_model_fee(){
import_data t_hw_model_fee " select 
id,
product_model_fee_identity,
model_code,
model_name,
metal_color_code,
metal_color_name,
single_fee,
sales_fee,
actual_sales_fee,
data_class,
eos_head_key,
eos_body_key,
mnemonic_code,
model_code_color from $database.t_hw_model_fee where 1=1"
}
import_t_incoming_difference(){
import_data t_incoming_difference " select 
id,
area_identity,
area_name,
plan_incoming,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
update_by from $database.t_incoming_difference where 1=1"
}
import_t_incoming_maintain(){
import_data t_incoming_maintain " select 
id,
name,
sub_name,
identity,
type,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_by from $database.t_incoming_maintain where 1=1"
}
import_t_initial_package_update_customer(){
import_data t_initial_package_update_customer " select 
id,
old_code,
new_code,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
create_user from $database.t_initial_package_update_customer where 1=1"
}
import_t_initial_weight(){
import_data t_initial_weight " select 
id,
initial_weight_identity,
super_tag,
showroom_identity,
customer_identity,
showroom_counter_identity,
counter_user_identity,
initial_counter_user_identity,
initial_weight,
net_weight,
tray_number,
is_engrave,
is_tag,
engrave_content,
tag_content,
engrave_require_time,
tag_require_time,
business_require,
replace(replace(remarks,'\n',''),'\t','') remarks,
is_immediate,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_user,
DATE_FORMAT(business_require_time,'%Y-%m-%d %H:%i:%s') business_require_time,
business_require_id,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
is_handle_engrave,
is_handle_tag,
is_send_notify,
is_fast_out,
is_stay,
stay_identity,
sales_status_id,
status_id,
salesman_identity,
is_return,
delay_number,
is_visible,
disable_delay,
estimate_time,
delay_status,
delay_salesman_identity,
delay_care,
goods_picker,
goods_picker_phone,
is_end from $database.t_initial_weight where 1=1"
}
import_t_initial_weight_delete(){
import_data t_initial_weight_delete " select 
id,
initial_weight_identity,
super_tag,
new_code,
showroom_identity,
customer_identity,
showroom_counter_identity,
counter_user_identity,
initial_counter_user_identity,
initial_weight,
net_weight,
tray_number,
is_engrave,
is_tag,
engrave_content,
tag_content,
DATE_FORMAT(engrave_require_time,'%Y-%m-%d %H:%i:%s') engrave_require_time,
DATE_FORMAT(tag_require_time,'%Y-%m-%d %H:%i:%s') tag_require_time,
business_require,
replace(replace(remarks,'\n',''),'\t','') remarks,
is_immediate,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_user,
DATE_FORMAT(business_require_time,'%Y-%m-%d %H:%i:%s') business_require_time,
business_require_id,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
is_handle_engrave,
is_handle_tag,
is_send_notify,
is_fast_out,
is_stay,
stay_identity,
sales_status_id,
status_id,
salesman_identity,
is_return,
delay_number,
is_visible,
delay_status,
disable_delay,
DATE_FORMAT(estimate_time,'%Y-%m-%d') estimate_time,
delay_salesman_identity,
delay_care,
goods_picker,
goods_picker_phone from $database.t_initial_weight_delete where 1=1"
}
import_t_initial_weight_record(){
import_data t_initial_weight_record " select 
id,
initial_weight_record_identity,
initial_weight_identity,
super_tag,
customer_identity,
showroom_counter_identity,
counter_user_identity,
initial_counter_user_identity,
initial_weight,
net_weight,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
DATE_FORMAT(data_date,'%Y-%m-%d %H:%i:%s') data_date from $database.t_initial_weight_record where 1=1"
}
import_t_initial_weight_status(){
import_data t_initial_weight_status " select 
id,
status_code,
status_name from $database.t_initial_weight_status where 1=1"
}
import_t_insert_log_fail(){
import_data t_insert_log_fail " select 
param,
DATE_FORMAT(insert_time,'%Y-%m-%d %H:%i:%s') insert_time from $database.t_insert_log_fail where 1=1"
}
import_t_invalid_combined(){
import_data t_invalid_combined " select 
id,
message_id,
message,
code,
status,
DATE_FORMAT(consumer_time,'%Y-%m-%d %H:%i:%s') consumer_time,
topic,
tags from $database.t_invalid_combined where 1=1"
}
import_t_ka_kxjczb(){
import_data t_ka_kxjczb " select 
id,
wdbm,
wdmc,
customer_identity,
parent_customer_identity,
jz,
kxed,
kqze,
kxzq,
kqzl,
KCEB,
RXSZE,
HCKXED,
DRJYZE,
KQJZ,
KQJE,
MXTS,
DQJZ,
DQJE,
czzt,
same_customer_purity from $database.t_ka_kxjczb where 1=1"
}
import_t_ka_lllsz(){
import_data t_ka_lllsz " select 
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
id,
djm,
djh,
swlx,
csbm,
csmc,
plbm,
plmc,
sffx,
jz,
wdbm,
wdmc,
ckbm,
ckmc,
hl,
llsm,
khlx,
gylx,
customer_identity,
parent_customer_identity,
czzt,
lllsz_identity,
zjm,
tech_purity_name,
tech_purity_code from $database.t_ka_lllsz where 1=1"
}
import_t_ka_llmxz_b(){
import_data t_ka_llmxz_b " select 
id,
llmxz_H_identity,
llmxz_B_identity,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
djm,
djh,
djhh,
csbm,
csmc,
hl,
plbm,
plmc,
zqjz,
wjjz,
yjjz,
replace(replace(BZ,'\n',''),'\t','') bz,
dcwdmc,
gylx,
customer_identity,
parent_customer_identity,
jz,
czzt from $database.t_ka_llmxz_b where 1=1"
}
import_t_ka_llmxz_h(){
import_data t_ka_llmxz_h " select 
id,
llmxz_H_identity,
customer_identity,
parent_customer_identity,
jz,
wdbm,
wdmc,
customer_help_code from $database.t_ka_llmxz_h where 1=1"
}
import_t_ka_llmxz_s(){
import_data t_ka_llmxz_s " select 
id,
llmxz_H_identity,
llmxz_B_identity,
llmxz_S_identity,
jsrq,
jsdm,
jsdh,
jshh,
jsjz,
drwdmc from $database.t_ka_llmxz_s where 1=1"
}
import_t_ka_lscqmxb_b(){
import_data t_ka_lscqmxb_b " select 
lscqmxb_h_identity,
lscqmxb_b_identity,
rq,
drdqzk,
drlx,
drwdqzk,
drdqjz,
drwdqjz,
bygf,
sygf,
ccjz,
drxzlx,
drccf,
yjd,
qzxl,
wzxl,
xlhz,
sylx,
scbs,
yccjz,
ylx,
syql,
syzqk,
yccf,
kmxccjz,
djlsh,
djbth from $database.t_ka_lscqmxb_b where 1=1"
}
import_t_ka_lscqmxb_h(){
import_data t_ka_lscqmxb_h " select 
id,
lscqmxb_h_identity,
wdmc,
wdbm,
customer_identity,
khbm,
khmc,
zkh,
purity_name,
zjm,
wyid,
ycbs,
cwbz,
ztyc,
djlsh from $database.t_ka_lscqmxb_h where 1=1"
}
import_t_ka_lscqmxb_s(){
import_data t_ka_lscqmxb_s " select 
lscqmxb_h_identity,
lscqmxb_b_identity,
rqs,
lx,
jyje,
pl,
zq,
scbz from $database.t_ka_lscqmxb_s where 1=1"
}
import_t_ka_lsedzb(){
import_data t_ka_lsedzb " select 
id,
lsedzb_identity,
wdbm,
wdmc,
customer_identity,
lsed,
kqze,
kxzq,
kqzl,
mxts from $database.t_ka_lsedzb where 1=1"
}
import_t_ka_lsz_h(){
import_data t_ka_lsz_h " select 
id,
djm,
djh,
rq,
sptm,
swlx,
wdmc,
splx,
ckmc,
spmc,
ppmc,
dlmc,
jsmc,
plmc,
sffx,
js,
jz,
hz,
sjcb,
bzjg,
bqjg,
ykj,
jp,
jsje,
lsje,
zsmc,
khmc,
rhf,
chf,
czzt from $database.t_ka_lsz_h where 1=1"
}
import_t_ka_mxz(){
import_data t_ka_mxz " select 
id,
kczt,
kdzt,
sptm,
zshm,
giazs,
wdmc,
ckmc,
gysbm,
gys,
ppmc,
dlmc,
jsmc,
plmc,
gckh,
gskh,
gg,
spmc,
splx,
xlmc,
jz,
hz,
jgf,
xsgf,
sxf,
zsys,
zsjd,
zsqg,
zssl,
zszl,
fsmc,
fssl,
fszl,
js,
sjcb,
sccb,
bzjg,
bqjg,
dw,
khh,
ykj,
jp,
gflx,
pjsm,
cfhh,
replace(replace(BZ,'\n',''),'\t','') bz,
rkrq,
rkdh,
rkdm,
gxrq,
gxdh,
pdzt,
pddh,
lsdh,
lsrq,
xsdj,
sjzk,
ml,
mjj,
lsje,
jsdh,
jsrq,
jsje,
khmc,
zsmc,
cxm,
ewm,
ewmx,
lbdm,
zscb,
fscb,
wxfy,
bzcb,
zsgg,
wxdm,
bqm from $database.t_ka_mxz where 1=1"
}
import_t_ka_mxz_bak20220802(){
import_data t_ka_mxz_bak20220802 " select 
id,
kczt,
kdzt,
sptm,
zshm,
giazs,
wdmc,
ckmc,
gysbm,
gys,
ppmc,
dlmc,
jsmc,
plmc,
gckh,
gskh,
gg,
spmc,
splx,
xlmc,
jz,
hz,
jgf,
xsgf,
sxf,
zsys,
zsjd,
zsqg,
zssl,
zszl,
fsmc,
fssl,
fszl,
js,
sjcb,
sccb,
bzjg,
bqjg,
dw,
khh,
ykj,
jp,
gflx,
pjsm,
cfhh,
replace(replace(BZ,'\n',''),'\t','') bz,
rkrq,
rkdh,
rkdm,
gxrq,
gxdh,
pdzt,
pddh,
lsdh,
lsrq,
xsdj,
sjzk,
ml,
mjj,
lsje,
jsdh,
jsrq,
jsje,
khmc,
zsmc,
cxm,
ewm,
ewmx,
lbdm,
zscb,
fscb,
wxfy,
bzcb,
zsgg,
wxdm,
bqm from $database.t_ka_mxz_bak20220802 where 1=1"
}
import_t_ka_mxz_update(){
import_data t_ka_mxz_update " select 
id,
kczt,
kdzt,
sptm,
zshm,
giazs,
wdmc,
ckmc,
gysbm,
gys,
ppmc,
dlmc,
jsmc,
plmc,
gckh,
gskh,
gg,
spmc,
splx,
xlmc,
jz,
hz,
jgf,
xsgf,
sxf,
zsys,
zsjd,
zsqg,
zssl,
zszl,
fsmc,
fssl,
fszl,
js,
sjcb,
sccb,
bzjg,
bqjg,
dw,
khh,
ykj,
jp,
gflx,
pjsm,
cfhh,
replace(replace(BZ,'\n',''),'\t','') bz,
rkrq,
rkdh,
rkdm,
gxrq,
gxdh,
pdzt,
pddh,
lsdh,
lsrq,
xsdj,
sjzk,
ml,
mjj,
lsje,
jsdh,
jsrq,
jsje,
khmc,
zsmc,
cxm,
ewm,
ewmx,
lbdm,
zscb,
fscb,
wxfy,
bzcb,
zsgg,
wxdm,
bqm from $database.t_ka_mxz_update where 1=1"
}
import_t_ka_spkcmxz(){
import_data t_ka_spkcmxz " select 
id,
WDBM,
wdmc,
ckbm,
ckmc,
ppbm,
ppmc,
dlbm,
dlmc,
jsbm,
jsmc,
plbm,
plmc,
js,
jz,
cb,
bj,
czzt from $database.t_ka_spkcmxz where 1=1"
}
import_t_ka_splsz(){
import_data t_ka_splsz " select 
id,
djm,
djh,
DATE_FORMAT(rq,'%Y-%m-%d') rq,
RKYY,
swlx,
KCLX,
WDBM,
wdmc,
CKBM,
ckmc,
jsmc,
plmc,
YJPL,
EJPL,
sffx,
js,
jz,
bqjg,
GJF,
YFJGF,
FJGF,
FJGFJE,
jgf,
jgfje,
JCGF,
JCGFJE,
dlcj,
dlcjje,
customer_identity,
parent_customer_identity,
RHF,
CHF,
replace(replace(BZ,'\n',''),'\t','') BZ,
BZGF,
ZL,
XSGF,
RHWDMC,
FKHSL,
GYLX,
ZQCE,
ZQCEXJ,
MZ,
czzt,
tech_purity_code,
tech_purity_name,
bzh from $database.t_ka_splsz where 1=1"
}
import_t_ka_splsz_20220720(){
import_data t_ka_splsz_20220720 " select 
id,
djm,
djh,
DATE_FORMAT(rq,'%Y-%m-%d') rq,
RKYY,
swlx,
KCLX,
WDBM,
wdmc,
CKBM,
ckmc,
jsmc,
plmc,
YJPL,
EJPL,
sffx,
js,
jz,
bqjg,
GJF,
YFJGF,
FJGF,
FJGFJE,
jgf,
jgfje,
JCGF,
JCGFJE,
dlcj,
dlcjje,
customer_identity,
parent_customer_identity,
RHF,
CHF,
replace(replace(BZ,'\n',''),'\t','') BZ,
BZGF,
ZL,
XSGF,
RHWDMC,
FKHSL,
GYLX,
ZQCE,
ZQCEXJ,
MZ,
czzt,
tech_purity_code,
tech_purity_name from $database.t_ka_splsz_20220720 where 1=1"
}
import_t_ka_splsz_bak202200728(){
import_data t_ka_splsz_bak202200728 " select 
id,
djm,
djh,
DATE_FORMAT(rq,'%Y-%m-%d') rq,
RKYY,
swlx,
KCLX,
WDBM,
wdmc,
CKBM,
ckmc,
jsmc,
plmc,
YJPL,
EJPL,
sffx,
js,
jz,
bqjg,
GJF,
YFJGF,
FJGF,
FJGFJE,
jgf,
jgfje,
JCGF,
JCGFJE,
dlcj,
dlcjje,
customer_identity,
parent_customer_identity,
RHF,
CHF,
replace(replace(BZ,'\n',''),'\t','') BZ,
BZGF,
ZL,
XSGF,
RHWDMC,
FKHSL,
GYLX,
ZQCE,
ZQCEXJ,
MZ,
czzt,
tech_purity_code,
tech_purity_name from $database.t_ka_splsz_bak202200728 where 1=1"
}
import_t_ka_splsz_bak202207(){
import_data t_ka_splsz_bak202207 " select 
id,
djm,
djh,
DATE_FORMAT(rq,'%Y-%m-%d') rq,
RKYY,
swlx,
KCLX,
WDBM,
wdmc,
CKBM,
ckmc,
jsmc,
plmc,
YJPL,
EJPL,
sffx,
js,
jz,
bqjg,
GJF,
YFJGF,
FJGF,
FJGFJE,
jgf,
jgfje,
JCGF,
JCGFJE,
dlcj,
dlcjje,
customer_identity,
parent_customer_identity,
RHF,
CHF,
replace(replace(BZ,'\n',''),'\t','') BZ,
BZGF,
ZL,
XSGF,
RHWDMC,
FKHSL,
GYLX,
ZQCE,
ZQCEXJ,
MZ,
czzt,
tech_purity_code,
tech_purity_name from $database.t_ka_splsz_bak202207 where 1=1"
}
import_t_ka_splsz_hw(){
import_data t_ka_splsz_hw " select 
id,
djm,
djh,
DATE_FORMAT(rq,'%Y-%m-%d') rq,
RKYY,
swlx,
KCLX,
WDBM,
wdmc,
CKBM,
ckmc,
jsmc,
plmc,
YJPL,
EJPL,
sffx,
js,
jz,
bqjg,
GJF,
YFJGF,
FJGF,
FJGFJE,
jgf,
jgfje,
JCGF,
JCGFJE,
dlcj,
dlcjje,
customer_identity,
parent_customer_identity,
RHF,
CHF,
replace(replace(BZ,'\n',''),'\t','') BZ,
BZGF,
ZL,
XSGF,
RHWDMC,
FKHSL,
GYLX,
ZQCE,
ZQCEXJ,
MZ,
czzt,
tech_purity_code,
tech_purity_name from $database.t_ka_splsz_hw where 1=1"
}
import_t_ka_szdzsqdh(){
import_data t_ka_szdzsqdh " select 
id,
djlsh,
djh,
wdmc,
khmc,
khbm,
zkh,
zdr,
DATE_FORMAT(zdsj,'%Y-%m-%d %H:%i:%s') zdsj,
zdrid,
cwjsrq,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
replace(replace(BZ,'\n',''),'\t','') bz,
dzbjje,
dzgfje,
dzjlzl,
tzlxje,
drkhmc,
drkhbm,
drzkhmc,
cwkhbm,
cwkhmc,
glkhmc,
khqkbj,
khgfye,
khlx,
khqlzl,
khqkbj1,
khgfye1,
khlx1,
khqlzl1,
cwqrtzbj,
cwqrtzgf,
cwqrtzlx,
cwqrtzlz,
ywjlqr,
DATE_FORMAT(sj1,'%Y-%m-%d %H:%i:%s') sj1,
fgldqr,
DATE_FORMAT(sj2,'%Y-%m-%d %H:%i:%s') sj2,
zjlpf,
DATE_FORMAT(sj3,'%Y-%m-%d %H:%i:%s') sj3,
cwqr,
DATE_FORMAT(sj4,'%Y-%m-%d %H:%i:%s') sj4,
dszfh,
DATE_FORMAT(sj5,'%Y-%m-%d %H:%i:%s') sj5,
DATE_FORMAT(cwshsj,'%Y-%m-%d %H:%i:%s') cwshsj,
DATE_FORMAT(zjlpfrq,'%Y-%m-%d %H:%i:%s') zjlpfrq,
sfdy,
dysj,
cwecqr,
cwecqrsj,
out_tech_purity_name,
out_tech_purity_code,
in_tech_purity_name,
in_tech_purity_code from $database.t_ka_szdzsqdh where 1=1"
}
import_t_ka_szdzsqdh_temp(){
import_data t_ka_szdzsqdh_temp " select 
id,
djlsh,
djh,
wdmc,
khmc,
khbm,
zkh,
zdr,
DATE_FORMAT(zdsj,'%Y-%m-%d %H:%i:%s') zdsj,
zdrid,
DATE_FORMAT(cwjsrq,'%Y-%m-%d %H:%i:%s') cwjsrq,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
replace(replace(BZ,'\n',''),'\t','') bz,
dzbjje,
dzgfje,
dzjlzl,
tzlxje,
drkhmc,
drkhbm,
drzkhmc,
cwkhbm,
cwkhmc,
glkhmc,
khqkbj,
khgfye,
khlx,
khqlzl,
khqkbj1,
khgfye1,
khlx1,
khqlzl1,
cwqrtzbj,
cwqrtzgf,
cwqrtzlx,
cwqrtzlz,
ywjlqr,
DATE_FORMAT(sj1,'%Y-%m-%d %H:%i:%s') sj1,
fgldqr,
DATE_FORMAT(sj2,'%Y-%m-%d %H:%i:%s') sj2,
zjlpf,
DATE_FORMAT(sj3,'%Y-%m-%d %H:%i:%s') sj3,
cwqr,
DATE_FORMAT(sj4,'%Y-%m-%d %H:%i:%s') sj4,
dszfh,
DATE_FORMAT(sj5,'%Y-%m-%d %H:%i:%s') sj5,
DATE_FORMAT(cwshsj,'%Y-%m-%d %H:%i:%s') cwshsj,
DATE_FORMAT(zjlpfrq,'%Y-%m-%d %H:%i:%s') zjlpfrq,
sfdy,
dysj,
cwecqr,
cwecqrsj,
out_tech_purity_name,
out_tech_purity_code,
in_tech_purity_name,
in_tech_purity_code from $database.t_ka_szdzsqdh_temp where 1=1"
}
import_t_ka_szkhcqlxzz_b(){
import_data t_ka_szkhcqlxzz_b " select 
szkhcqlxzz_h_identity,
szkhcqlxzz_b_identity,
djbth,
lxb,
pl,
fsrq,
je,
dj,
zq,
btlx,
dygf,
sygf,
ccjq,
jxxh,
kqqk from $database.t_ka_szkhcqlxzz_b where 1=1"
}
import_t_ka_szkhcqlxzz_b_history(){
import_data t_ka_szkhcqlxzz_b_history " select 
data_date,
szkhcqlxzz_h_identity,
szkhcqlxzz_b_identity,
djbth,
lxb,
pl,
fsrq,
je,
dj,
zq,
btlx,
dygf,
sygf,
ccjq,
jxxh,
kqqk from $database.t_ka_szkhcqlxzz_b_history where 1=1"
}
import_t_ka_szkhcqlxzz_f(){
import_data t_ka_szkhcqlxzz_f " select 
szkhcqlxzz_h_identity,
szkhcqlxzz_f_identity,
swlx,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
xmje,
yjsjd from $database.t_ka_szkhcqlxzz_f where 1=1"
}
import_t_ka_szkhcqlxzz_f_history(){
import_data t_ka_szkhcqlxzz_f_history " select 
data_date,
szkhcqlxzz_h_identity,
szkhcqlxzz_f_identity,
swlx,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
xmje,
yjsjd from $database.t_ka_szkhcqlxzz_f_history where 1=1"
}
import_t_ka_szkhcqlxzz_h(){
import_data t_ka_szkhcqlxzz_h " select 
id,
szkhcqlxzz_h_identity,
djbtzdh,
wdmc,
wdbm,
customer_identity,
khbm,
khmc,
zkh,
purity_name,
zjm,
khlx,
mxts,
ll,
YDQJE,
WDQJE,
qlzl,
qldj,
lx,
drlx,
drccf,
dygfh,
sygfh,
wdqqlzl,
wdqqldj,
ccf,
ccfqx,
wyid,
DRHKYE,
drhlye,
BTHKYE,
bthlye,
xlhz,
htr,
edxl,
mxjz,
qzjxl,
wzjxl,
qzjjj,
ckjx,
yjd,
htydq,
ccjz,
yjyq,
htysjcd,
sywjlx,
xkh,
sylx,
sylxcl,
wdqjepd,
ccmxjz,
sygflx,
deccf,
yccjz,
syql,
syzqk,
khzl from $database.t_ka_szkhcqlxzz_h where 1=1"
}
import_t_ka_szkhcqlxzz_h_20220727(){
import_data t_ka_szkhcqlxzz_h_20220727 " select 
id,
szkhcqlxzz_h_identity,
djbtzdh,
wdmc,
wdbm,
customer_identity,
khbm,
khmc,
zkh,
purity_name,
zjm,
khlx,
mxts,
ll,
YDQJE,
WDQJE,
qlzl,
qldj,
lx,
drlx,
drccf,
dygfh,
sygfh,
wdqqlzl,
wdqqldj,
ccf,
ccfqx,
wyid,
DRHKYE,
drhlye,
BTHKYE,
bthlye,
xlhz,
htr,
edxl,
mxjz,
qzjxl,
wzjxl,
qzjjj,
ckjx,
yjd,
htydq,
ccjz,
yjyq,
htysjcd,
sywjlx,
xkh,
sylx,
sylxcl,
wdqjepd,
ccmxjz,
sygflx,
deccf,
yccjz,
syql,
syzqk,
khzl from $database.t_ka_szkhcqlxzz_h_20220727 where 1=1"
}
import_t_ka_szkhcqlxzz_h_history(){
import_data t_ka_szkhcqlxzz_h_history " select 
DATE_FORMAT(data_date,'%Y-%m-%d %H:%i:%s') data_date,
id,
szkhcqlxzz_h_identity,
djbtzdh,
wdmc,
wdbm,
customer_identity,
khbm,
khmc,
zkh,
purity_name,
zjm,
khlx,
mxts,
ll,
YDQJE,
WDQJE,
qlzl,
qldj,
lx,
drlx,
drccf,
dygfh,
sygfh,
wdqqlzl,
wdqqldj,
ccf,
ccfqx,
wyid,
DRHKYE,
drhlye,
BTHKYE,
bthlye,
xlhz,
htr,
edxl,
mxjz,
qzjxl,
wzjxl,
qzjjj,
ckjx,
yjd,
htydq,
ccjz,
yjyq,
htysjcd,
sywjlx,
xkh,
sylx,
sylxcl,
wdqjepd,
ccmxjz,
sygflx,
deccf,
yccjz,
syql,
syzqk,
khzl from $database.t_ka_szkhcqlxzz_h_history where 1=1"
}
import_t_ka_szkhcqlxzzfb_h(){
import_data t_ka_szkhcqlxzzfb_h " select 
id,
szkhcqlxzz_h_identity,
djbtzdh,
wdmc,
wdbm,
customer_identity,
khbm,
khmc,
zkh,
purity_name,
zjm,
khlx,
mxts,
ll,
YDQJE,
WDQJE,
qlzl,
qldj,
lx,
drlx,
drccf,
dygfh,
sygfh,
wdqqlzl,
wdqqldj,
ccf,
ccfqx,
wyid,
DRHKYE,
drhlye,
BTHKYE,
bthlye,
xlhz,
htr,
edxl,
mxjz,
qzjxl,
wzjxl,
qzjjj,
ckjx,
yjd,
htydq,
ccjz,
yjyq,
htysjcd,
sywjlx,
xkh,
sylx,
sylxcl,
wdqjepd,
ccmxjz,
sygflx,
deccf,
yccjz,
syql,
syzqk,
khzl from $database.t_ka_szkhcqlxzzfb_h where 1=1"
}
import_t_ka_szkhcqmx_b(){
import_data t_ka_szkhcqmx_b " select 
szkhcqmx_h_identity,
szkhcqmx_b_identity,
djlsh,
djbth,
djstate,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
zl,
je,
lxb,
ze,
ts,
zlqj,
scbs,
DATE_FORMAT(zxrqb,'%Y-%m-%d %H:%i:%s') zxrqb from $database.t_ka_szkhcqmx_b where 1=1"
}
import_t_ka_szkhcqmx_b_2022081918(){
import_data t_ka_szkhcqmx_b_2022081918 " select 
szkhcqmx_h_identity,
szkhcqmx_b_identity,
djlsh,
djbth,
djstate,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
zl,
je,
lxb,
ze,
ts,
zlqj,
scbs,
DATE_FORMAT(zxrqb,'%Y-%m-%d %H:%i:%s') zxrqb from $database.t_ka_szkhcqmx_b_2022081918 where 1=1"
}
import_t_ka_szkhcqmx_f(){
import_data t_ka_szkhcqmx_f " select 
djlsh,
szkhcqmx_h_identity,
szkhcqmx_f_identity,
djfth,
djstate,
DATE_FORMAT(rqf,'%Y-%m-%d %H:%i:%s') rqf,
zlf,
jef,
lxf,
zef,
tsf,
zlqjf,
scbsf,
DATE_FORMAT(zxrq,'%Y-%m-%d %H:%i:%s') zxrq from $database.t_ka_szkhcqmx_f where 1=1"
}
import_t_ka_szkhcqmx_f_2022081918(){
import_data t_ka_szkhcqmx_f_2022081918 " select 
djlsh,
szkhcqmx_h_identity,
szkhcqmx_f_identity,
djfth,
djstate,
DATE_FORMAT(rqf,'%Y-%m-%d %H:%i:%s') rqf ,
zlf,
jef,
lxf,
zef,
tsf,
zlqjf,
scbsf,
DATE_FORMAT(zxrq,'%Y-%m-%d %H:%i:%s')  zxrq from $database.t_ka_szkhcqmx_f_2022081918 where 1=1"
}
import_t_ka_szkhcqmx_h(){
import_data t_ka_szkhcqmx_h " select 
szkhcqmx_h_identity,
djlsh,
djbtzdh,
djftzdh,
djstzdh,
djstate,
djcount,
wdbm,
wdmc,
khbm,
khmc,
zkhbh,
zkhmc,
qkje,
qlzl,
qlje,
lx,
jj,
cqze,
zcqkts,
khbs,
khlx,
ycbs,
customer_identity,
purity_name from $database.t_ka_szkhcqmx_h where 1=1"
}
import_t_ka_szkhcqmx_h_2022081918(){
import_data t_ka_szkhcqmx_h_2022081918 " select 
szkhcqmx_h_identity,
djlsh,
djbtzdh,
djftzdh,
djstzdh,
djstate,
djcount,
wdbm,
wdmc,
khbm,
khmc,
zkhbh,
zkhmc,
qkje,
qlzl,
qlje,
lx,
jj,
cqze,
zcqkts,
khbs,
khlx,
ycbs,
customer_identity,
purity_name from $database.t_ka_szkhcqmx_h_2022081918 where 1=1"
}
import_t_ka_szlxjsrq(){
import_data t_ka_szlxjsrq " select 
szlxjsrq_identity,
DATE_FORMAT(jsrq,'%Y-%m-%d %H:%i:%s')  jsrq from $database.t_ka_szlxjsrq where 1=1"
}
import_t_ka_xltj_b(){
import_data t_ka_xltj_b " select 
id,
identity,
djh,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s')   rq,
csmc,
xszl,
jjzl,
jjje,
czzt from $database.t_ka_xltj_b where 1=1"
}
import_t_ka_xltj_h(){
import_data t_ka_xltj_h " select 
id,
identity,
wdmc,
customer_identity,
parent_customer_identity from $database.t_ka_xltj_h where 1=1"
}
import_t_ka_yfllsz(){
import_data t_ka_yfllsz " select 
id,
DATE_FORMAT(rqf,'%Y-%m-%d') rq,
djm,
DJH,
SWLX,
customer_identity,
parent_customer_identity,
SFFX,
JZ,
wdbm,
wdmc,
khlx,
czzt,
CSBM,
CSMC,
plbm,
plmc,
CKBM,
ckmc,
hl,
llsm,
tech_purity_name,
tech_purity_code from $database.t_ka_yfllsz where 1=1"
}
import_t_ka_yflmxz(){
import_data t_ka_yflmxz " select 
id,
WDMC,
khbm,
customer_identity,
parent_customer_identity,
lxr,
CSBM,
CSMC,
plbm,
plmc,
JZ,
khlx,
czzt from $database.t_ka_yflmxz where 1=1"
}
import_t_ka_yflsz(){
import_data t_ka_yflsz " select 
id,
DATE_FORMAT(rq,'%Y-%m-%d') RQ,
djm,
DJH,
SWLX,
customer_identity,
parent_customer_identity,
SFFX,
JZ,
Je,
bb,
WDBM,
wdmc,
lb,
khlx,
czzt,
tech_purity_name,
tech_purity_code from $database.t_ka_yflsz where 1=1"
}
import_t_ka_yfmxz(){
import_data t_ka_yfmxz " select 
id,
wdmc,
customer_identity,
parent_customer_identity,
lb,
je,
bb,
khlx from $database.t_ka_yfmxz where 1=1"
}
import_t_ka_yfrzzh(){
import_data t_ka_yfrzzh " select 
id,
yfrzz_identity,
nian,
yue,
ri,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
wdmc,
zjm,
customer_identity,
khbm,
khmc,
qcje,
qcjz,
zjje,
zjjz,
jsje,
jsjz,
jcje,
jcjz from $database.t_ka_yfrzzh where 1=1"
}
import_t_ka_yfrzzh_bak20220729(){
import_data t_ka_yfrzzh_bak20220729 " select 
id,
yfrzz_identity,
nian,
yue,
ri,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
wdmc,
zjm,
customer_identity,
khbm,
khmc,
qcje,
qcjz,
zjje,
zjjz,
jsje,
jsjz,
jcje,
jcjz from $database.t_ka_yfrzzh_bak20220729 where 1=1"
}
import_t_ka_yfrzzh_bak20220815(){
import_data t_ka_yfrzzh_bak20220815 " select 
id,
yfrzz_identity,
nian,
yue,
ri,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
wdmc,
zjm,
customer_identity,
khbm,
khmc,
qcje,
qcjz,
zjje,
zjjz,
jsje,
jsjz,
jcje,
jcjz from $database.t_ka_yfrzzh_bak20220815 where 1=1"
}
import_t_ka_yfrzzh_hw(){
import_data t_ka_yfrzzh_hw " select 
id,
yfrzz_identity,
nian,
yue,
ri,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
wdmc,
zjm,
customer_identity,
khbm,
khmc,
qcje,
qcjz,
zjje,
zjjz,
jsje,
jsjz,
jcje,
jcjz from $database.t_ka_yfrzzh_hw where 1=1"
}
import_t_ka_yhrq(){
import_data t_ka_yhrq " select 
id,
yhrq_identity,
showroom_name,
DATE_FORMAT(rq,'%Y-%m-%d') rq from $database.t_ka_yhrq where 1=1"
}
import_t_ka_yslsz(){
import_data t_ka_yslsz " select 
id,
yslsz_identity,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
djm,
djh,
swlx,
sffx,
je,
bb,
wdbm,
wdmc,
lb,
replace(replace(BZ,'\n',''),'\t','') bz,
gylx,
customer_identity,
parent_customer_identity,
czzt,
khlx from $database.t_ka_yslsz where 1=1"
}
import_t_ka_ysmxz_b(){
import_data t_ka_ysmxz_b " select 
id,
ysmxz_h_identity,
ysmxz_b_identity,
djm,
djh,
settlement_type,
djje,
wfje,
yfje,
replace(replace(BZ,'\n',''),'\t','') bz,
DATE_FORMAT(zhskrq,'%Y-%m-%d %H:%i:%s')  zhskrq,
csbm,
csmc,
plbm,
plmc,
dcwdmc,
fs,
jjje,
gfje,
hkshrq,
ybf,
hkjsfs,
gylx,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
czzt from $database.t_ka_ysmxz_b where 1=1"
}
import_t_ka_ysmxz_h(){
import_data t_ka_ysmxz_h " select 
id,
ysmxz_h_identity,
customer_identity,
parent_customer_identity,
wdbm,
wdmc,
lb,
je,
bb,
zjm,
yjkh,
khlx,
tech_purity_name,
tech_purity_code from $database.t_ka_ysmxz_h where 1=1"
}
import_t_ka_ysmxz_s(){
import_data t_ka_ysmxz_s " select 
id,
ysmxz_h_identity,
ysmxz_b_identity,
ysmxz_s_identity,
DATE_FORMAT(hxdjrq,'%Y-%m-%d %H:%i:%s') hxdjrq,
hxdh,
hxdm,
hxje,
sm,
DATE_FORMAT(hxczrq,'%Y-%m-%d %H:%i:%s') hxczrq,
hxczdh,
drwdmc from $database.t_ka_ysmxz_s where 1=1"
}
import_t_ka_ysmxz_sold(){
import_data t_ka_ysmxz_sold " select 
id,
ysmxz_sold_identity,
sptm,
zshm,
giazs,
wdmc,
ckmc,
gysbm,
gys,
ppmc,
dlmc,
jsmc,
plmc,
gckh,
gskh,
gg,
spmc,
splx,
xlmc,
jz,
hz,
jgf,
xsgf,
sxf,
zsys,
zsjd,
zsqg,
zssl,
zszl,
fsmc,
fssl,
fszl,
js,
sjcb,
sccb,
bzjg,
bqjg,
dw,
khh,
ykj,
jp,
gflx,
pjsm,
cfhh,
replace(replace(BZ,'\n',''),'\t','') bz,
rkrq,
rkdh,
rkdm,
gxrq,
gxdh,
pdzt,
pddh,
lsdh,
lsrq,
xsdj,
sjzk,
ZKJE,
ml,
mjj,
lsje,
jsdh,
DATE_FORMAT(jsrq,'%Y-%m-%d %H:%i:%s') jsrq,
jsje,
customer_identity,
khbm,
khmc,
ZSMC,
CXM,
EWM,
JJ,
CSMC from $database.t_ka_ysmxz_sold where 1=1"
}
import_t_ka_zjlsz(){
import_data t_ka_zjlsz " select 
id,
DATE_FORMAT(rq,'%Y-%m-%d') rq,
djm,
djh,
swlx,
gsmc,
je,
sffx,
zh,
fssj,
fsje,
zjlx,
yh,
yhzh,
zcwd,
replace(replace(BZ,'\n',''),'\t','') bz,
czzt,
customer_identity,
parent_customer_identity from $database.t_ka_zjlsz where 1=1"
}
import_t_ka_zjyez(){
import_data t_ka_zjyez " select 
id,
gsmc,
zh,
je,
zjlx,
yh,
yhzh,
czzt,
customer_identity,
parent_customer_identity from $database.t_ka_zjyez where 1=1"
}
import_t_ka_zrye(){
import_data t_ka_zrye " select 
zrye_identity,
dh,
je,
jz,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
wdmc,
lx from $database.t_ka_zrye where 1=1"
}
import_t_ka_zrye_alter(){
import_data t_ka_zrye_alter " select 
dh,
original_amount,
alter_amount,
operator,
DATE_FORMAT(operation_time,'%Y-%m-%d %H:%i:%s') operation_time from $database.t_ka_zrye_alter where 1=1"
}
import_t_ka_ztkcrzz(){
import_data t_ka_ztkcrzz " select 
id,
ztkcrzz_identity,
nian,
yue,
ri,
DATE_FORMAT(rq,'%Y-%m-%d') rq,
wdmc,
ckmc,
jsmc,
plmc,
qcjs,
qcjz,
qcje,
qmjs,
qmjz,
qmje,
rkjs,
rkjz,
rkje,
ckjs,
ckjz,
ckje,
ykjs,
ykjz,
ykje from $database.t_ka_ztkcrzz where 1=1"
}
import_t_ka_ztkcrzz_2022083018(){
import_data t_ka_ztkcrzz_2022083018 " select 
id,
ztkcrzz_identity,
nian,
yue,
ri,
DATE_FORMAT(rq,'%Y-%m-%d')  rq,
wdmc,
ckmc,
jsmc,
plmc,
qcjs,
qcjz,
qcje,
qmjs,
qmjz,
qmje,
rkjs,
rkjz,
rkje,
ckjs,
ckjz,
ckje,
ykjs,
ykjz,
ykje from $database.t_ka_ztkcrzz_2022083018 where 1=1"
}
import_t_ka_ztkcrzz_2022083111(){
import_data t_ka_ztkcrzz_2022083111 " select 
id,
ztkcrzz_identity,
nian,
yue,
ri,
DATE_FORMAT(rq,'%Y-%m-%d') rq,
wdmc,
ckmc,
jsmc,
plmc,
qcjs,
qcjz,
qcje,
qmjs,
qmjz,
qmje,
rkjs,
rkjz,
rkje,
ckjs,
ckjz,
ckje,
ykjs,
ykjz,
ykje from $database.t_ka_ztkcrzz_2022083111 where 1=1"
}
import_t_ka_ztkcrzz_2022083115(){
import_data t_ka_ztkcrzz_2022083115 " select 
id,
ztkcrzz_identity,
nian,
yue,
ri,
DATE_FORMAT(rq,'%Y-%m-%d') rq,
wdmc,
ckmc,
jsmc,
plmc,
qcjs,
qcjz,
qcje,
qmjs,
qmjz,
qmje,
rkjs,
rkjz,
rkje,
ckjs,
ckjz,
ckje,
ykjs,
ykjz,
ykje from $database.t_ka_ztkcrzz_2022083115 where 1=1"
}
import_t_ka_ztkcrzz_2022090111(){
import_data t_ka_ztkcrzz_2022090111 " select 
id,
ztkcrzz_identity,
nian,
yue,
ri,
DATE_FORMAT(rq,'%Y-%m-%d') rq,
wdmc,
ckmc,
jsmc,
plmc,
qcjs,
qcjz,
qcje,
qmjs,
qmjz,
qmje,
rkjs,
rkjz,
rkje,
ckjs,
ckjz,
ckje,
ykjs,
ykjz,
ykje from $database.t_ka_ztkcrzz_2022090111 where 1=1"
}
import_t_ka_ztkczz(){
import_data t_ka_ztkczz " select 
id,
ztkczz_identity,
nian,
yue,
wdmc,
ckmc,
jsmc,
plmc,
qcjs,
qcjz,
qcje,
qmjs,
qmjz,
qmje from $database.t_ka_ztkczz where 1=1"
}
import_t_ka_ztkczz_2022083115(){
import_data t_ka_ztkczz_2022083115 " select 
id,
ztkczz_identity,
nian,
yue,
wdmc,
ckmc,
jsmc,
plmc,
qcjs,
qcjz,
qcje,
qmjs,
qmjz,
qmje from $database.t_ka_ztkczz_2022083115 where 1=1"
}
import_t_ka_ztkczz_2022090111(){
import_data t_ka_ztkczz_2022090111 " select 
id,
ztkczz_identity,
nian,
yue,
wdmc,
ckmc,
jsmc,
plmc,
qcjs,
qcjz,
qcje,
qmjs,
qmjz,
qmje from $database.t_ka_ztkczz_2022090111 where 1=1"
}
import_t_khxxszb(){
import_data t_khxxszb " select 
DjLsh,
DjBth,
DjState,
xh,
khwd,
lxr,
lxdh,
lxdz,
zjme,
LXDHB,
SFQY,
KHBH,
FRB,
FRSFZB,
YYZZHMB,
YYFWB,
SSSF,
JDRQ,
PQMCB,
KHLXB,
WXHB,
SQTHRB,
SQTHRXBB,
THRSFZHB,
THRSJHMB,
DPZZQCB,
DJSXXB,
SXJXXB,
FRSJHB,
QYXZB,
KHLXNB,
PPMCB,
BZB,
YYZZYXQB,
DKWTRB,
DKWTRYXKHB,
DKWTRB2,
DKWTRYXHMB2,
DKWTRYXKHB2,
DKWTRZXB,
DKWTRFXB,
DKWTRYXB,
DKWTRYXB2,
DKWTRFXB2,
DKWTRZXB2,
DKWTRYXHMB,
SQYXQB,
SQYXQB2,
SQYXQZFB,
SQYXQZFB2,
DGDS,
YWGSDB,
data_date from $database.t_khxxszb where 1=1"
}
import_t_khxxszb_sync(){
import_data t_khxxszb_sync " select 
DjLsh,
DjBth,
DjState,
xh,
khwd,
lxr,
lxdh,
lxdz,
zjme,
LXDHB,
SFQY,
KHBH,
FRB,
FRSFZB,
YYZZHMB,
YYFWB,
SSSF,
JDRQ,
PQMCB,
KHLXB,
WXHB,
SQTHRB,
SQTHRXBB,
THRSFZHB,
THRSJHMB,
DPZZQCB,
DJSXXB,
SXJXXB,
FRSJHB,
QYXZB,
KHLXNB,
PPMCB,
BZB,
YYZZYXQB,
DKWTRB,
DKWTRYXKHB,
DKWTRB2,
DKWTRYXHMB2,
DKWTRYXKHB2,
DKWTRZXB,
DKWTRFXB,
DKWTRYXB,
DKWTRYXB2,
DKWTRFXB2,
DKWTRZXB2,
DKWTRYXHMB,
SQYXQB,
SQYXQB2,
SQYXQZFB,
SQYXQZFB2,
DGDS,
YWGSDB,
data_date from $database.t_khxxszb_sync where 1=1"
}
import_t_khxxszh(){
import_data t_khxxszh " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
SRFS,
CSMC,
qy,
kmbm,
khbm,
khmc,
khjc,
khyh,
yhzh,
sh,
dwdz,
dwdh,
cz,
gszy,
zjm,
fr,
frsfzh,
zw,
sjhm,
bgdh,
dzyj,
lrrid,
lrrxm,
lrsj,
zhwhr,
zhwhsj,
zxhjsxs,
zxhxsxs,
xydj,
xyed,
xysm,
fkqx,
jjqx,
jszk,
wdmc,
gsmc,
sjxqbm,
sjxqmc,
djsbm,
djsxx,
sxqbm,
sxqxx,
replace(replace(BZ,'\n',''),'\t','') bz,
pqbm,
pqmc,
gfyh,
kh,
gys,
SD,
rll,
ywy,
lxhm,
XXDZ,
DHHM,
LXRH,
WZJMS,
KHKH,
HTKSSJ,
HTJZSJ,
JMF,
PPSYF,
BZJ,
SYZKH,
SJHM1,
DPZZQC,
KHQKM,
CSKHLX,
WYID,
YYZZHM,
YYFW,
YYZZYXQ,
XB,
WXH,
QYXZ,
GSZCZJ,
NXSE,
TJR,
GLZZH,
CGFZR,
CGRZJH,
CGRSJHM,
CGRXB,
CGRZW,
SQTHR,
THRSFZH,
THRSJHM,
THRXB,
THRZW,
SQSYXQ,
ZDJHDZ,
TSJNR,
XQAH,
KHLX,
PPLX,
LXBM,
PPBM,
KHLXH,
YWGSD,
DKWTRYXHM,
DKWTRYXKH,
DKWTRYXHM2,
DKWTRYXKH2,
DKWTRYX,
DKWTRFX,
DKWTRZX,
DKWTRYX2,
DKWTRFX2,
DKWTRZX2,
DG,
DKWTR,
DKWTR2,
DS,
SQYXQ,
SQYXQZF,
SQYXQ2,
SQYXQZF2,
data_date from $database.t_khxxszh where 1=1"
}
import_t_khxxszh_sync(){
import_data t_khxxszh_sync " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
SRFS,
CSMC,
qy,
kmbm,
khbm,
khmc,
khjc,
khyh,
yhzh,
sh,
dwdz,
dwdh,
cz,
gszy,
zjm,
fr,
frsfzh,
zw,
sjhm,
bgdh,
dzyj,
lrrid,
lrrxm,
lrsj,
zhwhr,
zhwhsj,
zxhjsxs,
zxhxsxs,
xydj,
xyed,
xysm,
fkqx,
jjqx,
jszk,
wdmc,
gsmc,
sjxqbm,
sjxqmc,
djsbm,
djsxx,
sxqbm,
sxqxx,
replace(replace(BZ,'\n',''),'\t','') bz,
pqbm,
pqmc,
gfyh,
kh,
gys,
SD,
rll,
ywy,
lxhm,
XXDZ,
DHHM,
LXRH,
WZJMS,
KHKH,
HTKSSJ,
HTJZSJ,
JMF,
PPSYF,
BZJ,
SYZKH,
SJHM1,
DPZZQC,
KHQKM,
CSKHLX,
WYID,
YYZZHM,
YYFW,
YYZZYXQ,
XB,
WXH,
QYXZ,
GSZCZJ,
NXSE,
TJR,
GLZZH,
CGFZR,
CGRZJH,
CGRSJHM,
CGRXB,
CGRZW,
SQTHR,
THRSFZH,
THRSJHM,
THRXB,
THRZW,
SQSYXQ,
ZDJHDZ,
TSJNR,
XQAH,
KHLX,
PPLX,
LXBM,
PPBM,
KHLXH,
YWGSD,
DKWTRYXHM,
DKWTRYXKH,
DKWTRYXHM2,
DKWTRYXKH2,
DKWTRYX,
DKWTRFX,
DKWTRZX,
DKWTRYX2,
DKWTRFX2,
DKWTRZX2,
DG,
DKWTR,
DKWTR2,
DS,
SQYXQ,
SQYXQZF,
SQYXQ2,
SQYXQZF2,
data_date from $database.t_khxxszh_sync where 1=1"
}
import_t_kj_child_customer(){
import_data t_kj_child_customer " select 
id,
customer_identity,
child_customer_identity,
djlsh,
djbth,
child_customer_code,
child_customer_seq,
customer_name,
mobile_phone,
mobile_phone1,
contact_man,
active_flag,
ty_customer_code,
purity_name,
contact_address,
help_code2,
balance_rate_b,
mosaic_discount_b,
province,
create_date,
area_name_b,
city_code_b,
country_code_b,
legal_person_tel_b,
company_nature_b,
customer_type_nb,
brand_name_b,
license_time_b,
of_area_b,
authorize_payer_b,
payer_bank_count_b,
payer_credit_card_b,
payer_bank_name_b,
payer_bank_branch_b,
payer_bank_sub_branch_b,
authorize_active_date_b,
authorize_active_str_b,
authorize_payer_b2,
payer_bank_count_b2,
payer_credit_card_b2,
payer_bank_name_b2,
payer_bank_branch_b2,
payer_bank_sub_branch_b2,
authorize_active_date_b2,
authorize_active_str_b2,
offical_or_personal from $database.t_kj_child_customer where 1=1"
}
import_t_kj_customer(){
import_data t_kj_customer " select 
id,
customer_identity,
djlsh,
customer_code,
customer_name,
office_phone,
phone_no,
mobile_phone,
mobile_phone1,
active_flag,
ty_customer_code,
purity_name,
customer_classification,
input_type,
subject_code,
customer_short_name,
bank_name,
bank_account,
tax_amount,
address,
fax_no,
web_url,
help_code,
legal_person,
id_code,
position,
email,
create_user_code,
create_user_ame,
create_date,
modify_user_code,
modify_user_name,
show_balance_rate,
show_sale_rate,
credit_level,
credit_quato,
credit_desc,
pay_time_limit,
price_pay_limit,
balance_rate,
branch_name,
company_name,
province,
province_code,
city,
city_code,
county,
county_desc,
town,
town_desc,
memo,
area_code,
area_name,
labour_discount,
is_customer,
is_supplier,
is_provincial,
day_interest_rate,
salesman_name,
salesman_phone,
address_detail,
contact_no,
contact_name,
is_five,
customer_card_code,
contract_begin_date,
contract_end_date,
alliance_amount,
brand_amount,
deposit_amount,
is_child,
license_desc,
customer_debt_name,
test_customer_type,
uniq_id,
mosaic_discount,
is_diamond,
is_kgold,
is_platinum,
class_code,
class_level,
level_name,
diamond_effect_time,
customer_type,
of_area,
legal_person_tel,
frequent_contacts_position,
frequent_contacts_wechat,
delivery_name,
delivery_id_code,
delivery_mobile_no,
authorization_date,
company_nature,
registered_capital,
license_code,
license_range,
brand_type,
license_approve_time,
license_approve_time_char,
new_customer_type,
authorize_payer,
payer_bank_count,
payer_credit_card,
payer_bank_name,
payer_bank_branch,
payer_bank_sub_branch,
authorize_active_date,
authorize_active_str,
authorize_payerb,
payerb_bank_count,
payerb_credit_card,
payerb_bank_name,
payerb_bank_branch,
payerb_bank_sub_branch,
authorize_active_dateb,
authorize_active_strb,
is_official,
is_personal,
second_responsible_person from $database.t_kj_customer where 1=1"
}
import_t_kj_khxxb(){
import_data t_kj_khxxb " select 
djlsh,
djBth,
khbh,
xh,
khwd,
lxdh,
lxdhb,
sfqy,
lxr,
lxdz,
zjme,
jszkb,
xqzkb,
sssf,
jdrq,
pqmcb,
djsxxb,
sxjxxb,
frsjhb,
qyxzb,
khlxnb,
ppmcb,
yyzzyxqb,
ywgsdb,
dkwtrb,
dkwtryxhmb,
dkwtryxkhb,
dkwtryxb,
dkwtrfxb,
dkwtrzxb,
sqyxqb,
sqyxqzfb,
dkwtrb2,
dkwtryxhmb2,
dkwtryxkhb2,
dkwtryxb2,
dkwtrfxb2,
dkwtrzxb2,
sqyxqb2,
sqyxqzfb2,
dgds from $database.t_kj_khxxb where 1=1"
}
import_t_kj_khxxh(){
import_data t_kj_khxxh " select 
djlsh,
khbm,
khmc,
bgdh,
dhhm,
sjhm,
sjhm1,
qy,
khlb,
srfs,
kmbm,
khjc,
khyh,
yhzh,
sh,
dwdh,
dwdz,
cz,
gszy,
zjm,
fr,
frsfzh,
zw,
dzyj,
lrrid,
lrrxm,
lrsj,
zhwhr,
zhwhsj,
zxhjsxs,
zxhxsxs,
xydj,
xyed,
xysm,
fkqx,
jjqx,
jszk,
wdmc,
gsmc,
sjxqbm,
sjxqmc,
djsbm,
djsxx,
sxqbm,
sxqxx,
xzbm,
xzxx,
replace(replace(BZ,'\n',''),'\t','') bz,
pqbm,
pqmc,
gfyh,
kh,
gys,
sd,
rll,
ywy,
lxhm,
xxdz,
lxrh,
wzjms,
khkh,
htkssj,
htjzsj,
jmf,
ppsyf,
bzj,
syzkh,
dpzzqc,
khqkm,
cskhlx,
wyid,
xqzk,
zs,
kj,
bj,
lbbm,
dcdj,
dcmc,
zsqyrq,
khlx,
ywgsd,
frsjh,
cylxrzw,
cylxrwxh,
thsqr,
thrsfz,
thrsjh,
sqsyxq,
qyxz,
gszczj,
yyzzh,
yyfw,
pplx,
yyzzhzrq,
yyzzhzrqzf,
xkhlx,
dkwtr,
dkwtryxhm,
dkwtryxkh,
dkwtryx,
dkwtrfx,
dkwtrzx,
sqyxq,
sqyxqzf,
dkwtr2,
dkwtryxhm2,
dkwtryxkh2,
dkwtryx2,
dkwtrfx2,
dkwtrzx2,
sqyxq2,
sqyxqzf2,
dg,
ds,
ejfzr from $database.t_kj_khxxh where 1=1"
}
import_t_late_transfer_log(){
import_data t_late_transfer_log " select 
id,
customer_code,
customer_identity,
customer_name,
package_all,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
recept_by from $database.t_late_transfer_log where 1=1"
}
import_t_login_log(){
import_data t_login_log " select 
id,
buyer_id,
buyer_identity,
customer_id,
customer_identity,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
showroom_identity from $database.t_login_log where 1=1"
}
import_t_main_item(){
import_data t_main_item " select 
id,
item_identity,
seq_no,
item_no,
item_name,
item_code,
style_name,
first_processes,
order_use_flag,
genus_name,
jp_flag,
brand_name,
pic_url,
genus_id,
genus_identity,
category_id,
category_identity from $database.t_main_item where 1=1"
}
import_t_material_price_rule(){
import_data t_material_price_rule " select 
id,
purity_identity,
customer_identity,
rule from $database.t_material_price_rule where 1=1"
}
import_t_metal_color_info(){
import_data t_metal_color_info " select 
id,
metal_color_info_identity,
color_code,
color_name,
mnemonic_code,
filter_code1,
filter_code2,
create_userid,
create_username,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_userid,
update_username,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
eos_head_key,
eos_body_key from $database.t_metal_color_info where 1=1"
}
import_t_move_counter(){
import_data t_move_counter " select 
id,
move_identity,
move_code,
order_identity,
order_code,
receive_identity,
receive_code,
purity_name,
customer_name,
customer_code,
engrave,
estimate_time,
showroom_counter_identity,
showroom_counter_name,
total_gold_weight,
total_number,
total_work_fee,
supplier_name,
stock_status,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
customer_showroom,
move_type,
move_status,
DATE_FORMAT(confirm_time,'%Y-%m-%d %H:%i:%s') confirm_time,
confirm_by,
replace(replace(remark,'\n',''),'\t','') remark,
status from $database.t_move_counter where 1=1"
}
import_t_move_counter_0705(){
import_data t_move_counter_0705 " select 
id,
move_identity,
move_code,
order_identity,
order_code,
receive_identity,
receive_code,
purity_name,
customer_name,
customer_code,
engrave,
DATE_FORMAT(estimate_time,'%Y-%m-%d %H:%i:%s') estimate_time,
showroom_counter_identity,
showroom_counter_name,
total_gold_weight,
total_number,
total_work_fee,
supplier_name,
stock_status,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
customer_showroom,
move_type,
move_status from $database.t_move_counter_0705 where 1=1"
}
import_t_move_counter_bak20220728(){
import_data t_move_counter_bak20220728 " select 
id,
move_identity,
move_code,
order_identity,
order_code,
receive_identity,
receive_code,
purity_name,
customer_name,
customer_code,
engrave,
DATE_FORMAT(estimate_time,'%Y-%m-%d %H:%i:%s') estimate_time,
showroom_counter_identity,
showroom_counter_name,
total_gold_weight,
total_number,
total_work_fee,
supplier_name,
stock_status,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
customer_showroom,
move_type,
move_status,
DATE_FORMAT(confirm_time,'%Y-%m-%d %H:%i:%s') confirm_time,
confirm_by,
replace(replace(remark,'\n',''),'\t','') remark from $database.t_move_counter_bak20220728 where 1=1"
}
import_t_move_counter_detail(){
import_data t_move_counter_detail " select 
id,
move_identity,
move_code,
product_code,
outsource_code,
product_name,
product_style,
piece_weight,
order_number,
order_weight,
receive_number,
receive_weight,
receive_weight_commit,
receive_number_commit,
receive_number_receive,
receive_weight_receive,
actual_number,
actual_weight,
difference_number,
difference_weight,
work_fee,
product_photo,
receive_id,
total_work_fee,
status from $database.t_move_counter_detail where 1=1"
}
import_t_move_counter_detail_bak20220728(){
import_data t_move_counter_detail_bak20220728 " select 
id,
move_identity,
move_code,
product_code,
outsource_code,
product_name,
product_style,
piece_weight,
order_number,
order_weight,
receive_number,
receive_weight,
receive_weight_commit,
receive_number_commit,
receive_number_receive,
receive_weight_receive,
actual_number,
actual_weight,
difference_number,
difference_weight,
work_fee,
product_photo,
receive_id,
total_work_fee from $database.t_move_counter_detail_bak20220728 where 1=1"
}
import_t_move_counter_detail_hw(){
import_data t_move_counter_detail_hw " select 
id,
move_identity,
move_code,
product_code,
outsource_code,
product_name,
product_style,
piece_weight,
order_number,
order_weight,
receive_number,
receive_weight,
receive_weight_commit,
receive_number_commit,
receive_number_receive,
receive_weight_receive,
actual_number,
actual_weight,
difference_number,
difference_weight,
work_fee,
product_photo,
receive_id,
total_work_fee from $database.t_move_counter_detail_hw where 1=1"
}
import_t_move_counter_hw(){
import_data t_move_counter_hw " select 
id,
move_identity,
move_code,
order_identity,
order_code,
receive_identity,
receive_code,
purity_name,
customer_name,
customer_code,
engrave,
DATE_FORMAT(estimate_time,'%Y-%m-%d %H:%i:%s') estimate_time,
showroom_counter_identity,
showroom_counter_name,
total_gold_weight,
total_number,
total_work_fee,
supplier_name,
stock_status,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
customer_showroom,
move_type,
move_status,
DATE_FORMAT(confirm_time,'%Y-%m-%d %H:%i:%s') confirm_time,
confirm_by,
replace(replace(remark,'\n',''),'\t','') remark from $database.t_move_counter_hw where 1=1"
}
import_t_mxzh(){
import_data t_mxzh " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
kczt,
kdzt,
sptm,
zshm,
giazs,
wdmc,
ckmc,
gysbm,
gys,
ppmc,
dlmc,
jsmc,
plmc,
gckh,
gskh,
gg,
spmc,
splx,
xlmc,
jz,
hz,
jgf,
xsgf,
sxf,
zsys,
zsjd,
zsqg,
zssl,
zszl,
fsmc,
fssl,
fszl,
js,
sjcb,
sccb,
bzjg,
bqjg,
dw,
khh,
ykj,
jp,
gflx,
pjsm,
cfhh,
replace(replace(BZ,'\n',''),'\t','') bz,
rkrq,
rkdh,
rkdm,
gxrq,
gxdh,
pdzt,
pddh,
lsdh,
lsrq,
xsdj,
sjzk,
ml,
mjj,
lsje,
jsdh,
jsrq,
jsje,
khmc,
ZSMC,
CXM,
EWM,
EWMX,
LBDM,
ZSCB,
FSCB,
WXFY,
BZCB,
ZSGG,
WXDM from $database.t_mxzh where 1=1"
}
import_t_package_engrave_tag(){
import_data t_package_engrave_tag " select 
id,
engrave_tag_identity,
fast_package_identity,
is_engrave,
is_tag,
engrave_content,
tag_content,
engrave_require_time,
tag_require_time,
business_require,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
is_immediate,
is_handle_engrave,
is_handle_tag,
up_count,
business_require_time from $database.t_package_engrave_tag where 1=1"
}
import_t_package_stay_weight_customer(){
import_data t_package_stay_weight_customer " select 
DATE_FORMAT(data_date,'%Y-%m-%d %H:%i:%s') data_date,
customer_identity,
customer_code,
customer_name,
customer_name_template,
parent_Customer_identity,
parent_Customer_code,
parent_Customer_Name,
counter_name,
department_name,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
net_weight,
is_inital from $database.t_package_stay_weight_customer where 1=1"
}
import_t_packing_paper(){
import_data t_packing_paper " select 
id,
paper_name,
paper_weight,
paper_type,
tolerance_weight,
counter_identity from $database.t_packing_paper where 1=1"
}
import_t_phone(){
import_data t_phone " select 
id,
phone from $database.t_phone where 1=1"
}
import_t_physical_counter(){
import_data t_physical_counter " select 
id,
physical_identity,
physical_name,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
status,
showroom_identity,
showroom_name,
super_counter from $database.t_physical_counter where 1=1"
}
import_t_print_log(){
import_data t_print_log " select 
id,
print_identity,
print_customer_code,
print_date from $database.t_print_log where 1=1"
}
import_t_product_basic_info(){
import_data t_product_basic_info " select 
id,
product_basic_info_identity,
showroom_identity,
showroom_name,
counter_identity,
counter_name,
product_code,
product_name,
factory_model_code,
gold_weight,
category_second_name,
standard_fee,
main_stone_name,
main_stone_specs,
qty,
category_name,
sales_fee,
storage_date,
storage_number,
storage_name,
goods_weight,
is_high_quality,
outsourc_code,
data_class,
order_status,
store_status,
eos_head_key1,
eos_head_key2,
eos_body_key,
company_model_code,
genus_code,
metal_color,
specification,
total_weight,
loss,
replace(replace(remark,'\n',''),'\t','') remark,
special_commodity_b,
last_open_order_no,
last_open_order,
last_no,
last_serial,
special_b,
certificate_no,
main_stone_color,
clarity,
contains_consumption_weight,
total_stone_weight,
main_stone_weight,
auxiliary_stone_weight1,
auxiliary_stone_weight2,
auxiliary_stone_weight3,
auxiliary_stone_weight4,
auxiliary_stone_weight5,
auxiliary_stone_weight6,
parts_weight1,
parts_weight2,
parts_weight3,
print_main_stone_weight,
print_auxiliary_stone_weight,
category_second_identity,
category_identity,
gold_stone_name,
stone_code,
stone_name,
stone_shape,
stone_number_s,
stone_unit_price_s,
pricing_method,
total_price_s,
auxiliary_stone_package_code1,
auxiliary_stone_name1,
auxiliary_stone_shape1,
auxiliary_stone_color1,
auxiliary_stone_clarity1,
auxiliary_stone_qty1,
auxiliary_stone_unit_price1,
pricing_method1,
auxiliary_stone_total_amount1,
auxiliary_stone_package_code2,
auxiliary_stone_name2,
auxiliary_stone_shape2,
auxiliary_stone_color2,
auxiliary_stone_clarity2,
auxiliary_stone_qty2,
auxiliary_stone_unit_price2,
pricing_method2,
auxiliary_stone_total_amount2,
auxiliary_stone_package_code3,
auxiliary_stone_name3,
auxiliary_stone_shape3,
auxiliary_stone_color3,
auxiliary_stone_clarity3,
auxiliary_stone_qty3,
auxiliary_stone_unit_price3,
pricing_method3,
auxiliary_stone_total_amount3,
auxiliary_stone_package_code4,
auxiliary_stone_name4,
auxiliary_stone_shape4,
auxiliary_stone_color4,
auxiliary_stone_clarity4,
auxiliary_stone_qty4,
auxiliary_stone_unit_price4,
pricing_method4,
auxiliary_stone_total_amount4,
auxiliary_stone_package_code5,
auxiliary_stone_name5,
auxiliary_stone_shape5,
auxiliary_stone_color5,
auxiliary_stone_clarity5,
auxiliary_stone_qty5,
auxiliary_stone_unit_price5,
pricing_method5,
auxiliary_stone_total_amount5,
auxiliary_stone_package_code6,
auxiliary_stone_name6,
auxiliary_stone_shape6,
auxiliary_stone_color6,
auxiliary_stone_clarity6,
auxiliary_stone_qty6,
auxiliary_stone_unit_price6,
pricing_method6,
auxiliary_stone_total_amount6,
accessory_name1,
accessory_qty1,
accessory_unit_price1,
pricing_method7,
accessory_amount1,
accessory_name2,
accessory_qty2,
accessory_unit_price2,
pricing_method8,
accessory_amount2,
accessory_name3,
accessory_qty3,
accessory_unit_price3,
pricing_method9,
accessory_amount3,
qr_code,
query_code,
series_name,
gold_stone_code from $database.t_product_basic_info where 1=1"
}
import_t_product_fee(){
import_data t_product_fee " select 
id,
product_fee_identity,
showroom_identity,
counter_identity,
product_code,
certificate_fee,
seam_fee,
back_cover_fee,
drawing_fee,
sandblasting_fee,
basic_fee,
start_fee,
stone_encrusted_fee,
processing_fee,
other_fee,
additional_labour,
parting_fee,
stone_encrusted_fee1,
other_fee1,
company_expenses,
certificate_fee0,
stone_fee,
label_fee,
eos_head_key1,
eos_head_key2,
eos_body_key,
main_stone_cost_amount,
auxiliary_stone_cost_amount1,
auxiliary_stone_cost_amount2,
auxiliary_stone_cost_amount3,
auxiliary_stone_cost_amount4,
auxiliary_stone_cost_amount5,
auxiliary_stone_cost_amount6,
parts_cost_amount1,
parts_cost_amount2,
parts_cost_amount3,
label_price,
main_stone_price,
auxiliary_stone_total_price1,
auxiliary_stone_total_price2,
auxiliary_stone_total_price3,
auxiliary_stone_total_price4,
auxiliary_stone_total_price5,
auxiliary_stone_total_price6,
gold_unit_price,
total_price,
gold_total_price,
purchase_amount,
fixed_price_storage,
main_stone_cost,
auxiliary_stone_cost,
stone_total_fee,
auxiliary_total_fee,
auxiliary_cost,
gold_costs,
data_class from $database.t_product_fee where 1=1"
}
import_t_product_model_basic(){
import_data t_product_model_basic " select 
id,
product_model_basic_identity,
showroom_identity,
showroom_name,
counter_identity,
counter_name,
model_code,
category_second_name,
category_second_identity,
category_name,
category_identity,
complementary_material,
simple_model_no,
label_short_code,
gold_weight,
style_name,
price_method,
mnemonic_code,
data_class,
eos_head_key,
eos_body_key from $database.t_product_model_basic where 1=1"
}
import_t_product_model_discount(){
import_data t_product_model_discount " select 
id,
product_model_discount_identity,
showroom_identity,
showroom_name,
model_code,
model_name,
factory_model_code,
factory_model_name,
price_method,
sales_min_discount,
is_enable,
eos_head_key,
eos_body_key from $database.t_product_model_discount where 1=1"
}
import_t_product_model_fee(){
import_data t_product_model_fee " select 
id,
product_model_fee_identity,
model_code,
model_name,
metal_color_code,
metal_color_name,
single_fee,
sales_fee,
actual_sales_fee,
data_class,
eos_head_key,
eos_body_key,
mnemonic_code,
model_code_color from $database.t_product_model_fee where 1=1"
}
import_t_product_package(){
import_data t_product_package " select 
id,
package_identity,
number,
item_id,
item_identity,
net_weight,
gross_weight,
additional_amount,
spec_labour_flag from $database.t_product_package where 1=1"
}
import_t_province_salesman(){
import_data t_province_salesman " select 
id,
province_salesman_identity,
province_code,
province,
salesman_id,
salesman_identity,
DATE_FORMAT(data_create_time,'%Y-%m-%d %H:%i:%s') data_create_time,
DATE_FORMAT(data_update_time,'%Y-%m-%d %H:%i:%s') data_update_time,
region,
showroom_identity
 from $database.t_province_salesman where 1=1"
}
import_t_purity(){
import_data t_purity " select 
id,
purity_identity,
purity_code,
purity_name,
create_user_id,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
modify_user_id,
DATE_FORMAT(modify_date,'%Y-%m-%d %H:%i:%s') modify_date,
status,
type,
purity_type,
help_code,
purity_percent,
basic_purity_identity,
technology_purity_identity from $database.t_purity where 1=1"
}
import_t_purity_engrave(){
import_data t_purity_engrave " select 
id,
purity_engrave_identity,
purity_identity,
purity_name,
engrave_name,
create_user_id,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
modify_user_id,
DATE_FORMAT(modify_date,'%Y-%m-%d %H:%i:%s') modify_date,
type,
status from $database.t_purity_engrave where 1=1"
}
import_t_purity_tag(){
import_data t_purity_tag " select 
id,
purity_tag_identity,
purity_identity,
purity_name,
tag_name,
create_user_id,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
modify_user_id,
DATE_FORMAT(modify_date,'%Y-%m-%d %H:%i:%s') modify_date,
type,
status from $database.t_purity_tag where 1=1"
}
import_t_qc(){
import_data t_qc " select 
id,
receive_identity,
receive_code,
purity_name,
qc_total_weight,
qc_total_number,
total_fee,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
supplier_identity,
supplier_name,
supplier_source,
supplier_type,
receive_type,
qc_status,
status,
qc_type from $database.t_qc where 1=1"
}
import_t_qc_detial(){
import_data t_qc_detial " select 
*id,
receive_identity,
receive_code,
order_identity,
order_code,
product_code,
product_name,
product_style,
company_code,
factory_code,
outsource_code,
piece_weight,
qc_weight,
qc_number,
qc_end,
qc_remark,
status,
eos_order_detail_id
 from $database.t_qc_detial where 1=1"
}
import_t_queue_factory(){
import_data t_queue_factory " select 
queue_name,
queue_value,
DATE_FORMAT(queue_date,'%Y-%m-%d %H:%i:%s') queue_date,
reset from $database.t_queue_factory where 1=1"
}
import_t_reason_dictionaries(){
import_data t_reason_dictionaries " select id,
reason_name,
type,
status,
reason_type
 from $database.t_reason_dictionaries where 1=1"
}
import_t_reason_dictionaries_harmful(){
import_data t_reason_dictionaries_harmful " select 
id,
name,
type,
status from $database.t_reason_dictionaries_harmful where 1=1"
}
import_t_receive(){
import_data t_receive " select 
id,
receive_identity,
receive_code,
purity_name,
total_gold_weight,
total_number,
total_fee,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
supplier_type,
receive_type,
receive_status,
status,
end_reason,
supplier_identity,
supplier_name,
supplier_source,
variety,
first_status,
receive_reason,
qc_type,
if_all_return,
check_status,
color_gold_weight,
is_examine,
if_sure_price_ok,
if_product_code_add_ok,
showroom_name,
genus_name,
examine_by,
DATE_FORMAT(examine_time,'%Y-%m-%d %H:%i:%s') examine_time,
receive_remark,
total_fee_check,
showroom_identity,
counter_identity,
counter_name,
ppmc from $database.t_receive where 1=1"
}
import_t_receive_allocation(){
import_data t_receive_allocation " select 
id,
allocation_identity,
allocation_code,
receive_identity,
receive_code,
transfer_out_point,
transfer_out_warehouse,
transfer_in_point,
transfer_in_warehouse,
transfer_total_count,
transfer_total_weight,
allocation_total_work_fee,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time from $database.t_receive_allocation where 1=1"
}
import_t_receive_allocation_detail(){
import_data t_receive_allocation_detail " select 
id,
allocation_identity,
allocation_code,
receive_detial_id,
allocation_weight,
allocation_count,
transfer_out_weight,
transfer_out_count,
allocation_work_fee from $database.t_receive_allocation_detail where 1=1"
}
import_t_receive_check_account(){
import_data t_receive_check_account " select 
id,
check_account_identity,
counter_name,
counter_identity,
start_weight,
end_weight,
today_weight,
reality_weight,
is_delete,
DATE_FORMAT(check_date,'%Y-%m-%d %H:%i:%s') check_date,
create_user,
surplus,
firm_offer from $database.t_receive_check_account where 1=1"
}
import_t_receive_check_account_detail(){
import_data t_receive_check_account_detail " select 
id,
check_account_identity,
counter_name,
counter_identity,
purity_name,
purity_identity,
start_weight,
end_weight,
today_weight,
reality_weight,
in_total_weight,
out_total_weight,
return_total_weight,
sz_in_weight,
sz_out_weight,
fz_in_weight,
fz_out_weight,
zx_in_weight,
zx_out_weight,
is_delete,
check_date,
create_user,
surplus,
firm_offer from $database.t_receive_check_account_detail where 1=1"
}
import_t_receive_detail_small(){
import_data t_receive_detail_small " select 
id,
receive_identity,
receive_detail_id,
order_identity,
eos_order_detail_id,
product_photo,
payment_code,
factory_code,
product_style,
number,
total_weight,
contain_loss_weight,
loss_weight,
net_gold_weight,
unit_gold_weight,
price,
master_stone_name,
jade_stone_name,
jade_stone_size,
price_interval_lowest,
price_interval_highest,
master_stone_number,
master_stone_weight,
master_stone_unit_price,
valuation_metbod_one,
side_stone_name_one,
side_stone_number_one,
side_stone_weight_one,
valuation_metbod_two,
side_stone_name_two,
side_stone_number_two,
side_stone_weight_two,
stone_fee,
stone_total_fee,
base_work_fee,
attach_work_fee,
make_up_fee,
other_fee,
total_fee,
is_check,
receive_payment_type from $database.t_receive_detail_small where 1=1"
}
import_t_receive_detial(){
import_data t_receive_detial " select 
id,
receive_identity,
receive_code,
order_identity,
order_code,
product_photo,
product_code,
product_name,
product_style,
company_code,
factory_code,
outsource_code,
piece_weight,
order_number,
receive_number,
order_weight,
receive_weight,
receive_old_weight,
receive_old_number,
weight_percentage,
number_percentage,
work_fee,
total_work_fee,
estimate_time,
is_check,
check_number,
check_weight,
over_reason,
qc_end,
qc_remark,
zj_end,
zj_remark,
eos_order_detail_id,
status,
zj_code,
technology_unit_price,
supplied_technology_unit_price,
color_gold_weight,
supplied_work_fee,
metal_color,
qc_number,
qc_weight,
if_check_return,
materials_spread,
is_examine,
add_price,
if_transfer_back,
genus_name,
attach_work_fee,
attach_work_fee_je,
label_price,
hz,
bqm,
allocation_status from $database.t_receive_detial where 1=1"
}
import_t_receive_detial_reword(){
import_data t_receive_detial_reword " select 
id,
reword_identity,
return_identity,
receive_identity,
order_identity,
receive_detial_id,
rework_num,
rework_weight,
check_return_number,
check_return_weight,
no_rework_num,
no_rework_weight,
val_status,
return_reason,
eos_order_detail_id,
qxth_identity from $database.t_receive_detial_reword where 1=1"
}
import_t_receive_detial_work_fee(){
import_data t_receive_detial_work_fee " select 
id,
receive_detail_id,
number,
weight,
quality_testing_number,
quality_testing_weight,
zj_number_receive,
zj_weight_receive,
zj_number_back,
zj_weight_back,
zj_weight_back_receive,
zj_number_back_receive,
other_number,
other_weight,
work_fee,
if_check_return,
return_total_number,
return_total_weight,
status,
work_fee_mc from $database.t_receive_detial_work_fee where 1=1"
}
import_t_receive_difference_detail(){
import_data t_receive_difference_detail " select 
id,
receive_identity,
receive_code,
order_identity,
order_code,
receive_detial_id,
difference_type,
difference_type_desc,
old_number,
receive_number,
difference_number,
difference_number_change,
old_weight,
receive_weight,
difference_weight,
difference_weight_change,
difference_status,
difference_status_desc,
difference_attribution,
difference_attribution_desc,
difference_photo,
qc_receive_number,
qc_receive_weight,
return_type,
return_type_desc,
audit_result,
if_confirm_back,
replace(replace(remark,'\n',''),'\t','') remark,
status from $database.t_receive_difference_detail where 1=1"
}
import_t_receive_eos_order_purity(){
import_data t_receive_eos_order_purity " select 
id,
purity_name,
purity_type,
status from $database.t_receive_eos_order_purity where 1=1"
}
import_t_receive_eos_order_records(){
import_data t_receive_eos_order_records " select 
id,
receive_code,
supplier_type,
order_number,
receive_number,
order_weight,
receive_weight,
receive_detail_id,
order_detail_id,
djbth,
djlsh,
receive_time,
audit_time,
create_by,
create_time,
update_by,
update_time,
order_code from $database.t_receive_eos_order_records where 1=1"
}
import_t_receive_eos_order_records_copy1(){
import_data t_receive_eos_order_records_copy1 " select 
id,
receive_code,
supplier_type,
order_number,
receive_number,
order_weight,
receive_weight,
receive_detail_id,
order_detail_id,
djbth,
djlsh from $database.t_receive_eos_order_records_copy1 where 1=1"
}
import_t_receive_flgfbh(){
import_data t_receive_flgfbh " select 
id,
dj_lsh,
dj_bt_zdh,
dj_ft_zdh,
dj_st_zdh,
dj_state,
dj_count,
wdmc,
wdbm,
pxbm,
pxmc,
pxgf,
zdr,
zdrid,
DATE_FORMAT(zdsj,'%Y-%m-%d %H:%i:%s') zdsj,
shr,
shrid,
DATE_FORMAT(shsj,'%Y-%m-%d %H:%i:%s') shsj,
djzt,
gysmc,
gysbm,
zfr,
zfrid,
zfsj from $database.t_receive_flgfbh where 1=1"
}
import_t_receive_order(){
import_data t_receive_order " select 
id,
receive_identity,
order_identity from $database.t_receive_order where 1=1"
}
import_t_receive_payment_code_info(){
import_data t_receive_payment_code_info " select 
id,
payment_code,
payment_name,
product_photo from $database.t_receive_payment_code_info where 1=1"
}
import_t_receive_purity_mapping(){
import_data t_receive_purity_mapping " select 
id,
receive_purity_name,
purity_name,
status from $database.t_receive_purity_mapping where 1=1"
}
import_t_receive_purity_mapping_copy1(){
import_data t_receive_purity_mapping_copy1 " select 
id,
receive_purity_name,
purity_name,
status from $database.t_receive_purity_mapping_copy1 where 1=1"
}
import_t_receive_status(){
import_data t_receive_status " select 
id,
number,
receive_style,
status from $database.t_receive_status where 1=1"
}
import_t_receive_stream_type(){
import_data t_receive_stream_type " select 
id,
type,
name from $database.t_receive_stream_type where 1=1"
}
import_t_sale_from(){
import_data t_sale_from " select 
id, sale_code, sale_identity, if_update_work_fee, if_tax_rate, tax_rate, area, showroom_identity, showroom_name,  DATE_FORMAT(sale_date,'%Y-%m-%d %H:%i:%s')  sale_date, purity_identity, sale_type, customer_identity, main_customer_identity, 
admin_settle_accounts_identity, settle_accounts_identity, grain_price, total_number, total_gold_weight, total_weight, total_additional_labour, total_conversion_gold, total_label_price, total_stone_price, total_price, replace(replace(remark,'\n',''),'\t','') remark, discount_remark, 
if_print_remark, create_by, DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s')  create_time, approve_by, DATE_FORMAT(approve_time,'%Y-%m-%d %H:%i:%s') approve_time, approve_status, update_by,DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s')  update_time, 
if_update_discount, discount, if_gold_work_stone, if_retail, type, retail_work_fee, status, if_dydf, child_customer_code, settle_child_customer_code, jjjz, jjje, lljzhj, llgfhj, zqljzhj, zqlgfje, zqsjzhj, fyhj, zqgfhj, zqjz, tsjz, tsjehj, jsjzxj, 
jsjexj, qzl, lk, DATE_FORMAT(bill_date,'%Y-%m-%d %H:%i:%s') bill_date, synchronize_zds, meterial_weight, meterial_price, meterial_code, jewelry_weight, jewelry_price, jewelry_code, invalid_why, print_count, gold_price, 
bdze,DATE_FORMAT(print_time,'%Y-%m-%d %H:%i:%s') print_time
 from $database.t_sale_from where 1=1"
}
import_t_sale_from_account(){
import_data t_sale_from_account " select 
id,
sale_account_identity,
sale_identity,
total_not_account,
total_ok_account,
total_price,
incoming_identity,
incoming_number,
incoming_weight,
return_identity,
return_number,
return_weight,
status from $database.t_sale_from_account where 1=1"
}
import_t_sale_from_account_detail(){
import_data t_sale_from_account_detail " select 
id,
row_id,
sale_account_identity,
sale_identity,
sale_account_detail_identity,
account_type,
work_fee_type,
account_method,
purity_identity,
purity_name,
product_style,
gold_price,
gold_weight,
unit_price,
work_fee,
amount,
replace(replace(remark,'\n',''),'\t','')  remark,
purification_work_fee,
purification_work_fee_amount,
conversion_gold_work_fee,
conversion_gold_amount,
base_work_fee,
base_work_fee_amount,
gold_income,
gold_material_price,
status,
parent_type,
content,
actual_content,
price,
big_category_attribution,
receive_meterial_code,
receive_meterial_detail_identity from $database.t_sale_from_account_detail where 1=1"
}
import_t_sale_from_detail(){
import_data t_sale_from_detail " select 
id,
sale_detail_identity,
sale_identity,
counter_name,
genus_name,
package_code,
total_number_detail,
net_weight,
package_i_code,
additional_labour,
update_additional_labour,
additional_labour_price,
replace(replace(remark,'\n',''),'\t','') remark,
small_remark,
status,
category_name,
second_category_name,
label_price,
batch_price,
other_price from $database.t_sale_from_detail where 1=1"
}
import_t_sale_from_invalid(){
import_data t_sale_from_invalid " select 
id,
invalid_code,
invalid_why,
is_delete from $database.t_sale_from_invalid where 1=1"
}
import_t_sale_settlement_type(){
import_data t_sale_settlement_type " select 
id,
settlement_type,
work_fee,
type,
is_delete,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time from $database.t_sale_settlement_type where 1=1"
}
import_t_sale_summary_sync(){
import_data t_sale_summary_sync " select 
id,
djh,
customer_name,
customer_code,
order_weight,
purity_name,
zd_time,
network_name,
counter_name,
category_name,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
djlx from $database.t_sale_summary_sync where 1=1"
}
import_t_sales_return(){
import_data t_sales_return " select 
id,
return_identity,
return_code,
receive_identity,
receive_code,
purity_name,
supplier_identity,
supplier_name,
supplier_source,
supplier_type,
return_total_weight,
return_total_number,
return_total_price,
return_time,
return_type,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
status,
receive_reason,
receive_type,
return_status,
expected_delivery_time,
counter_identity,
counter_name,
gross_weight,
showroom_name,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
sale_return_remark,
examine_by,
DATE_FORMAT(examine_time,'%Y-%m-%d %H:%i:%s') examine_time,
check_number_all,
check_weight_all from $database.t_sales_return where 1=1"
}
import_t_sales_return_detial(){
import_data t_sales_return_detial " select 
id,
receive_identity,
receive_code,
order_identity,
order_code,
product_code,
outsource_code,
product_bar_code,
product_name,
product_style,
company_code,
factory_code,
piece_weight,
order_number,
receive_number,
order_weight,
receive_weight,
work_fee,
total_work_fee,
qc_weight,
qc_number,
qc_end,
qc_remark,
return_number,
return_weight,
return_reason,
purity_name,
supplier_identity,
supplier_name,
supplier_source,
supplier_type,
status,
return_identity,
return_code,
technology_unit_price,
total_technology_unit_price,
supplied_technology_unit_Price,
price,
supplied_work_fee,
if_check_return,
materials_spread,
receive_detial_id,
eos_order_detail_id,
detail_color,
label_price,
img_url,
replace(replace(remark,'\n',''),'\t','') remark,
check_number_all,
check_weight_all from $database.t_sales_return_detial where 1=1"
}
import_t_sales_return_this_count(){
import_data t_sales_return_this_count " select 
id,
return_identity,
return_code,
receive_identity,
receive_code,
receive_detail_id,
this_return_count,
this_return_weight,
receive_work_id from $database.t_sales_return_this_count where 1=1"
}
import_t_salesman(){
import_data t_salesman " select 
id,
salesman_identity,
is_leader,
user_id,
user_identity,
user_name,
phone_no,
busy_flag,
begin_out_date,
end_out_date,
act_salesman_id,
act_salesman_identity,
act_salesman_name,
showroom_id,
pub_openid,
showroom_identity,
replace(replace(remarks,'\n',''),'\t','') remarks,
DATE_FORMAT(etl_dt,'%Y-%m-%d %H:%i:%s') etl_dt,
is_deleted,
job_id,
job_identity,
phone_no1,
pub_openid1,
salesman_depart_identity,
salesman_role_identity,
history_permission,
salesman_region,
region_leader from $database.t_salesman where 1=1"
}
import_t_salesman_area(){
import_data t_salesman_area " select 
id,
salesman_identity,
area_identity,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time from $database.t_salesman_area where 1=1"
}
import_t_salesman_choose_log(){
import_data t_salesman_choose_log " select 
id,
customer_identity,
salesman_identity,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time from $database.t_salesman_choose_log where 1=1"
}
import_t_salesman_depart(){
import_data t_salesman_depart " select 
id,
salesman_depart_identity,
salesman_depart_code,
salesman_depart_name,
father_depart_identity,
father_depart_code,
father_depart_name,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
DATE_FORMAT(update_date,'%Y-%m-%d %H:%i:%s') update_date from $database.t_salesman_depart where 1=1"
}
import_t_salesman_log(){
import_data t_salesman_log " select 
id,
customer_id,
customer_identity,
showroom_identity,
salesman_id,
salesman_identity,
salesman_name,
react_type,
next_saleman_id,
next_saleman_identity,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
DATE_FORMAT(react_time,'%Y-%m-%d %H:%i:%s') react_time,
father_id,
showroom_code,
log_type,
replace(replace(remarks,'\n',''),'\t','') remarks,
father_salesman_id,
father_salesman_name,
DATE_FORMAT(insert_time,'%Y-%m-%d %H:%i:%s') insert_time
 from $database.t_salesman_log where 1=1"
}
import_t_salesman_role(){
import_data t_salesman_role " select 
id,
salesman_role_identity,
salesman_role_code,
salesman_role_name,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
DATE_FORMAT(update_date,'%Y-%m-%d %H:%i:%s') update_date from $database.t_salesman_role where 1=1"
}
import_t_salesman_time_log(){
import_data t_salesman_time_log " select 
id,
salesman_id,
salesman_identity,
salesman_name,
DATE_FORMAT(begin_out_date,'%Y-%m-%d %H:%i:%s') begin_out_date,
DATE_FORMAT(end_out_date,'%Y-%m-%d %H:%i:%s') end_out_date,
act_salesman_id,
act_salesman_identity,
act_salesman_name,
DATE_FORMAT(etl_dt,'%Y-%m-%d %H:%i:%s') etl_dt from $database.t_salesman_time_log where 1=1"
}
import_t_salesman_time_out(){
import_data t_salesman_time_out " select 
id,
timeout_type,
timeout_code from $database.t_salesman_time_out where 1=1"
}
import_t_scale(){
import_data t_scale " select 
id,
scale_identity,
scale_code,
showroom_id,
showroom_identity,
counter_id,
counter_identity from $database.t_scale where 1=1"
}
import_t_settlement_stay(){
import_data t_settlement_stay " select 
id,
settlement_stay_identity,
fast_package_identity,
fast_package_code,
stay_status,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
create_user,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time from $database.t_settlement_stay where 1=1"
}
import_t_showroom(){
import_data t_showroom " select 
id,
showroom_identity,
showroom_code,
showroom_name,
status,
DATE_FORMAT(final_time,'%Y-%m-%d %H:%i:%s') final_time,
create_user_id,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
modify_user_id,
DATE_FORMAT(modify_date,'%Y-%m-%d %H:%i:%s') modify_date,
longitude,
dimension,
showroom_type,
is_delete from $database.t_showroom where 1=1"
}
import_t_showroom_counter(){
import_data t_showroom_counter " select 
id,
counter_identity,
showroom_id,
showroom_identity,
counter_code,
counter_name,
showroom_code,
showroom_name,
stock_code,
stock_name,
modify_user_code,
modify_user_name,
DATE_FORMAT(modify_date,'%Y-%m-%d %H:%i:%s') modify_date,
last_user_name,
DATE_FORMAT(last_date,'%Y-%m-%d %H:%i:%s') last_date,
purity_id,
purity_identity,
is_delete,
genus_id,
genus_identity,
code_seq,
create_time,
eos_zdrid,
eos_zdr,
type,
sort,
physical_identity,
physical_name,
is_single_piece,
is_metal_working,
is_default,
variety,
max_additional_labour,
max_technology_unit_price,
technology_purity_identity,
is_many_purity from $database.t_showroom_counter where 1=1"
}
import_t_showroom_counter_second(){
import_data t_showroom_counter_second " select 
id,
counter_name from $database.t_showroom_counter_second where 1=1"
}
import_t_showroom_package(){
import_data t_showroom_package " select 
id,
package_identity,
is_child,
showroom,
package_no,
pack_date,
showroom_code,
customer_code,
purity_name,
customer_name,
child_customer_name,
child_customer_code,
child_customer_no,
salesman,
contact_man,
customer_help_code,
total_net_weight,
address,
memo,
create_user_code,
create_user_name,
create_date,
check_user_name,
check_date,
purity_code,
purity,
out_stock_no,
total_amount,
total_qty,
phone_no,
gold_gem_name_b,
class_name_b,
discount,
gold_price,
auto_save,
barcode_check,
package_status,
char_date,
begin_row,
end_row,
redo_cost,
of_stock_code,
label_total_amount,
print_body_memo,
discount_amount_h,
stock_name_h,
scale_value,
first_category_h,
first_category_code_h,
confirm_date,
is_post,
pick_no,
pick_zip_code,
is_transfer,
post_date,
package_qty,
is_other_factory,
showroom_area,
receipt,
random_customer_name,
random_customer_code,
is_label,
not_label,
stock_name,
stock_code,
splite_no,
love_5d_label,
is_lm,
clerk_code,
B2B_sale,
line_queue from $database.t_showroom_package where 1=1"
}
import_t_showroom_package_i(){
import_data t_showroom_package_i " select 
id,
package_identity,
package_id,
seq_no,
item_flag,
stock_name,
stock_code,
additional_labour,
net_weight,
class_name,
first_category_code,
first_category_name,
second_category_code,
second_category_name,
item_barcode,
factory_style,
standard_labour,
additional_amount,
class_code,
main_gem_name,
main_gem_qty,
main_gem_weight,
gold_gem_name,
memo,
gold_gem_code,
qty,
item_name,
qr_code,
search_code,
is_modifed,
discount,
discount_amount,
source_additional_labour,
labour_discount,
discount_flag,
yj_standard_labour,
jp_labour,
item_labour,
spec_labour_flag,
adj_amount from $database.t_showroom_package_i where 1=1"
}
import_t_showroom_role(){
import_data t_showroom_role " select 
id,
showroom_role_identity,
role_code,
role_name,
create_user_id,
create_date,
modify_user_id,
modify_date from $database.t_showroom_role where 1=1"
}
import_t_showroom_sale_plan(){
import_data t_showroom_sale_plan " select 
id,
sale_plan_identity,
showroom_identity,
showroom_name,
plan_year,
plan_type,
plan_sale_total,
plan_date_number,
create_date,
create_user_identity,
update_date,
update_user_identity from $database.t_showroom_sale_plan where 1=1"
}
import_t_showroom_storage_data(){
import_data t_showroom_storage_data " select 
showroom_name,
DATE_FORMAT(data_date,'%Y-%m-%d') data_date,
purity_name,
yestoday_weight,
in_storage_weight,
remain_weight from $database.t_showroom_storage_data where 1=1"
}
import_t_showroom_storage_data_copy1(){
import_data t_showroom_storage_data_copy1 " select 
showroom_name,
DATE_FORMAT(data_date,'%Y-%m-%d') data_date,
purity_name,
yestoday_weight,
in_storage_weight,
remain_weight from $database.t_showroom_storage_data_copy1 where 1=1"
}
import_t_special_style_discount(){
import_data t_special_style_discount " select 
style_code,
style_discount,
is_enable from $database.t_special_style_discount where 1=1"
}
import_t_splszh(){
import_data t_splszh " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
djm,
djh,
rq,
swlx,
KCLX,
WDBM,
wdmc,
CKBM,
ckmc,
jsmc,
plmc,
YJPL,
EJPL,
sffx,
js,
jz,
bqjg,
KHBM,
KHMC,
ZKH,
RHF,
CHF,
replace(replace(BZ,'\n',''),'\t','') BZ,
FJGF,
BZGF,
ZL,
XSGF,
RHWDMC,
FJGFJE,
JCGF,
JCGFJE,
FKHSL,
RKYY,
GYLX,
ZQCE,
ZQCEXJ from $database.t_splszh where 1=1"
}
import_t_splszh_log(){
import_data t_splszh_log " select 
id,
splszh_djLsh,
djLsh,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
fast_package_identity,
order_identity,
package_code,
status from $database.t_splszh_log where 1=1"
}
import_t_stock(){
import_data t_stock " select 
id,
stock_identity,
stock_code,
stock_name,
stock_type,
create_user_id,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
modify_user_id,
DATE_FORMAT(modify_date,'%Y-%m-%d %H:%i:%s') modify_date from $database.t_stock where 1=1"
}
import_t_stored_procedure_log(){
import_data t_stored_procedure_log " select 
id,
execute_id,
stored_procedure_name,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_user,
log from $database.t_stored_procedure_log where 1=1"
}
import_t_stored_procedure_status(){
import_data t_stored_procedure_status " select 
id,
stored_procedure_name,
execute_status from $database.t_stored_procedure_status where 1=1"
}
import_t_supplier(){
import_data t_supplier " select 
id,
supplier_identity,
supplier_source,
supplier_type,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
update_by,
status from $database.t_supplier where 1=1"
}
import_t_supplier_detial(){
import_data t_supplier_detial " select 
id,
supplier_name,
supplier_identity,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
status,
supplier_code,
customer_identity,
type,
djlsh from $database.t_supplier_detial where 1=1"
}
import_t_supplier_rebate(){
import_data t_supplier_rebate " select 
id,
supplier_identity,
supplier_name,
supplier_source,
rebate,
rebate_money,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
rebate_enable from $database.t_supplier_rebate where 1=1"
}
import_t_sync_customer(){
import_data t_sync_customer " select 
sync_table_name,
djlsh,
khbm,
xh,
phone1,
phone2,
phone3,
phone4,
is_deleted from $database.t_sync_customer where 1=1"
}
import_t_sync_table(){
import_data t_sync_table " select 
sync_table_name,
djlsh from $database.t_sync_table where 1=1"
}
import_t_sync_time(){
import_data t_sync_time " select 
id,
code,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time from $database.t_sync_time where 1=1"
}
import_t_synchronization_customer_log(){
import_data t_synchronization_customer_log " select 
id,
log_identity,
data_type,
replace(replace(remarks,'\n',''),'\t','') remarks,
DATE_FORMAT(date_date,'%Y-%m-%d %H:%i:%s') date_date from $database.t_synchronization_customer_log where 1=1"
}
import_t_szpxgfjcbh(){
import_data t_szpxgfjcbh " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
DJH,
WDBM,
WDMC,
CKBM,
CKMC,
PLBM,
ZJM,
PLMC,
EJPLBM,
EJPLMC,
EJPLZJM,
JBGF,
ZDRID,
ZDR,
ZDSJ,
XGRID,
XGR,
XGSJ from $database.t_szpxgfjcbh where 1=1"
}
import_t_technology_purity(){
import_data t_technology_purity " select 
id,
purity_name from $database.t_technology_purity where 1=1"
}
import_t_temp_customer_transform(){
import_data t_temp_customer_transform " select 
SOURCE,
DJLSH,
CUSTOMER_IDENTITY_999,
KHBM_999,
KHMC_999,
ZKH_999,
CUSTOMER_IDENTITY,
KHBM,
KHMC,
ZKH,
TECH_PURITY_NAME from $database.t_temp_customer_transform where 1=1"
}
import_t_temp_interest_adjust_money_record(){
import_data t_temp_interest_adjust_money_record " select 
append_date,
append_record_name,
djlsh,
out_customer_code,
append_amount,
append_fee,
in_customer_code from $database.t_temp_interest_adjust_money_record where 1=1"
}
import_t_temp_lllsz(){
import_data t_temp_lllsz " select 
wdmc,
customer_identity,
khbm,
khmc,
zkh,
tech_purity_name,
djm,
djh,
swlx,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
jz from $database.t_temp_lllsz where 1=1"
}
import_t_temp_showroom_sales_data(){
import_data t_temp_showroom_sales_data " select 
showroom_name,
DATE_FORMAT(data_date,'%Y-%m-%d %H:%i:%s') data_date,
purity_name,
yestoday_weight,
in_storage_weight,
remain_weight from $database.t_temp_showroom_sales_data where 1=1"
}
import_t_temp_trans_history(){
import_data t_temp_trans_history " select 
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
khbm_old,
khbm,
khmc,
zkh,
customer_identity,
purity_name,
khbm_999,
khmc_999,
zkh_999,
djje,
djjz from $database.t_temp_trans_history where 1=1"
}
import_t_temp_ysmxz(){
import_data t_temp_ysmxz " select 
ysmxz_h_identity,
ysmxz_b_identity,
customer_identity,
wdmc,
khbm,
khmc,
zkh,
tech_purity_name,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
djm,
djh,
fs,
djje,
jjje,
gfje,
DATE_FORMAT(hkshrq,'%Y-%m-%d %H:%i:%s') hkshrq,
swlb from $database.t_temp_ysmxz where 1=1"
}
import_t_temp_ywy(){
import_data t_temp_ywy " select 
CZR,
CZRID,
je from $database.t_temp_ywy where 1=1"
}
import_t_tran_miss_package(){
import_data t_tran_miss_package " select 
djlsh,
fast_package_identity from $database.t_tran_miss_package where 1=1"
}
import_t_tykhgjb(){
import_data t_tykhgjb " select 
DjLsh,
DjBth,
DjState,
WDMC,
KHMC,
KHBM,
ZKH,
CSGS,
CRBS,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time from $database.t_tykhgjb where 1=1"
}
import_t_tykhgjh(){
import_data t_tykhgjh " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
GSWD,
TYKHMC,
TYKHBM,
WHR,
ZHWHSJ,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time from $database.t_tykhgjh where 1=1"
}
import_t_tykhgjh_sync(){
import_data t_tykhgjh_sync " select 
tykhbm,
khbm,
DATE_FORMAT(data_time,'%Y-%m-%d %H:%i:%s') data_time from $database.t_tykhgjh_sync where 1=1"
}
import_t_user(){
import_data t_user " select 
id,
user_identity,
user_code,
user_name,
create_user_id,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
modify_user_id,
DATE_FORMAT(modify_date,'%Y-%m-%d %H:%i:%s') modify_date,
is_deleted from $database.t_user where 1=1"
}
import_t_user_counter(){
import_data t_user_counter " select 
id,
identity,
user_identity,
counter_identity from $database.t_user_counter where 1=1"
}
import_t_user_role(){
import_data t_user_role " select 
id,
user_id,
user_identity,
role_id,
role_identity from $database.t_user_role where 1=1"
}
import_t_wechat_message_log(){
import_data t_wechat_message_log " select 
id,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
type,
content,
success,
error_message from $database.t_wechat_message_log where 1=1"
}
import_t_wechat_pub(){
import_data t_wechat_pub " select 
id,
pub_identity,
openid,
nickname,
sex,
language,
country,
province,
city,
headimgurl,
phone,
create_user_id,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
modify_user_id,
DATE_FORMAT(modify_date,'%Y-%m-%d %H:%i:%s') modify_date from $database.t_wechat_pub where 1=1"
}
import_t_wechat_smallroutine(){
import_data t_wechat_smallroutine " select 
id,
smallroutine_identity,
openid,
nickname,
sex,
language,
country,
province,
city,
headimgurl,
phone,
create_user_id,
DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') create_date,
modify_user_id,
DATE_FORMAT(modify_date,'%Y-%m-%d %H:%i:%s') modify_date from $database.t_wechat_smallroutine where 1=1"
}
import_t_wholesaling_category_info(){
import_data t_wholesaling_category_info " select 
id,
type_coding,
type_code,
type_name,
status,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time from $database.t_wholesaling_category_info where 1=1"
}
import_t_work_fee_detail(){
import_data t_work_fee_detail " select 
id,
work_fee_id,
fee_count,
subtotal,
fee_unit_price,
name from $database.t_work_fee_detail where 1=1"
}
import_t_xcx_kfrx(){
import_data t_xcx_kfrx " select 
phone_number from $database.t_xcx_kfrx where 1=1"
}
import_t_zx_customer(){
import_data t_zx_customer " select 
customer_identity from $database.t_zx_customer where 1=1"
}
import_temp_csmc(){
import_data temp_csmc " select 
csmc,
khbm from $database.temp_csmc where 1=1"
}
import_temp_customer_hw(){
import_data temp_customer_hw " select 
WDMC,
CUSTOMER_IDENTITY,
KHBM,
KHMC,
ZKHMC,
CSMC,
PQMC,
SJXQMC,
DJSXX,
SXQXX,
KHBH from $database.temp_customer_hw where 1=1"
}
import_temp_eos_sales_data(){
import_data temp_eos_sales_data " select 
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
XH,
kclx,
ckmc,
b1 from $database.temp_eos_sales_data where 1=1"
}
import_test_demo(){
import_data test_demo " select 
id,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
name,
sex,
age,
descc,
birthday,
user_code,
file_kk,
top_pic from $database.test_demo where 1=1"
}
import_test_enhance_select(){
import_data test_enhance_select " select 
id,
province,
city,
area,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
create_by from $database.test_enhance_select where 1=1"
}
import_test_order_main(){
import_data test_order_main " select 
id,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
order_code,
DATE_FORMAT(order_date,'%Y-%m-%d %H:%i:%s') order_date,
descc from $database.test_order_main where 1=1"
}
import_test_order_product(){
import_data test_order_product " select 
id,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
product_name,
price,
num,
descc,
order_fk_id,
pro_type from $database.test_order_product where 1=1"
}
import_test_person(){
import_data test_person " select 
id,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
sex,
name,
content,
be_date,
qj_days from $database.test_person where 1=1"
}
import_test_shoptype_tree(){
import_data test_shoptype_tree " select 
id,
create_by,
DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') create_time,
update_by,
DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') update_time,
sys_org_code,
type_name,
pic,
pid,
has_child from $database.test_shoptype_tree where 1=1"
}
import_tmp_showroom_total_eos(){
import_data tmp_showroom_total_eos " select 
RECORD_DATE,
SHOWROOM_IDENTITY,
TOTAL_WEIGHT from $database.tmp_showroom_total_eos where 1=1"
}
import_tykhgjb_eos(){
import_data tykhgjb_eos " select 
DjLsh,
DjBth,
DjState,
WDMC,
KHMC,
KHBM,
ZKH,
CSGS,
CRBS from $database.tykhgjb_eos where 1=1"
}
import_tykhgjh_eos(){
import_data tykhgjh_eos " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
GSWD,
TYKHMC,
TYKHBM,
WHR,
ZHWHSJ from $database.tykhgjh_eos where 1=1"
}
import_v_hw(){
import_data v_hw " select 
id,
customer_id,
customer_identity,
child_customer_identity,
child_customer_name,
child_customer_code,
child_customer_seq,
contact_name,
phone_no,
phone_no_b,
customer_address,
help_code,
active_flag,
legal_person,
id_code,
province,
data_date,
ty_customer_code,
djlsh,
djbth from $database.v_hw where 1=1"
}
import_view_customer(){
import_data view_customer " select 
wdmc,
customer_identity,
customer_code,
customer_name,
parent_customer_code,
parent_customer_name,
child_customer_name,
area_name,
province_name,
city_name,
county_name,
child_customer_code,
is_child,
active_flag,
is_supplier,
purity_name,
license_desc,
area_name_business from $database.view_customer where 1=1"
}
import_view_oa_customer_1(){
import_data view_oa_customer_1 " select 
customer_code,
customer_name,
child_customer_name,
bj,
gf,
lx,
qlzl,
wdmc
 from $database.view_oa_customer_1 where 1=1"
}
import_wdmlh(){
import_data wdmlh " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
QY,
kdwddm,
gdwddm,
wdbm,
wdmc,
wdfzr,
wdjc,
yyzt,
sjbm,
sjmc,
sjdm,
djsbm,
djsmc,
xsqbm,
xsqmc,
xslx,
wdlx,
pqbm,
pqmc,
lwdbm,
zjm,
zhwhrm,
DATE_FORMAT(zhwhrq,'%Y-%m-%d %H:%i:%s') zhwhrq,
gsbm,
gsmc,
glkc,
jsxs,
jkhbm,
psbz,
jcdw,
jbmbm,
kxkhbm,
lxdh,
txdz,
JLZ,
DATE_FORMAT(JLSJ,'%Y-%m-%d %H:%i:%s') JLSJ,
BTXS,
CKCZ,
EWMXS,
SDGSWD from $database.wdmlh where 1=1"
}
import_wgkhyhbh(){
import_data wgkhyhbh " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
DJH,
WDBM,
WDMC,
KHBM,
KHMC,
ZKHMC,
ZKHBH,
KHZK,
LJJGF,
ZDRID,
ZDR,
DATE_FORMAT(ZDSJ,'%Y-%m-%d %H:%i:%s') ZDSJ,
XGRID,
XGR,
DATE_FORMAT(XGSJ,'%Y-%m-%d %H:%i:%s') XGSJ,
replace(replace(BZ,'\n',''),'\t','') BZ,
ZQCE,
Z,
KHQY from $database.wgkhyhbh where 1=1"
}
import_wgpxgfbh(){
import_data wgpxgfbh " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
DJH,
WDBM,
WDMC,
CKBM,
CKMC,
PLBM,
ZJM,
PLMC,
EJPLBM,
EJPLMC,
EJPLZJM,
JBGF,
ZDRID,
ZDR,
DATE_FORMAT(ZDSJ,'%Y-%m-%d %H:%i:%s') ZDSJ,
XGRID,
XGR,
DATE_FORMAT(XGSJ,'%Y-%m-%d %H:%i:%s') XGSJ from $database.wgpxgfbh where 1=1"
}
import_wj(){
import_data wj " select 
xh,
sf,
khmc,
replace(replace(BZ,'\n',''),'\t','') bz,
zy,
zkhyy,
sfks,
sqqx,
xtkhmc,
xtzkhmc,
customer_identity from $database.wj where 1=1"
}
import_wz(){
import_data wz " select 
xh,
sf,
khmc,
bz,
zy,
zkhyy,
sfks,
sqqx,
xtkhmc,
xtzkhmc,
customer_identity,
expired_date from $database.wz where 1=1"
}
import_xltjh_eos(){
import_data xltjh_eos " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
WDMC,
KHBM,
KHMC,
ZKH from $database.xltjh_eos where 1=1"
}
import_xsdszb(){
import_data xsdszb " select 
DjLsh,
DjBth,
DjState,
BTXH,
cpbh,
ckmc,
KHBM,
KHMC,
ZKHB,
plmc,
YJPL,
EJPL,
jz,
jsbm,
JSMC,
jsb,
fjgf,
DZFJGF,
fjgfje,
replace(replace(BZ,'\n',''),'\t','') bz,
plbm,
bh,
csbm,
csmc,
cs,
btjs,
ckbm,
bzgf,
JSDH,
BZB,
SHD,
YCK,
SFGZ,
THDH,
THDJM,
CPBZT,
MZ,
JGF,
JGFJE,
YFJGF,
LJJJE,
PLJJGF from $database.xsdszb where 1=1"
}
import_xsdszf(){
import_data xsdszf " select 
DjLsh,
DjFth,
DjState,
LLDXH,
FTXH,
fs,
lldh,
CSMCF,
PLMCF,
JZF,
HLF,
QZJJF,
DJ,
gf,
gfje,
bzf,
cj,
WJJZ,
YJJZ,
FTJS,
llrq,
CSBMF,
PLBMF,
LLDJH,
ZXDJ,
ZDDJ,
ZDJCGF,
ZXJCGF,
LLJZ,
ZQGFBM,
ZQGFLX,
TCGF,
TCGFJE,
ZSGF,
ZSJE,
JCGF,
JCGFJE,
JSR,
JLJ from $database.xsdszf where 1=1"
}
import_xsdszh(){
import_data xsdszh " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
XSBZ,
XZZKH,
CZKH,
KHLLJZ,
KHLLJE,
KHTSDJH,
KHLLDJH,
KHTSGFJE,
TSJZHJ,
ZKHH,
djzt,
djh,
ZDBC,
SCSKDH,
cpbjh,
KHZJM,
bzh,
csbmh,
csmch,
hlH,
plmcH,
plbmh,
CZKHBM,
JSKH,
JSKHBM,
ZKH,
ZKHBM,
khlxr,
jjjz,
jjje,
qtfy,
fhlx,
rq,
zdr,
zdrid,
zdsj,
wdbm,
wdmc,
WDLX,
shr,
shrid,
shsj,
fjgfhj,
ckjzhj,
lljzhj,
ZQSJZHJ,
FYHJ,
JSHJ,
jehj,
llgfhj,
ZQLGFJE,
zqplbm,
ZQLJZHJ,
xjsq,
gsbm,
gsmc,
wfje,
yfje,
bths,
fths,
llhs,
ZQLXS,
ZQSXS,
jjhs,
jj,
WJJZXJ,
jsjzxj,
jsjexj,
ZFRQ,
DZGF,
DZGFH,
BQJEHJ,
ZJM,
DST,
YBF,
LXGF,
LXJJJE,
KHBH,
ZXBS,
DYCS,
DYSJ,
QY,
KXED,
LSED,
SPR,
YXKD,
KQZE,
BDZE,
KXZQ,
KQZL,
JJJ,
KXKHBM,
KX,
FJHS,
B2BXS,
ZQCE,
LJ,
GFH,
push_status from $database.xsdszh where 1=1"
}
import_xsdszh_history_eos(){
import_data xsdszh_history_eos " select 
tabName,
DATE_FORMAT(jsrq,'%Y-%m-%d %H:%i:%s') jsrq,
customer_code,
csmc from $database.xsdszh_history_eos where 1=1"
}
import_yflmxzh_eos(){
import_data yflmxzh_eos " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
WDMC,
khbm,
khmc,
lxr,
CSBM,
CSMC,
plbm,
plmc,
JZ,
khlx from $database.yflmxzh_eos where 1=1"
}
import_yfmxzh_eos(){
import_data yfmxzh_eos " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
WDMC,
khbm,
khmc,
ZKH,
LB,
je,
bb,
khlx,
zjm from $database.yfmxzh_eos where 1=1"
}
import_ygmlh(){
import_data ygmlh " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
czID,
ygxm,
FH070,
sswdbm,
sswdmc,
ssckbm,
ssckmc,
SSCKDM,
sskwbm,
sskwmc,
ssgsbm,
ssgsmc,
sswdlx,
sspqbm,
sskdwddm,
ssgdwddm,
sspqmc,
ddmm,
ddsy,
SSSJMC,
SSSJDM,
SSGC,
XGR,
XGSJ,
ZDR,
ZDSJ from $database.ygmlh where 1=1"
}
import_yjgfbh(){
import_data yjgfbh " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
WDBM,
WDMC,
KHMC,
KHBM,
ZJM,
ZKHH,
ZKH,
ZKHBH,
ZDR,
ZDRID,
DATE_FORMAT(ZDSJ,'%Y-%m-%d %H:%i:%s') ZDSJ,
ZHXGR,
SHRID,
DATE_FORMAT(SHSJ,'%Y-%m-%d %H:%i:%s') SHSJ,
BZ,
MRGF,
Z,
Z1,
ZQCE,
KHQY from $database.yjgfbh where 1=1"
}
import_ysmxzb_eos(){
import_data ysmxzb_eos " select 
djlsh,
djbth,
djstate,
DATE_FORMAT(rq,'%Y-%m-%d %H:%i:%s') rq,
djh,
djm,
swlb,
djje,
wfje,
yfje,
replace(replace(BZ,'\n',''),'\t','') bz,
DATE_FORMAT(zhskrq,'%Y-%m-%d %H:%i:%s') zhskrq,
csbm,
csmc,
plbm,
plmc,
dcwdmc,
fs,
jjje,
gfje,
DATE_FORMAT(hkshrq,'%Y-%m-%d %H:%i:%s') hkshrq,
ybf,
hkjsfs,
gylx from $database.ysmxzb_eos where 1=1"
}
import_ysmxzh_eos(){
import_data ysmxzh_eos " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
WDMC,
khbm,
khmc,
ZKH,
LB,
je,
bb,
khlx,
zjm,
YJKH from $database.ysmxzh_eos where 1=1"
}
import_zjyezh_eos(){
import_data zjyezh_eos " select 
DjLsh,
DjBtZdh,
DjFtZdh,
DjStZdh,
DjState,
DjCount,
gsmc,
ZH,
JE,
ZJLX,
YX,
YXZH
 from $database.zjyezh_eos where 1=1"
}
import_zy5g(){
import_data zy5g " select 
xh,
sf,
khmc,
replace(replace(BZ,'\n',''),'\t','') bz,
zy,
zkhyy,
sfks,
sqqx,
xtkhmc,
xtzkhmc,
customer_identity from $database.zy5g where 1=1"
}
import_zyyj(){
import_data zyyj " select 
xh,
sf,
khmc,
replace(replace(BZ,'\n',''),'\t','') bz,
zy,
zkhyy,
sfks,
sqqx,
xtkhmc,
xtzkhmc,
customer_identity from $database.zyyj where 1=1"
}
case $1 in
"t_sale_from")
	import_t_sale_from
	;;
"cpbszb")
import_cpbszb
;;
"cpbszh")
import_cpbszh
;;
"cwwykhb_eos")
import_cwwykhb_eos
;;
"cwwykhh_eos")
import_cwwykhh_eos
;;
"dkhhyb_eos")
import_dkhhyb_eos
;;
"dkhhyh_eos")
import_dkhhyh_eos
;;
"dydfkczbh")
import_dydfkczbh
;;
"fjgfzkbb")
import_fjgfzkbb
;;
"fjgfzkbh")
import_fjgfzkbh
;;
"gfjkhyhbb")
import_gfjkhyhbb
;;
"gfjkhyhbh")
import_gfjkhyhbh
;;
"gfjpxgfbh")
import_gfjpxgfbh
;;
"hjwwgcddb")
import_hjwwgcddb
;;
"hjwwgcddh")
import_hjwwgcddh
;;
"khlsedbh_eos")
import_khlsedbh_eos
;;
"khxxh")
import_khxxh
;;
"khxxszb")
import_khxxszb
;;
"khxxszh")
import_khxxszh
;;
"kjdswwrkdb")
import_kjdswwrkdb
;;
"kjdswwrkdh")
import_kjdswwrkdh
;;
"kjksbmxxh")
import_kjksbmxxh
;;
"kjxsgfb")
import_kjxsgfb
;;
"kjxsgfh")
import_kjxsgfh
;;
"ksdskcbh")
import_ksdskcbh
;;
"ksxxh")
import_ksxxh
;;
"kxjczbh_eos")
import_kxjczbh_eos
;;
"kxkskcbh")
import_kxkskcbh
;;
"llmxzh_eos")
import_llmxzh_eos
;;
"lscqmxbb_eos")
import_lscqmxbb_eos
;;
"lscqmxbh_eos")
import_lscqmxbh_eos
;;
"lsedzbh_eos")
import_lsedzbh_eos
;;
"mxzh_djlsh")
import_mxzh_djlsh
;;
"mxzh_hw")
import_mxzh_hw
;;
"oss_file")
import_oss_file
;;
"plxxh")
import_plxxh
;;
"plxxszb")
import_plxxszb
;;
"plxxszh")
import_plxxszh
;;
"plxxszs")
import_plxxszs
;;
"print_template")
import_print_template
;;
"qrtz_blob_triggers")
import_qrtz_blob_triggers
;;
"qrtz_calendars")
import_qrtz_calendars
;;
"qrtz_cron_triggers")
import_qrtz_cron_triggers
;;
"qrtz_fired_triggers")
import_qrtz_fired_triggers
;;
"qrtz_job_details")
import_qrtz_job_details
;;
"qrtz_locks")
import_qrtz_locks
;;
"qrtz_paused_trigger_grps")
import_qrtz_paused_trigger_grps
;;
"qrtz_scheduler_state")
import_qrtz_scheduler_state
;;
"qrtz_simple_triggers")
import_qrtz_simple_triggers
;;
"qrtz_simprop_triggers")
import_qrtz_simprop_triggers
;;
"qrtz_triggers")
import_qrtz_triggers
;;
"qyqxfph_eos")
import_qyqxfph_eos
;;
"qzj")
import_qzj
;;
"rp_category_daily_sale")
import_rp_category_daily_sale
;;
"rp_category_daily_sale_eos")
import_rp_category_daily_sale_eos
;;
"rp_category_hour_sale")
import_rp_category_hour_sale
;;
"rp_category_monthly_sale")
import_rp_category_monthly_sale
;;
"rp_category_monthly_sale_eos")
import_rp_category_monthly_sale_eos
;;
"rp_category_year_sale")
import_rp_category_year_sale
;;
"rp_category_year_sale_eos")
import_rp_category_year_sale_eos
;;
"rp_counter_category_daily_sale")
import_rp_counter_category_daily_sale
;;
"rp_counter_category_daily_sale_eos")
import_rp_counter_category_daily_sale_eos
;;
"rp_counter_category_hour_sale")
import_rp_counter_category_hour_sale
;;
"rp_counter_category_monthly_sale")
import_rp_counter_category_monthly_sale
;;
"rp_counter_category_monthly_sale_eos")
import_rp_counter_category_monthly_sale_eos
;;
"rp_counter_category_year_sale")
import_rp_counter_category_year_sale
;;
"rp_counter_category_year_sale_eos")
import_rp_counter_category_year_sale_eos
;;
"rp_counter_daily_sale")
import_rp_counter_daily_sale
;;
"rp_counter_daily_sale_eos")
import_rp_counter_daily_sale_eos
;;
"rp_counter_hour_sale")
import_rp_counter_hour_sale
;;
"rp_counter_monthly_sale")
import_rp_counter_monthly_sale
;;
"rp_counter_monthly_sale_eos")
import_rp_counter_monthly_sale_eos
;;
"rp_counter_year_sale")
import_rp_counter_year_sale
;;
"rp_counter_year_sale_eos")
import_rp_counter_year_sale_eos
;;
"rp_daily_counter_work")
import_rp_daily_counter_work
;;
"rp_daily_customer_buy")
import_rp_daily_customer_buy
;;
"rp_daily_customer_buy_eos")
import_rp_daily_customer_buy_eos
;;
"rp_daily_package_diff")
import_rp_daily_package_diff
;;
"rp_daily_package_diff_eos")
import_rp_daily_package_diff_eos
;;
"rp_daily_package_stay")
import_rp_daily_package_stay
;;
"rp_daily_package_stay_eos")
import_rp_daily_package_stay_eos
;;
"rp_daily_salesman")
import_rp_daily_salesman
;;
"rp_hour_counter_work")
import_rp_hour_counter_work
;;
"rp_hour_salesman")
import_rp_hour_salesman
;;
"rp_monthly_counter_work")
import_rp_monthly_counter_work
;;
"rp_monthly_customer_buy")
import_rp_monthly_customer_buy
;;
"rp_monthly_customer_buy_eos")
import_rp_monthly_customer_buy_eos
;;
"rp_monthly_salesman")
import_rp_monthly_salesman
;;
"rp_purity_daily_sale")
import_rp_purity_daily_sale
;;
"rp_purity_daily_sale_eos")
import_rp_purity_daily_sale_eos
;;
"rp_purity_hour_sale")
import_rp_purity_hour_sale
;;
"rp_purity_monthly_sale")
import_rp_purity_monthly_sale
;;
"rp_purity_monthly_sale_eos")
import_rp_purity_monthly_sale_eos
;;
"rp_purity_weekly_sale")
import_rp_purity_weekly_sale
;;
"rp_purity_year_sale")
import_rp_purity_year_sale
;;
"rp_purity_year_sale_eos")
import_rp_purity_year_sale_eos
;;
"rp_sales_data_eos")
import_rp_sales_data_eos
;;
"rp_sales_data_eos_sync")
import_rp_sales_data_eos_sync
;;
"rp_showroom_hour_record")
import_rp_showroom_hour_record
;;
"rp_szztkhrxsbb")
import_rp_szztkhrxsbb
;;
"rp_szztxsrb")
import_rp_szztxsrb
;;
"rp_time_code")
import_rp_time_code
;;
"rp_today_customer_buy")
import_rp_today_customer_buy
;;
"rp_total_package_stay")
import_rp_total_package_stay
;;
"rp_total_package_stay_eos")
import_rp_total_package_stay_eos
;;
"rp_year_counter_work")
import_rp_year_counter_work
;;
"rp_year_customer_buy")
import_rp_year_customer_buy
;;
"rp_year_customer_buy_eos")
import_rp_year_customer_buy_eos
;;
"rp_year_salesman")
import_rp_year_salesman
;;
"spxxkczh")
import_spxxkczh
;;
"sys_announcement")
import_sys_announcement
;;
"sys_announcement_send")
import_sys_announcement_send
;;
"sys_batch_log")
import_sys_batch_log
;;
"sys_category")
import_sys_category
;;
"sys_check_rule")
import_sys_check_rule
;;
"sys_data_log")
import_sys_data_log
;;
"sys_data_source")
import_sys_data_source
;;
"sys_depart")
import_sys_depart
;;
"sys_depart_permission")
import_sys_depart_permission
;;
"sys_depart_role")
import_sys_depart_role
;;
"sys_depart_role_permission")
import_sys_depart_role_permission
;;
"sys_depart_role_user")
import_sys_depart_role_user
;;
"sys_dict")
import_sys_dict
;;
"sys_dict_item")
import_sys_dict_item
;;
"sys_email")
import_sys_email
;;
"sys_fill_rule")
import_sys_fill_rule
;;
"sys_gateway_route")
import_sys_gateway_route
;;
"sys_job")
import_sys_job
;;
"sys_log")
import_sys_log
;;
"sys_permission")
import_sys_permission
;;
"sys_permission_202207102237")
import_sys_permission_202207102237
;;
"sys_permission_data_rule")
import_sys_permission_data_rule
;;
"sys_position")
import_sys_position
;;
"sys_quartz_job")
import_sys_quartz_job
;;
"sys_role")
import_sys_role
;;
"sys_role_permission")
import_sys_role_permission
;;
"sys_send_email")
import_sys_send_email
;;
"sys_sms")
import_sys_sms
;;
"sys_sms_template")
import_sys_sms_template
;;
"sys_system_config")
import_sys_system_config
;;
"sys_user")
import_sys_user
;;
"sys_user_agent")
import_sys_user_agent
;;
"sys_user_depart")
import_sys_user_depart
;;
"sys_user_job")
import_sys_user_job
;;
"sys_user_role")
import_sys_user_role
;;
"szkhcqlxzzb_eos")
import_szkhcqlxzzb_eos
;;
"szkhcqlxzzf_eos")
import_szkhcqlxzzf_eos
;;
"szkhcqlxzzh_eos")
import_szkhcqlxzzh_eos
;;
"szkhcqmxb_eos")
import_szkhcqmxb_eos
;;
"szkhcqmxf_eos")
import_szkhcqmxf_eos
;;
"szkhcqmxh_eos")
import_szkhcqmxh_eos
;;
"szywqyhfb_eos")
import_szywqyhfb_eos
;;
"szywqyhff_eos")
import_szywqyhff_eos
;;
"szywqyhfh_eos")
import_szywqyhfh_eos
;;
"t_approve_record")
import_t_approve_record
;;
"t_auto_export")
import_t_auto_export
;;
"t_b_menu")
import_t_b_menu
;;
"t_basic_purity")
import_t_basic_purity
;;
"t_batch_approve_temp")
import_t_batch_approve_temp
;;
"t_bf_account_type_category")
import_t_bf_account_type_category
;;
"t_bf_aging_gold_price_basics")
import_t_bf_aging_gold_price_basics
;;
"t_bf_aging_gold_price_maintain_bill")
import_t_bf_aging_gold_price_maintain_bill
;;
"t_bf_allocate_transfer")
import_t_bf_allocate_transfer
;;
"t_bf_allocation_fee")
import_t_bf_allocation_fee
;;
"t_bf_allocation_fee_add_price")
import_t_bf_allocation_fee_add_price
;;
"t_bf_ancient_law_cus_discount")
import_t_bf_ancient_law_cus_discount
;;
"t_bf_ancient_law_cus_discount_detail")
import_t_bf_ancient_law_cus_discount_detail
;;
"t_bf_area")
import_t_bf_area
;;
"t_bf_bank_deposit_bill_sz")
import_t_bf_bank_deposit_bill_sz
;;
"t_bf_bank_deposit_bill_sz_detail")
import_t_bf_bank_deposit_bill_sz_detail
;;
"t_bf_buy_cus_item")
import_t_bf_buy_cus_item
;;
"t_bf_buy_cus_item_detail")
import_t_bf_buy_cus_item_detail
;;
"t_bf_buy_cus_material")
import_t_bf_buy_cus_material
;;
"t_bf_buy_cus_material_detail")
import_t_bf_buy_cus_material_detail
;;
"t_bf_buyback_material")
import_t_bf_buyback_material
;;
"t_bf_change_outsource")
import_t_bf_change_outsource
;;
"t_bf_change_outsource_detail")
import_t_bf_change_outsource_detail
;;
"t_bf_change_purity")
import_t_bf_change_purity
;;
"t_bf_collect_money_account")
import_t_bf_collect_money_account
;;
"t_bf_collect_money_style")
import_t_bf_collect_money_style
;;
"t_bf_current_wholesale_gold_price")
import_t_bf_current_wholesale_gold_price
;;
"t_bf_current_wholesale_gold_price_history")
import_t_bf_current_wholesale_gold_price_history
;;
"t_bf_current_wholesale_gold_price_history_detail")
import_t_bf_current_wholesale_gold_price_history_detail
;;
"t_bf_cus_credit_receipt")
import_t_bf_cus_credit_receipt
;;
"t_bf_cus_credit_receipt_detail")
import_t_bf_cus_credit_receipt_detail
;;
"t_bf_cus_debit_receipt")
import_t_bf_cus_debit_receipt
;;
"t_bf_cus_debit_receipt_detail")
import_t_bf_cus_debit_receipt_detail
;;
"t_bf_cus_debit_receipt_record")
import_t_bf_cus_debit_receipt_record
;;
"t_bf_cust_return_jewelry")
import_t_bf_cust_return_jewelry
;;
"t_bf_cust_return_jewelry_detail")
import_t_bf_cust_return_jewelry_detail
;;
"t_bf_customer_credit_base")
import_t_bf_customer_credit_base
;;
"t_bf_customer_the_bill")
import_t_bf_customer_the_bill
;;
"t_bf_deliver_goods_from")
import_t_bf_deliver_goods_from
;;
"t_bf_deliver_goods_from_detail")
import_t_bf_deliver_goods_from_detail
;;
"t_bf_dkhhy_b")
import_t_bf_dkhhy_b
;;
"t_bf_dkhhy_h")
import_t_bf_dkhhy_h
;;
"t_bf_dzddydy")
import_t_bf_dzddydy
;;
"t_bf_financial_block_list")
import_t_bf_financial_block_list
;;
"t_bf_five_g_cus_discount")
import_t_bf_five_g_cus_discount
;;
"t_bf_gold_inlay_transfer_in")
import_t_bf_gold_inlay_transfer_in
;;
"t_bf_gold_inlay_transfer_in_detail")
import_t_bf_gold_inlay_transfer_in_detail
;;
"t_bf_gold_inlay_transfer_out")
import_t_bf_gold_inlay_transfer_out
;;
"t_bf_gold_inlay_transfer_out_detail")
import_t_bf_gold_inlay_transfer_out_detail
;;
"t_bf_gold_transfer_change")
import_t_bf_gold_transfer_change
;;
"t_bf_gold_transfer_change_detail")
import_t_bf_gold_transfer_change_detail
;;
"t_bf_gold_transfer_in")
import_t_bf_gold_transfer_in
;;
"t_bf_gold_transfer_in_detail")
import_t_bf_gold_transfer_in_detail
;;
"t_bf_gold_transfer_out")
import_t_bf_gold_transfer_out
;;
"t_bf_gold_transfer_out_detail")
import_t_bf_gold_transfer_out_detail
;;
"t_bf_gold_transfer_out_print")
import_t_bf_gold_transfer_out_print
;;
"t_bf_gold_transfer_out_print_detail")
import_t_bf_gold_transfer_out_print_detail
;;
"t_bf_hard_gold_cus_discount")
import_t_bf_hard_gold_cus_discount
;;
"t_bf_hard_gold_default_work_fee")
import_t_bf_hard_gold_default_work_fee
;;
"t_bf_hard_gold_work_fee")
import_t_bf_hard_gold_work_fee
;;
"t_bf_initial_inventory_bill")
import_t_bf_initial_inventory_bill
;;
"t_bf_inlaid_metal_average_daily")
import_t_bf_inlaid_metal_average_daily
;;
"t_bf_interest_st_adj_item")
import_t_bf_interest_st_adj_item
;;
"t_bf_khlsedb")
import_t_bf_khlsedb
;;
"t_bf_material_explain")
import_t_bf_material_explain
;;
"t_bf_other_showroom_customer_block_list")
import_t_bf_other_showroom_customer_block_list
;;
"t_bf_pay_cus_material")
import_t_bf_pay_cus_material
;;
"t_bf_pay_cus_material_detail")
import_t_bf_pay_cus_material_detail
;;
"t_bf_pay_outsource")
import_t_bf_pay_outsource
;;
"t_bf_pay_outsource_detail")
import_t_bf_pay_outsource_detail
;;
"t_bf_payment_order")
import_t_bf_payment_order
;;
"t_bf_payment_order_detail")
import_t_bf_payment_order_detail
;;
"t_bf_purify")
import_t_bf_purify
;;
"t_bf_purify_detail")
import_t_bf_purify_detail
;;
"t_bf_raw_material")
import_t_bf_raw_material
;;
"t_bf_ready_money")
import_t_bf_ready_money
;;
"t_bf_receive_meterial")
import_t_bf_receive_meterial
;;
"t_bf_receive_meterial_detail")
import_t_bf_receive_meterial_detail
;;
"t_bf_remark")
import_t_bf_remark
;;
"t_bf_repair")
import_t_bf_repair
;;
"t_bf_retreat")
import_t_bf_retreat
;;
"t_bf_sales_ticket_print_zds")
import_t_bf_sales_ticket_print_zds
;;
"t_bf_sales_ticket_print_zds_detail")
import_t_bf_sales_ticket_print_zds_detail
;;
"t_bf_settlement")
import_t_bf_settlement
;;
"t_bf_settlement_adjustment_price")
import_t_bf_settlement_adjustment_price
;;
"t_bf_stock_transfer_bill")
import_t_bf_stock_transfer_bill
;;
"t_bf_stock_transfer_bill_detail")
import_t_bf_stock_transfer_bill_detail
;;
"t_bf_stock_transfer_bill_detail_hw")
import_t_bf_stock_transfer_bill_detail_hw
;;
"t_bf_stock_transfer_bill_hw")
import_t_bf_stock_transfer_bill_hw
;;
"t_bf_szztgzspd")
import_t_bf_szztgzspd
;;
"t_bf_szztgzspd_detail")
import_t_bf_szztgzspd_detail
;;
"t_bf_temporary_money_form")
import_t_bf_temporary_money_form
;;
"t_bf_the_bill")
import_t_bf_the_bill
;;
"t_bf_transfer_owed_work_fee_change")
import_t_bf_transfer_owed_work_fee_change
;;
"t_bf_transfer_owed_work_fee_change_detail")
import_t_bf_transfer_owed_work_fee_change_detail
;;
"t_bf_transfer_owed_work_fee_from")
import_t_bf_transfer_owed_work_fee_from
;;
"t_bf_transfer_owed_work_fee_input")
import_t_bf_transfer_owed_work_fee_input
;;
"t_bf_transfer_owed_work_fee_input_bak_0702")
import_t_bf_transfer_owed_work_fee_input_bak_0702
;;
"t_bf_transfer_owed_work_fee_input_detail")
import_t_bf_transfer_owed_work_fee_input_detail
;;
"t_bf_transfer_owed_work_fee_input_detail_bak")
import_t_bf_transfer_owed_work_fee_input_detail_bak
;;
"t_bf_transfer_owed_work_fee_input_detail_bak_0702")
import_t_bf_transfer_owed_work_fee_input_detail_bak_0702
;;
"t_bf_transfer_type")
import_t_bf_transfer_type
;;
"t_bf_warehouse_type")
import_t_bf_warehouse_type
;;
"t_bf_weighing_form")
import_t_bf_weighing_form
;;
"t_bf_weighing_form_appendage")
import_t_bf_weighing_form_appendage
;;
"t_bf_weighing_form_appendage_check")
import_t_bf_weighing_form_appendage_check
;;
"t_bf_weighing_form_check")
import_t_bf_weighing_form_check
;;
"t_bf_weighing_form_detail")
import_t_bf_weighing_form_detail
;;
"t_bf_weighing_form_detail_check")
import_t_bf_weighing_form_detail_check
;;
"t_bf_with_sign")
import_t_bf_with_sign
;;
"t_bf_xq_single_return")
import_t_bf_xq_single_return
;;
"t_bf_xq_single_return_detail")
import_t_bf_xq_single_return_detail
;;
"t_buyer")
import_t_buyer
;;
"t_category")
import_t_category
;;
"t_category_classify")
import_t_category_classify
;;
"t_category_counter_info")
import_t_category_counter_info
;;
"t_category_labour")
import_t_category_labour
;;
"t_category_labour_error_bak")
import_t_category_labour_error_bak
;;
"t_check_account")
import_t_check_account
;;
"t_check_account_detail")
import_t_check_account_detail
;;
"t_check_counter")
import_t_check_counter
;;
"t_check_quality_detial")
import_t_check_quality_detial
;;
"t_check_quality_status")
import_t_check_quality_status
;;
"t_child_customer")
import_t_child_customer
;;
"t_child_customer_bdiff")
import_t_child_customer_bdiff
;;
"t_child_customer_bsame")
import_t_child_customer_bsame
;;
"t_child_customer_id_djbth")
import_t_child_customer_id_djbth
;;
"t_client_discount")
import_t_client_discount
;;
"t_columns")
import_t_columns
;;
"t_counter_account")
import_t_counter_account
;;
"t_counter_account_5ga")
import_t_counter_account_5ga
;;
"t_counter_like")
import_t_counter_like
;;
"t_counter_message")
import_t_counter_message
;;
"t_counter_sale_plan")
import_t_counter_sale_plan
;;
"t_cover_customer_log")
import_t_cover_customer_log
;;
"t_cpbszb")
import_t_cpbszb
;;
"t_cpbszb_log")
import_t_cpbszb_log
;;
"t_cpbszh")
import_t_cpbszh
;;
"t_cpbszh_log")
import_t_cpbszh_log
;;
"t_cpbszh_log_detail")
import_t_cpbszh_log_detail
;;
"t_custom_column")
import_t_custom_column
;;
"t_customer")
import_t_customer
;;
"t_customer_additional")
import_t_customer_additional
;;
"t_customer_alliance")
import_t_customer_alliance
;;
"t_customer_authorizetopay")
import_t_customer_authorizetopay
;;
"t_customer_base")
import_t_customer_base
;;
"t_customer_buyer")
import_t_customer_buyer
;;
"t_customer_counter_fastout")
import_t_customer_counter_fastout
;;
"t_customer_discount")
import_t_customer_discount
;;
"t_customer_discount_detail")
import_t_customer_discount_detail
;;
"t_customer_discount_detail_hs")
import_t_customer_discount_detail_hs
;;
"t_customer_discount_hjxq_temp")
import_t_customer_discount_hjxq_temp
;;
"t_customer_discount_hs")
import_t_customer_discount_hs
;;
"t_customer_discount_kjxq_temp")
import_t_customer_discount_kjxq_temp
;;
"t_customer_discount_sync")
import_t_customer_discount_sync
;;
"t_customer_engrave")
import_t_customer_engrave
;;
"t_customer_exhibitsales_sync")
import_t_customer_exhibitsales_sync
;;
"t_customer_gemset_discount")
import_t_customer_gemset_discount
;;
"t_customer_gemset_discount_fail")
import_t_customer_gemset_discount_fail
;;
"t_customer_gemset_discount_history")
import_t_customer_gemset_discount_history
;;
"t_customer_icon")
import_t_customer_icon
;;
"t_customer_license")
import_t_customer_license
;;
"t_customer_phone_cp")
import_t_customer_phone_cp
;;
"t_customer_phone_sync")
import_t_customer_phone_sync
;;
"t_customer_require_time")
import_t_customer_require_time
;;
"t_customer_salesman")
import_t_customer_salesman
;;
"t_customer_tag")
import_t_customer_tag
;;
"t_customer_type")
import_t_customer_type
;;
"t_customer_wait")
import_t_customer_wait
;;
"t_daily_interrest_err_log")
import_t_daily_interrest_err_log
;;
"t_daily_interrest_log")
import_t_daily_interrest_log
;;
"t_default_discount_mosaic")
import_t_default_discount_mosaic
;;
"t_delay_region")
import_t_delay_region
;;
"t_delay_task")
import_t_delay_task
;;
"t_delay_task_detail")
import_t_delay_task_detail
;;
"t_deposit_delivery")
import_t_deposit_delivery
;;
"t_deposit_jewelry")
import_t_deposit_jewelry
;;
"t_deposit_order")
import_t_deposit_order
;;
"t_deposit_setting")
import_t_deposit_setting
;;
"t_djjz_procedure_excute_err_log")
import_t_djjz_procedure_excute_err_log
;;
"t_download")
import_t_download
;;
"t_email_config")
import_t_email_config
;;
"t_eos_fail")
import_t_eos_fail
;;
"t_eos_order")
import_t_eos_order
;;
"t_eos_order_detial")
import_t_eos_order_detial
;;
"t_estimate_update_log")
import_t_estimate_update_log
;;
"t_fast_counter")
import_t_fast_counter
;;
"t_fast_cus")
import_t_fast_cus
;;
"t_fast_customer")
import_t_fast_customer
;;
"t_fast_customer_log")
import_t_fast_customer_log
;;
"t_fast_customer_queue")
import_t_fast_customer_queue
;;
"t_fast_item")
import_t_fast_item
;;
"t_fast_order")
import_t_fast_order
;;
"t_fast_order_purity")
import_t_fast_order_purity
;;
"t_fast_package")
import_t_fast_package
;;
"t_fast_package_delete")
import_t_fast_package_delete
;;
"t_fast_package_engrave")
import_t_fast_package_engrave
;;
"t_fast_package_flowing")
import_t_fast_package_flowing
;;
"t_fast_package_i")
import_t_fast_package_i
;;
"t_fast_package_i_plastic")
import_t_fast_package_i_plastic
;;
"t_fast_package_i_product")
import_t_fast_package_i_product
;;
"t_fast_package_operation_log")
import_t_fast_package_operation_log
;;
"t_fast_package_reason")
import_t_fast_package_reason
;;
"t_fast_package_record")
import_t_fast_package_record
;;
"t_fast_package_status")
import_t_fast_package_status
;;
"t_fast_package_tag")
import_t_fast_package_tag
;;
"t_fast_package_temporary")
import_t_fast_package_temporary
;;
"t_fast_package_update_customer")
import_t_fast_package_update_customer
;;
"t_fast_technology_price")
import_t_fast_technology_price
;;
"t_finance_customer_info")
import_t_finance_customer_info
;;
"t_finance_customer_relation")
import_t_finance_customer_relation
;;
"t_fjgfzkbb_sync")
import_t_fjgfzkbb_sync
;;
"t_fjgfzkbh_sync")
import_t_fjgfzkbh_sync
;;
"t_gemstone_attribute")
import_t_gemstone_attribute
;;
"t_genus")
import_t_genus
;;
"t_gf_area_customer")
import_t_gf_area_customer
;;
"t_history_data_move_log")
import_t_history_data_move_log
;;
"t_hw_model_fee")
import_t_hw_model_fee
;;
"t_incoming_difference")
import_t_incoming_difference
;;
"t_incoming_maintain")
import_t_incoming_maintain
;;
"t_initial_package_update_customer")
import_t_initial_package_update_customer
;;
"t_initial_weight")
import_t_initial_weight
;;
"t_initial_weight_delete")
import_t_initial_weight_delete
;;
"t_initial_weight_record")
import_t_initial_weight_record
;;
"t_initial_weight_status")
import_t_initial_weight_status
;;
"t_insert_log_fail")
import_t_insert_log_fail
;;
"t_invalid_combined")
import_t_invalid_combined
;;
"t_ka_kxjczb")
import_t_ka_kxjczb
;;
"t_ka_lllsz")
import_t_ka_lllsz
;;
"t_ka_llmxz_b")
import_t_ka_llmxz_b
;;
"t_ka_llmxz_h")
import_t_ka_llmxz_h
;;
"t_ka_llmxz_s")
import_t_ka_llmxz_s
;;
"t_ka_lscqmxb_b")
import_t_ka_lscqmxb_b
;;
"t_ka_lscqmxb_h")
import_t_ka_lscqmxb_h
;;
"t_ka_lscqmxb_s")
import_t_ka_lscqmxb_s
;;
"t_ka_lsedzb")
import_t_ka_lsedzb
;;
"t_ka_lsz_h")
import_t_ka_lsz_h
;;
"t_ka_mxz")
import_t_ka_mxz
;;
"t_ka_mxz_bak20220802")
import_t_ka_mxz_bak20220802
;;
"t_ka_mxz_update")
import_t_ka_mxz_update
;;
"t_ka_spkcmxz")
import_t_ka_spkcmxz
;;
"t_ka_splsz")
import_t_ka_splsz
;;
"t_ka_splsz_20220720")
import_t_ka_splsz_20220720
;;
"t_ka_splsz_bak202200728")
import_t_ka_splsz_bak202200728
;;
"t_ka_splsz_bak202207")
import_t_ka_splsz_bak202207
;;
"t_ka_splsz_hw")
import_t_ka_splsz_hw
;;
"t_ka_szdzsqdh")
import_t_ka_szdzsqdh
;;
"t_ka_szdzsqdh_temp")
import_t_ka_szdzsqdh_temp
;;
"t_ka_szkhcqlxzz_b")
import_t_ka_szkhcqlxzz_b
;;
"t_ka_szkhcqlxzz_b_history")
import_t_ka_szkhcqlxzz_b_history
;;
"t_ka_szkhcqlxzz_f")
import_t_ka_szkhcqlxzz_f
;;
"t_ka_szkhcqlxzz_f_history")
import_t_ka_szkhcqlxzz_f_history
;;
"t_ka_szkhcqlxzz_h")
import_t_ka_szkhcqlxzz_h
;;
"t_ka_szkhcqlxzz_h_20220727")
import_t_ka_szkhcqlxzz_h_20220727
;;
"t_ka_szkhcqlxzz_h_history")
import_t_ka_szkhcqlxzz_h_history
;;
"t_ka_szkhcqlxzzfb_h")
import_t_ka_szkhcqlxzzfb_h
;;
"t_ka_szkhcqmx_b")
import_t_ka_szkhcqmx_b
;;
"t_ka_szkhcqmx_b_2022081918")
import_t_ka_szkhcqmx_b_2022081918
;;
"t_ka_szkhcqmx_f")
import_t_ka_szkhcqmx_f
;;
"t_ka_szkhcqmx_f_2022081918")
import_t_ka_szkhcqmx_f_2022081918
;;
"t_ka_szkhcqmx_h")
import_t_ka_szkhcqmx_h
;;
"t_ka_szkhcqmx_h_2022081918")
import_t_ka_szkhcqmx_h_2022081918
;;
"t_ka_szlxjsrq")
import_t_ka_szlxjsrq
;;
"t_ka_xltj_b")
import_t_ka_xltj_b
;;
"t_ka_xltj_h")
import_t_ka_xltj_h
;;
"t_ka_yfllsz")
import_t_ka_yfllsz
;;
"t_ka_yflmxz")
import_t_ka_yflmxz
;;
"t_ka_yflsz")
import_t_ka_yflsz
;;
"t_ka_yfmxz")
import_t_ka_yfmxz
;;
"t_ka_yfrzzh")
import_t_ka_yfrzzh
;;
"t_ka_yfrzzh_bak20220729")
import_t_ka_yfrzzh_bak20220729
;;
"t_ka_yfrzzh_bak20220815")
import_t_ka_yfrzzh_bak20220815
;;
"t_ka_yfrzzh_hw")
import_t_ka_yfrzzh_hw
;;
"t_ka_yhrq")
import_t_ka_yhrq
;;
"t_ka_yslsz")
import_t_ka_yslsz
;;
"t_ka_ysmxz_b")
import_t_ka_ysmxz_b
;;
"t_ka_ysmxz_h")
import_t_ka_ysmxz_h
;;
"t_ka_ysmxz_s")
import_t_ka_ysmxz_s
;;
"t_ka_ysmxz_sold")
import_t_ka_ysmxz_sold
;;
"t_ka_zjlsz")
import_t_ka_zjlsz
;;
"t_ka_zjyez")
import_t_ka_zjyez
;;
"t_ka_zrye")
import_t_ka_zrye
;;
"t_ka_zrye_alter")
import_t_ka_zrye_alter
;;
"t_ka_ztkcrzz")
import_t_ka_ztkcrzz
;;
"t_ka_ztkcrzz_2022083018")
import_t_ka_ztkcrzz_2022083018
;;
"t_ka_ztkcrzz_2022083111")
import_t_ka_ztkcrzz_2022083111
;;
"t_ka_ztkcrzz_2022083115")
import_t_ka_ztkcrzz_2022083115
;;
"t_ka_ztkcrzz_2022090111")
import_t_ka_ztkcrzz_2022090111
;;
"t_ka_ztkczz")
import_t_ka_ztkczz
;;
"t_ka_ztkczz_2022083115")
import_t_ka_ztkczz_2022083115
;;
"t_ka_ztkczz_2022090111")
import_t_ka_ztkczz_2022090111
;;
"t_khxxszb")
import_t_khxxszb
;;
"t_khxxszb_sync")
import_t_khxxszb_sync
;;
"t_khxxszh")
import_t_khxxszh
;;
"t_khxxszh_sync")
import_t_khxxszh_sync
;;
"t_kj_child_customer")
import_t_kj_child_customer
;;
"t_kj_customer")
import_t_kj_customer
;;
"t_kj_khxxb")
import_t_kj_khxxb
;;
"t_kj_khxxh")
import_t_kj_khxxh
;;
"t_late_transfer_log")
import_t_late_transfer_log
;;
"t_login_log")
import_t_login_log
;;
"t_main_item")
import_t_main_item
;;
"t_material_price_rule")
import_t_material_price_rule
;;
"t_metal_color_info")
import_t_metal_color_info
;;
"t_move_counter")
import_t_move_counter
;;
"t_move_counter_0705")
import_t_move_counter_0705
;;
"t_move_counter_bak20220728")
import_t_move_counter_bak20220728
;;
"t_move_counter_detail")
import_t_move_counter_detail
;;
"t_move_counter_detail_bak20220728")
import_t_move_counter_detail_bak20220728
;;
"t_move_counter_detail_hw")
import_t_move_counter_detail_hw
;;
"t_move_counter_hw")
import_t_move_counter_hw
;;
"t_mxzh")
import_t_mxzh
;;
"t_package_engrave_tag")
import_t_package_engrave_tag
;;
"t_package_stay_weight_customer")
import_t_package_stay_weight_customer
;;
"t_packing_paper")
import_t_packing_paper
;;
"t_phone")
import_t_phone
;;
"t_physical_counter")
import_t_physical_counter
;;
"t_print_log")
import_t_print_log
;;
"t_product_basic_info")
import_t_product_basic_info
;;
"t_product_fee")
import_t_product_fee
;;
"t_product_model_basic")
import_t_product_model_basic
;;
"t_product_model_discount")
import_t_product_model_discount
;;
"t_product_model_fee")
import_t_product_model_fee
;;
"t_product_package")
import_t_product_package
;;
"t_province_salesman")
import_t_province_salesman
;;
"t_purity")
import_t_purity
;;
"t_purity_engrave")
import_t_purity_engrave
;;
"t_purity_tag")
import_t_purity_tag
;;
"t_qc")
import_t_qc
;;
"t_qc_detial")
import_t_qc_detial
;;
"t_queue_factory")
import_t_queue_factory
;;
"t_reason_dictionaries")
import_t_reason_dictionaries
;;
"t_reason_dictionaries_harmful")
import_t_reason_dictionaries_harmful
;;
"t_receive")
import_t_receive
;;
"t_receive_allocation")
import_t_receive_allocation
;;
"t_receive_allocation_detail")
import_t_receive_allocation_detail
;;
"t_receive_check_account")
import_t_receive_check_account
;;
"t_receive_check_account_detail")
import_t_receive_check_account_detail
;;
"t_receive_detail_small")
import_t_receive_detail_small
;;
"t_receive_detial")
import_t_receive_detial
;;
"t_receive_detial_reword")
import_t_receive_detial_reword
;;
"t_receive_detial_work_fee")
import_t_receive_detial_work_fee
;;
"t_receive_difference_detail")
import_t_receive_difference_detail
;;
"t_receive_eos_order_purity")
import_t_receive_eos_order_purity
;;
"t_receive_eos_order_records")
import_t_receive_eos_order_records
;;
"t_receive_eos_order_records_copy1")
import_t_receive_eos_order_records_copy1
;;
"t_receive_flgfbh")
import_t_receive_flgfbh
;;
"t_receive_order")
import_t_receive_order
;;
"t_receive_payment_code_info")
import_t_receive_payment_code_info
;;
"t_receive_purity_mapping")
import_t_receive_purity_mapping
;;
"t_receive_purity_mapping_copy1")
import_t_receive_purity_mapping_copy1
;;
"t_receive_status")
import_t_receive_status
;;
"t_receive_stream_type")
import_t_receive_stream_type
;;
"t_sale_from")
import_t_sale_from
;;
"t_sale_from_account")
import_t_sale_from_account
;;
"t_sale_from_account_detail")
import_t_sale_from_account_detail
;;
"t_sale_from_detail")
import_t_sale_from_detail
;;
"t_sale_from_invalid")
import_t_sale_from_invalid
;;
"t_sale_settlement_type")
import_t_sale_settlement_type
;;
"t_sale_summary_sync")
import_t_sale_summary_sync
;;
"t_sales_return")
import_t_sales_return
;;
"t_sales_return_detial")
import_t_sales_return_detial
;;
"t_sales_return_this_count")
import_t_sales_return_this_count
;;
"t_salesman")
import_t_salesman
;;
"t_salesman_area")
import_t_salesman_area
;;
"t_salesman_choose_log")
import_t_salesman_choose_log
;;
"t_salesman_depart")
import_t_salesman_depart
;;
"t_salesman_log")
import_t_salesman_log
;;
"t_salesman_role")
import_t_salesman_role
;;
"t_salesman_time_log")
import_t_salesman_time_log
;;
"t_salesman_time_out")
import_t_salesman_time_out
;;
"t_scale")
import_t_scale
;;
"t_settlement_stay")
import_t_settlement_stay
;;
"t_showroom")
import_t_showroom
;;
"t_showroom_counter")
import_t_showroom_counter
;;
"t_showroom_counter_second")
import_t_showroom_counter_second
;;
"t_showroom_package")
import_t_showroom_package
;;
"t_showroom_package_i")
import_t_showroom_package_i
;;
"t_showroom_role")
import_t_showroom_role
;;
"t_showroom_sale_plan")
import_t_showroom_sale_plan
;;
"t_showroom_storage_data")
import_t_showroom_storage_data
;;
"t_showroom_storage_data_copy1")
import_t_showroom_storage_data_copy1
;;
"t_special_style_discount")
import_t_special_style_discount
;;
"t_splszh")
import_t_splszh
;;
"t_splszh_log")
import_t_splszh_log
;;
"t_stock")
import_t_stock
;;
"t_stored_procedure_log")
import_t_stored_procedure_log
;;
"t_stored_procedure_status")
import_t_stored_procedure_status
;;
"t_supplier")
import_t_supplier
;;
"t_supplier_detial")
import_t_supplier_detial
;;
"t_supplier_rebate")
import_t_supplier_rebate
;;
"t_sync_customer")
import_t_sync_customer
;;
"t_sync_table")
import_t_sync_table
;;
"t_sync_time")
import_t_sync_time
;;
"t_synchronization_customer_log")
import_t_synchronization_customer_log
;;
"t_szpxgfjcbh")
import_t_szpxgfjcbh
;;
"t_technology_purity")
import_t_technology_purity
;;
"t_temp_customer_transform")
import_t_temp_customer_transform
;;
"t_temp_interest_adjust_money_record")
import_t_temp_interest_adjust_money_record
;;
"t_temp_lllsz")
import_t_temp_lllsz
;;
"t_temp_showroom_sales_data")
import_t_temp_showroom_sales_data
;;
"t_temp_trans_history")
import_t_temp_trans_history
;;
"t_temp_ysmxz")
import_t_temp_ysmxz
;;
"t_temp_ywy")
import_t_temp_ywy
;;
"t_tran_miss_package")
import_t_tran_miss_package
;;
"t_tykhgjb")
import_t_tykhgjb
;;
"t_tykhgjh")
import_t_tykhgjh
;;
"t_tykhgjh_sync")
import_t_tykhgjh_sync
;;
"t_user")
import_t_user
;;
"t_user_counter")
import_t_user_counter
;;
"t_user_role")
import_t_user_role
;;
"t_wechat_message_log")
import_t_wechat_message_log
;;
"t_wechat_pub")
import_t_wechat_pub
;;
"t_wechat_smallroutine")
import_t_wechat_smallroutine
;;
"t_wholesaling_category_info")
import_t_wholesaling_category_info
;;
"t_work_fee_detail")
import_t_work_fee_detail
;;
"t_xcx_kfrx")
import_t_xcx_kfrx
;;
"t_zx_customer")
import_t_zx_customer
;;
"temp_csmc")
import_temp_csmc
;;
"temp_customer_hw")
import_temp_customer_hw
;;
"temp_eos_sales_data")
import_temp_eos_sales_data
;;
"test_demo")
import_test_demo
;;
"test_enhance_select")
import_test_enhance_select
;;
"test_order_main")
import_test_order_main
;;
"test_order_product")
import_test_order_product
;;
"test_person")
import_test_person
;;
"test_shoptype_tree")
import_test_shoptype_tree
;;
"tmp_showroom_total_eos")
import_tmp_showroom_total_eos
;;
"tykhgjb_eos")
import_tykhgjb_eos
;;
"tykhgjh_eos")
import_tykhgjh_eos
;;
"v_hw")
import_v_hw
;;
"view_customer")
import_view_customer
;;
"view_oa_customer_1")
import_view_oa_customer_1
;;
"wdmlh")
import_wdmlh
;;
"wgkhyhbh")
import_wgkhyhbh
;;
"wgpxgfbh")
import_wgpxgfbh
;;
"wj")
import_wj
;;
"wz")
import_wz
;;
"xltjh_eos")
import_xltjh_eos
;;
"xsdszb")
import_xsdszb
;;
"xsdszf")
import_xsdszf
;;
"xsdszh")
import_xsdszh
;;
"xsdszh_history_eos")
import_xsdszh_history_eos
;;
"yflmxzh_eos")
import_yflmxzh_eos
;;
"yfmxzh_eos")
import_yfmxzh_eos
;;
"ygmlh")
import_ygmlh
;;
"yjgfbh")
import_yjgfbh
;;
"ysmxzb_eos")
import_ysmxzb_eos
;;
"ysmxzh_eos")
import_ysmxzh_eos
;;
"zjyezh_eos")
import_zjyezh_eos
;;
"zy5g")
import_zy5g
;;
"zyyj")
import_zyyj
;;	
"all")
import_cpbszb
import_cpbszh
import_cwwykhb_eos
import_cwwykhh_eos
import_dkhhyb_eos
import_dkhhyh_eos
import_dydfkczbh
import_fjgfzkbb
import_fjgfzkbh
import_gfjkhyhbb
import_gfjkhyhbh
import_gfjpxgfbh
import_hjwwgcddb
import_hjwwgcddh
import_khlsedbh_eos
import_khxxh
import_khxxszb
import_khxxszh
import_kjdswwrkdb
import_kjdswwrkdh
import_kjksbmxxh
import_kjxsgfb
import_kjxsgfh
import_ksdskcbh
import_ksxxh
import_kxjczbh_eos
import_kxkskcbh
import_llmxzh_eos
import_lscqmxbb_eos
import_lscqmxbh_eos
import_lsedzbh_eos
import_mxzh_djlsh
import_mxzh_hw
import_oss_file
import_plxxh
import_plxxszb
import_plxxszh
import_plxxszs
import_print_template
import_qrtz_blob_triggers
import_qrtz_calendars
import_qrtz_cron_triggers
import_qrtz_fired_triggers
import_qrtz_job_details
import_qrtz_locks
import_qrtz_paused_trigger_grps
import_qrtz_scheduler_state
import_qrtz_simple_triggers
import_qrtz_simprop_triggers
import_qrtz_triggers
import_qyqxfph_eos
import_qzj
import_rp_category_daily_sale
import_rp_category_daily_sale_eos
import_rp_category_hour_sale
import_rp_category_monthly_sale
import_rp_category_monthly_sale_eos
import_rp_category_year_sale
import_rp_category_year_sale_eos
import_rp_counter_category_daily_sale
import_rp_counter_category_daily_sale_eos
import_rp_counter_category_hour_sale
import_rp_counter_category_monthly_sale
import_rp_counter_category_monthly_sale_eos
import_rp_counter_category_year_sale
import_rp_counter_category_year_sale_eos
import_rp_counter_daily_sale
import_rp_counter_daily_sale_eos
import_rp_counter_hour_sale
import_rp_counter_monthly_sale
import_rp_counter_monthly_sale_eos
import_rp_counter_year_sale
import_rp_counter_year_sale_eos
import_rp_daily_counter_work
import_rp_daily_customer_buy
import_rp_daily_customer_buy_eos
import_rp_daily_package_diff
import_rp_daily_package_diff_eos
import_rp_daily_package_stay
import_rp_daily_package_stay_eos
import_rp_daily_salesman
import_rp_hour_counter_work
import_rp_hour_salesman
import_rp_monthly_counter_work
import_rp_monthly_customer_buy
import_rp_monthly_customer_buy_eos
import_rp_monthly_salesman
import_rp_purity_daily_sale
import_rp_purity_daily_sale_eos
import_rp_purity_hour_sale
import_rp_purity_monthly_sale
import_rp_purity_monthly_sale_eos
import_rp_purity_weekly_sale
import_rp_purity_year_sale
import_rp_purity_year_sale_eos
import_rp_sales_data_eos
import_rp_sales_data_eos_sync
import_rp_showroom_hour_record
import_rp_szztkhrxsbb
import_rp_szztxsrb
import_rp_time_code
import_rp_today_customer_buy
import_rp_total_package_stay
import_rp_total_package_stay_eos
import_rp_year_counter_work
import_rp_year_customer_buy
import_rp_year_customer_buy_eos
import_rp_year_salesman
import_spxxkczh
import_sys_announcement
import_sys_announcement_send
import_sys_batch_log
import_sys_category
import_sys_check_rule
import_sys_data_log
import_sys_data_source
import_sys_depart
import_sys_depart_permission
import_sys_depart_role
import_sys_depart_role_permission
import_sys_depart_role_user
import_sys_dict
import_sys_dict_item
import_sys_email
import_sys_fill_rule
import_sys_gateway_route
import_sys_job
import_sys_log
import_sys_permission
import_sys_permission_202207102237
import_sys_permission_data_rule
import_sys_position
import_sys_quartz_job
import_sys_role
import_sys_role_permission
import_sys_send_email
import_sys_sms
import_sys_sms_template
import_sys_system_config
import_sys_user
import_sys_user_agent
import_sys_user_depart
import_sys_user_job
import_sys_user_role
import_szkhcqlxzzb_eos
import_szkhcqlxzzf_eos
import_szkhcqlxzzh_eos
import_szkhcqmxb_eos
import_szkhcqmxf_eos
import_szkhcqmxh_eos
import_szywqyhfb_eos
import_szywqyhff_eos
import_szywqyhfh_eos
import_t_approve_record
import_t_auto_export
import_t_b_menu
import_t_basic_purity
import_t_batch_approve_temp
import_t_bf_account_type_category
import_t_bf_aging_gold_price_basics
import_t_bf_aging_gold_price_maintain_bill
import_t_bf_allocate_transfer
import_t_bf_allocation_fee
import_t_bf_allocation_fee_add_price
import_t_bf_ancient_law_cus_discount
import_t_bf_ancient_law_cus_discount_detail
import_t_bf_area
import_t_bf_bank_deposit_bill_sz
import_t_bf_bank_deposit_bill_sz_detail
import_t_bf_buy_cus_item
import_t_bf_buy_cus_item_detail
import_t_bf_buy_cus_material
import_t_bf_buy_cus_material_detail
import_t_bf_buyback_material
import_t_bf_change_outsource
import_t_bf_change_outsource_detail
import_t_bf_change_purity
import_t_bf_collect_money_account
import_t_bf_collect_money_style
import_t_bf_current_wholesale_gold_price
import_t_bf_current_wholesale_gold_price_history
import_t_bf_current_wholesale_gold_price_history_detail
import_t_bf_cus_credit_receipt
import_t_bf_cus_credit_receipt_detail
import_t_bf_cus_debit_receipt
import_t_bf_cus_debit_receipt_detail
import_t_bf_cus_debit_receipt_record
import_t_bf_cust_return_jewelry
import_t_bf_cust_return_jewelry_detail
import_t_bf_customer_credit_base
import_t_bf_customer_the_bill
import_t_bf_deliver_goods_from
import_t_bf_deliver_goods_from_detail
import_t_bf_dkhhy_b
import_t_bf_dkhhy_h
import_t_bf_dzddydy
import_t_bf_financial_block_list
import_t_bf_five_g_cus_discount
import_t_bf_gold_inlay_transfer_in
import_t_bf_gold_inlay_transfer_in_detail
import_t_bf_gold_inlay_transfer_out
import_t_bf_gold_inlay_transfer_out_detail
import_t_bf_gold_transfer_change
import_t_bf_gold_transfer_change_detail
import_t_bf_gold_transfer_in
import_t_bf_gold_transfer_in_detail
import_t_bf_gold_transfer_out
import_t_bf_gold_transfer_out_detail
import_t_bf_gold_transfer_out_print
import_t_bf_gold_transfer_out_print_detail
import_t_bf_hard_gold_cus_discount
import_t_bf_hard_gold_default_work_fee
import_t_bf_hard_gold_work_fee
import_t_bf_initial_inventory_bill
import_t_bf_inlaid_metal_average_daily
import_t_bf_interest_st_adj_item
import_t_bf_khlsedb
import_t_bf_material_explain
import_t_bf_other_showroom_customer_block_list
import_t_bf_pay_cus_material
import_t_bf_pay_cus_material_detail
import_t_bf_pay_outsource
import_t_bf_pay_outsource_detail
import_t_bf_payment_order
import_t_bf_payment_order_detail
import_t_bf_purify
import_t_bf_purify_detail
import_t_bf_raw_material
import_t_bf_ready_money
import_t_bf_receive_meterial
import_t_bf_receive_meterial_detail
import_t_bf_remark
import_t_bf_repair
import_t_bf_retreat
import_t_bf_sales_ticket_print_zds
import_t_bf_sales_ticket_print_zds_detail
import_t_bf_settlement
import_t_bf_settlement_adjustment_price
import_t_bf_stock_transfer_bill
import_t_bf_stock_transfer_bill_detail
import_t_bf_stock_transfer_bill_detail_hw
import_t_bf_stock_transfer_bill_hw
import_t_bf_szztgzspd
import_t_bf_szztgzspd_detail
import_t_bf_temporary_money_form
import_t_bf_the_bill
import_t_bf_transfer_owed_work_fee_change
import_t_bf_transfer_owed_work_fee_change_detail
import_t_bf_transfer_owed_work_fee_from
import_t_bf_transfer_owed_work_fee_input
import_t_bf_transfer_owed_work_fee_input_bak_0702
import_t_bf_transfer_owed_work_fee_input_detail
import_t_bf_transfer_owed_work_fee_input_detail_bak
import_t_bf_transfer_owed_work_fee_input_detail_bak_0702
import_t_bf_transfer_type
import_t_bf_warehouse_type
import_t_bf_weighing_form
import_t_bf_weighing_form_appendage
import_t_bf_weighing_form_appendage_check
import_t_bf_weighing_form_check
import_t_bf_weighing_form_detail
import_t_bf_weighing_form_detail_check
import_t_bf_with_sign
import_t_bf_xq_single_return
import_t_bf_xq_single_return_detail
import_t_buyer
import_t_category
import_t_category_classify
import_t_category_counter_info
import_t_category_labour
import_t_category_labour_error_bak
import_t_check_account
import_t_check_account_detail
import_t_check_counter
import_t_check_quality_detial
import_t_check_quality_status
import_t_child_customer
import_t_child_customer_bdiff
import_t_child_customer_bsame
import_t_child_customer_id_djbth
import_t_client_discount
import_t_columns
import_t_counter_account
import_t_counter_account_5ga
import_t_counter_like
import_t_counter_message
import_t_counter_sale_plan
import_t_cover_customer_log
import_t_cpbszb
import_t_cpbszb_log
import_t_cpbszh
import_t_cpbszh_log
import_t_cpbszh_log_detail
import_t_custom_column
import_t_customer
import_t_customer_additional
import_t_customer_alliance
import_t_customer_authorizetopay
import_t_customer_base
import_t_customer_buyer
import_t_customer_counter_fastout
import_t_customer_discount
import_t_customer_discount_detail
import_t_customer_discount_detail_hs
import_t_customer_discount_hjxq_temp
import_t_customer_discount_hs
import_t_customer_discount_kjxq_temp
import_t_customer_discount_sync
import_t_customer_engrave
import_t_customer_exhibitsales_sync
import_t_customer_gemset_discount
import_t_customer_gemset_discount_fail
import_t_customer_gemset_discount_history
import_t_customer_icon
import_t_customer_license
import_t_customer_phone_cp
import_t_customer_phone_sync
import_t_customer_require_time
import_t_customer_salesman
import_t_customer_tag
import_t_customer_type
import_t_customer_wait
import_t_daily_interrest_err_log
import_t_daily_interrest_log
import_t_default_discount_mosaic
import_t_delay_region
import_t_delay_task
import_t_delay_task_detail
import_t_deposit_delivery
import_t_deposit_jewelry
import_t_deposit_order
import_t_deposit_setting
import_t_djjz_procedure_excute_err_log
import_t_download
import_t_email_config
import_t_eos_fail
import_t_eos_order
import_t_eos_order_detial
import_t_estimate_update_log
import_t_fast_counter
import_t_fast_cus
import_t_fast_customer
import_t_fast_customer_log
import_t_fast_customer_queue
import_t_fast_item
import_t_fast_order
import_t_fast_order_purity
import_t_fast_package
import_t_fast_package_delete
import_t_fast_package_engrave
import_t_fast_package_flowing
import_t_fast_package_i
import_t_fast_package_i_plastic
import_t_fast_package_i_product
import_t_fast_package_operation_log
import_t_fast_package_reason
import_t_fast_package_record
import_t_fast_package_status
import_t_fast_package_tag
import_t_fast_package_temporary
import_t_fast_package_update_customer
import_t_fast_technology_price
import_t_finance_customer_info
import_t_finance_customer_relation
import_t_fjgfzkbb_sync
import_t_fjgfzkbh_sync
import_t_gemstone_attribute
import_t_genus
import_t_gf_area_customer
import_t_history_data_move_log
import_t_hw_model_fee
import_t_incoming_difference
import_t_incoming_maintain
import_t_initial_package_update_customer
import_t_initial_weight
import_t_initial_weight_delete
import_t_initial_weight_record
import_t_initial_weight_status
import_t_insert_log_fail
import_t_invalid_combined
import_t_ka_kxjczb
import_t_ka_lllsz
import_t_ka_llmxz_b
import_t_ka_llmxz_h
import_t_ka_llmxz_s
import_t_ka_lscqmxb_b
import_t_ka_lscqmxb_h
import_t_ka_lscqmxb_s
import_t_ka_lsedzb
import_t_ka_lsz_h
import_t_ka_mxz
import_t_ka_mxz_bak20220802
import_t_ka_mxz_update
import_t_ka_spkcmxz
import_t_ka_splsz
import_t_ka_splsz_20220720
import_t_ka_splsz_bak202200728
import_t_ka_splsz_bak202207
import_t_ka_splsz_hw
import_t_ka_szdzsqdh
import_t_ka_szdzsqdh_temp
import_t_ka_szkhcqlxzz_b
import_t_ka_szkhcqlxzz_b_history
import_t_ka_szkhcqlxzz_f
import_t_ka_szkhcqlxzz_f_history
import_t_ka_szkhcqlxzz_h
import_t_ka_szkhcqlxzz_h_20220727
import_t_ka_szkhcqlxzz_h_history
import_t_ka_szkhcqlxzzfb_h
import_t_ka_szkhcqmx_b
import_t_ka_szkhcqmx_b_2022081918
import_t_ka_szkhcqmx_f
import_t_ka_szkhcqmx_f_2022081918
import_t_ka_szkhcqmx_h
import_t_ka_szkhcqmx_h_2022081918
import_t_ka_szlxjsrq
import_t_ka_xltj_b
import_t_ka_xltj_h
import_t_ka_yfllsz
import_t_ka_yflmxz
import_t_ka_yflsz
import_t_ka_yfmxz
import_t_ka_yfrzzh
import_t_ka_yfrzzh_bak20220729
import_t_ka_yfrzzh_bak20220815
import_t_ka_yfrzzh_hw
import_t_ka_yhrq
import_t_ka_yslsz
import_t_ka_ysmxz_b
import_t_ka_ysmxz_h
import_t_ka_ysmxz_s
import_t_ka_ysmxz_sold
import_t_ka_zjlsz
import_t_ka_zjyez
import_t_ka_zrye
import_t_ka_zrye_alter
import_t_ka_ztkcrzz
import_t_ka_ztkcrzz_2022083018
import_t_ka_ztkcrzz_2022083111
import_t_ka_ztkcrzz_2022083115
import_t_ka_ztkcrzz_2022090111
import_t_ka_ztkczz
import_t_ka_ztkczz_2022083115
import_t_ka_ztkczz_2022090111
import_t_khxxszb
import_t_khxxszb_sync
import_t_khxxszh
import_t_khxxszh_sync
import_t_kj_child_customer
import_t_kj_customer
import_t_kj_khxxb
import_t_kj_khxxh
import_t_late_transfer_log
import_t_login_log
import_t_main_item
import_t_material_price_rule
import_t_metal_color_info
import_t_move_counter
import_t_move_counter_0705
import_t_move_counter_bak20220728
import_t_move_counter_detail
import_t_move_counter_detail_bak20220728
import_t_move_counter_detail_hw
import_t_move_counter_hw
import_t_mxzh
import_t_package_engrave_tag
import_t_package_stay_weight_customer
import_t_packing_paper
import_t_phone
import_t_physical_counter
import_t_print_log
import_t_product_basic_info
import_t_product_fee
import_t_product_model_basic
import_t_product_model_discount
import_t_product_model_fee
import_t_product_package
import_t_province_salesman
import_t_purity
import_t_purity_engrave
import_t_purity_tag
import_t_qc
import_t_qc_detial
import_t_queue_factory
import_t_reason_dictionaries
import_t_reason_dictionaries_harmful
import_t_receive
import_t_receive_allocation
import_t_receive_allocation_detail
import_t_receive_check_account
import_t_receive_check_account_detail
import_t_receive_detail_small
import_t_receive_detial
import_t_receive_detial_reword
import_t_receive_detial_work_fee
import_t_receive_difference_detail
import_t_receive_eos_order_purity
import_t_receive_eos_order_records
import_t_receive_eos_order_records_copy1
import_t_receive_flgfbh
import_t_receive_order
import_t_receive_payment_code_info
import_t_receive_purity_mapping
import_t_receive_purity_mapping_copy1
import_t_receive_status
import_t_receive_stream_type
import_t_sale_from
import_t_sale_from_account
import_t_sale_from_account_detail
import_t_sale_from_detail
import_t_sale_from_invalid
import_t_sale_settlement_type
import_t_sale_summary_sync
import_t_sales_return
import_t_sales_return_detial
import_t_sales_return_this_count
import_t_salesman
import_t_salesman_area
import_t_salesman_choose_log
import_t_salesman_depart
import_t_salesman_log
import_t_salesman_role
import_t_salesman_time_log
import_t_salesman_time_out
import_t_scale
import_t_settlement_stay
import_t_showroom
import_t_showroom_counter
import_t_showroom_counter_second
import_t_showroom_package
import_t_showroom_package_i
import_t_showroom_role
import_t_showroom_sale_plan
import_t_showroom_storage_data
import_t_showroom_storage_data_copy1
import_t_special_style_discount
import_t_splszh
import_t_splszh_log
import_t_stock
import_t_stored_procedure_log
import_t_stored_procedure_status
import_t_supplier
import_t_supplier_detial
import_t_supplier_rebate
import_t_sync_customer
import_t_sync_table
import_t_sync_time
import_t_synchronization_customer_log
import_t_szpxgfjcbh
import_t_technology_purity
import_t_temp_customer_transform
import_t_temp_interest_adjust_money_record
import_t_temp_lllsz
import_t_temp_showroom_sales_data
import_t_temp_trans_history
import_t_temp_ysmxz
import_t_temp_ywy
import_t_tran_miss_package
import_t_tykhgjb
import_t_tykhgjh
import_t_tykhgjh_sync
import_t_user
import_t_user_counter
import_t_user_role
import_t_wechat_message_log
import_t_wechat_pub
import_t_wechat_smallroutine
import_t_wholesaling_category_info
import_t_work_fee_detail
import_t_xcx_kfrx
import_t_zx_customer
import_temp_csmc
import_temp_customer_hw
import_temp_eos_sales_data
import_test_demo
import_test_enhance_select
import_test_order_main
import_test_order_product
import_test_person
import_test_shoptype_tree
import_tmp_showroom_total_eos
import_tykhgjb_eos
import_tykhgjh_eos
import_v_hw
import_view_customer
import_view_oa_customer_1
import_wdmlh
import_wgkhyhbh
import_wgpxgfbh
import_wj
import_wz
import_xltjh_eos
import_xsdszb
import_xsdszf
import_xsdszh
import_xsdszh_history_eos
import_yflmxzh_eos
import_yfmxzh_eos
import_ygmlh
import_yjgfbh
import_ysmxzb_eos
import_ysmxzh_eos
import_zjyezh_eos
import_zy5g
import_zyyj
	;;
esac