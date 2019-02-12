# pfaedle by Docker
OpenStreetMapのデータからGTFSのshapes.txtを作成するソフトウェア[pfaedle](https://github.com/ad-freiburg/pfaedle)をDockerに乗せたものです。ビルド済みのためすぐ使い始めることができます。

# How to use
## 元となるshapes.txtの準備
通過するバス停同士を直線で接続したshapes.txtを用意してください。
これをベースに付近の道路を探索して自動的に道路に沿ったshapes.txtが生成されます。
trips.txtへの`shape_id`の指定も忘れないでください。

## 元データの用意
ベースにするOSMのデータを取得します。[GEOFABRIK](http://download.geofabrik.de/)からダウンロードするのが簡単です。bz2形式でダウンロードされるので、下記コマンドで展開しておきます。関東地方の例を示しましたが、ファイル名は適宜変更してください。展開後のディレクトリの様子も示します。

```bash
$ mkdir pfaedle_files
$ cd pfaedle_files
$ wget http://download.geofabrik.de/asia/japan/kanto-latest.osm.bz2
$ bunzip2 kanto-latest.osm.bz2
$ ls
kanto-latest.osm.bz2
```

続いて元になるGTFSファイルを準備します。こちらもダウンロードしてZipファイルを展開するだけです。以下の説明は`GTFS`ディレクトリの中にGTFSの各種`txt`ファイルが存在している前提で話を進めます。

```bash
$ wget https://example.com/GTFS.zip
$ unzip GTFS.zip
$ ls
GTFS  kanto-latest.osm.bz2
$ ls GTFS
agency.txt           fare_rules.txt       stop_times.txt
agency_jp.txt        feed_info.txt        stops.txt
calendar.txt         routes.txt           translations.txt
calendar_dates.txt   routes_jp.txt        trips.txt
fare_attributes.txt  shapes.txt
```

## Dockerイメージの準備
下記コマンドにより、Dockerイメージを取得します。

```bash
$ docker image pull aruneko/pfaedle:latest
```

## shapes.txtの生成
下記コマンドでDockerコンテナを起動し、pfaedleでshapes.txtを生成できます。生成された一連のGTFSファイルは`gtfs-out`ディレクトリに出力されます。

```bash
$ docker container run -it --rm -v $(pwd):/source aruneko/pfaedle:latest pfaedle -x kanto-latest.osm GTFS
$ ls gtfs-out
agency.txt           fare_rules.txt       stop_times.txt
calendar.txt         feed_info.txt        stops.txt
calendar_dates.txt   routes.txt           trips.txt
fare_attributes.txt  shapes.txt
```

