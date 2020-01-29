# README

## 使用技術
Ruby 2.5.1/
Ruby on Rails 5.0.7.2/
MySQL 5.6.43/
Haml 5.1.2/
Sass 3.7.4/
jQuery 3.4.1/
Github

## リンク
https://butterfly-master.herokuapp.com/

## ログイン方法
・mail_address : ss@ss
・password : ssssssss

## アプリ画像
<img width="1440" alt="butterfly-master1" src="https://user-images.githubusercontent.com/58409647/73324518-94f38d00-428e-11ea-8f4c-3c4248d6cb01.png">

<img width="1440" alt="butterfly-master2" src="https://user-images.githubusercontent.com/58409647/73324629-ec91f880-428e-11ea-995f-1e42e11ff6b4.png">

## アプリ説明
アニメ「デジモンアドベンチャー」の主題歌「Butter-Fly」のギターパートを弾けるようになろう！というアプリです。
ギター演奏をお教えする活動をしており、人気の曲でしたので教則アプリを作ってしまった方が、たくさんの人に届けられると考え、実装しました。

## 機能
・１曲をセクションが毎に分けて動画を用いて解説しています。動画はYouTubeに私がアップロードしたものを埋め込んでいます。
原曲を演奏しているご本人様からも、「素晴らしい解説」とお墨付きを頂いているので、内容は保証します！

・各セクションにメッセージ機能を実装しており、非同期通信で行えますので動画を流しながら送信が可能です・

・ダウンロード機能を実装し、練習に必要な音源をダウンロードできるように致しました。

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|
|mail|string|null: false, unique: true|

### Association
- has_many :messages
- has_many :lesson_users
- has_many :lessons, through: lesson_users



## lessonsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|

### Association
- has_many :messages
- has_many :lesson_users
- has_many :users, through: lesson_users



## lesson_useraテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|lesson_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :lesson



## messages
|Column|Type|Options|
|------|----|-------|
|content|string|----|
|user_id|integer|null: false, foreign_key: true|
|lesson_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :lesson
