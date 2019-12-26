# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

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
