# 減色ディザリングスクリプト ver[1.1.0]
![result](https://github.com/5PB-3-4/beRL_scripts2/blob/main/dither/demo/reduction_dither_sample.png)

## ◆このスクリプトは何？
1ピクセル単位で配列ディザリング（ベイヤー法）をします。出力後は8bitカラーになります。

Aviutl1のディザリングスクリプトの移植版となります。

<br>

## ◆導入方法
AviUtl2のScriptフォルダに@berlsフォルダを入れてください。

<br>

## ◆機能のご紹介
移植にあったって機能について一部変更点がございます。

### 〇追加
- HSV減色機能
- 減色時のサンプリング方法

### 〇変更
- ベイヤー配列の次数(トラックバー bayerの値)の最大値を4に変更

### 〇削除
- マップ指定機能

<br>

## ◆注意点
- ベイヤーマップについては`generate_bayer_map.py`を用いて生成しています。ご利用にはnumpy, opencv-pythonパッケージが必要です。

<br>

## ▼バグ
- ver1.1 ('25/7/28)
  - 階調パラメータがすべて2、SamplingパラメータがCenterの時、正しくディザリングされない場合がある。
  - 階調パラメータのどれかが2、DitherパラメータがHSVのとき、正しくディザリングされない場合がある。

<br>

---
## ▼バグ報告等の連絡先はこちら
- Twitter : [@blue_beRL](https://twitter.com/blue_beRL)
- misskey : [@blue_beRL](https://misskey.io/@blue_beRL)
