require "rails_helper"

RSpec.describe Message, type: :model do
  describe "#create" do

    # メッセージが保存出来る場合
    context "can save" do                      #contextは特定の条件でテストをグループ分けしたい時に使う
      it "is valid with content" do
        expect(build(:message)).to be_valid    #ファクトリーで定義が完了しているため、build(:message)でMessageモデルのインスタンスを生成出来る
      end                                      #デフォルトではcontentの値は定義されているので値がない場合を定義するときは、content: nilを記述
    end

    #メッセージが保存できない場合
    context "can not save" do
      it "is invalid without content" do
        message = build(:message, content: nil)
        message.valid?                                                #作成したインスタンスがバリデーションに引っかかって保存できない状態をチェックするときはvalid?メソッドを使う
        expect(message.errors[:content]).to include("can't be blank")  #valid?メソッドを利用したインスタンスに対してerrorsメソッドを使用することで、バリデーションにより保存できない場合、何故できないのかを確認することが出来る
      end

      it "is invalid without lesson_id" do
        message = build(:message, lesson_id: nil)
        message.valid?
        expect(message.errors[:lesson]).to include("must exist")  #:lessonはカラム名
      end

      it "is invalid without use_id" do
        message = build(:message, user_id: nil)
        message.valid?
        expect(message.errors[:user]).to include("must exist")
      end
    end
  end
end