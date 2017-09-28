# mongo 命令行导出数据

### easiest

```shell
mongoexport -d scorpio_dev -c tags --out ./tag0906.json --jsonArray
```

### json

```bash
mongoexport -d scorpio_dev -c movies --query '{selectStatus: "selected"}' --out ./movie0906.json --pretty --jsonArray

mongoexport -h 172.19.88.39:27017 -d BackfireV2 -c medias --query '{media:"tv"}' --out ./Desktop/tvorigindata.json --pretty --jsonArray
```

- `-h` 地址
- `-d` 数据库
- `-c` collection
- `—query` 查询
- `—out` 文件名
- `—pretty` 格式化
- `—jsonArray` 导出的文件为数组形式

### csv

```shell
mongoexport -d scorpio_dev -c movies --query '{selectStatus: "selected"}' --type=csv --out ./movie0906.csv --fields _id,title,detailScore.eduValue
```

- `—type=csv`
- `—fields`

### mongodump 与 mongorestore 

导出数据 -d 表示数据库 -o 表示导出到的dir

```
mongodump -d scorpio_dev -o ./Desktop/scorpio_dev_lq
```

对应导入至数据库 -d 表示导入的数据库 —dir 表示数据所在目录

```
mongorestore -d scorpio_dev_0928 --dir ./Desktop/scorpio_dev_lq
```