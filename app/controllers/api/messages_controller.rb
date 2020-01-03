class Api::MessagesController < ApplicationController  # 名前空間(namespace)同名のクラス名を区別する。ディレクトリの違いでの判別は出来ないので名前空間を使用する
  def index
    lesson = Lesson.find(params[:lesson_id])           # ルーティングの設定によりparamsの中にlesson_idというキーでlessonのidが入っているので、これも元にDBからレッスンを取得する
    last_message_id = params[:id].to_i                 # ajaxで送られてくる最後のメッセージのidを変数に代入
                                                                                  # whereメソッド(任意のデータベースから任意の条件を指定し、条件に当てはまるレコードをすべて取得する。全てなので配列[]で返される)
    @messages = lesson.messages.includes(:user).where("id > #{last_message_id}")  # 取得したレッスンでのメッセージ達から、idがlast_message_idより新しい（大きい）メッセージ達のみ取得
  end
end