require "rails_helper"

describe MessagesController do
  let(:lesson) { create(:lesson) }   # letを使ってテストで使用するインスタンスを定義(複数のexamplで同一のインスタンスを使いたいとき)
  let(:user) { create(:user) }

  describe "#index" do
    
    #contextを使ってログインしている場合としていない場合とで場合分け
    context "log in" do
      before do               # before == before_actionみたいな感じ
        login user    # ログインする. このloginメソッドはcontroller_macros.rbで定義したやつ
        get :index, params: { lesson_id: lesson.id }  # 擬似的にindexアクションを動かすリクエストを行う
                                                      # messagesのルーティングはlessonsにネストしているためlesson_idを含ませてパスを生成する
      end

      it "assigns @message" do
        expect(assigns(:message)).to be_a_new(Message)   # assignsメソッドはコントローラーのインスタンス変数をテストするメソッド。@messageを確認したいのでassigns(:message)と記述している
      end                                                #be_a_newマッチャを利用することで、 対象が引数で指定したクラスのインスタンスかつ未保存のレコードであるかどうか確かめることができる
      
      it "assigns @lesson" do
        expect(assigns(:lesson)).to eq lesson    # eqマッチャを利用してassigns(:group)とgroupが同一であることを確かめることでる
      end

      it "renders index" do
        expect(response).to render_template :index    # responseは、example内でリクエストが行われた後の遷移先のビューの情報を持つインスタンス
                                                      # render_templateマッチャは引数にアクション名を取り、引数で指定されたアクションがリクエストされた時に自動的に遷移するビューを返す
      end
    end

    context "not log in" do
      before do
        get :index, params: { lesson_id: lesson.id }
      end

      it "redirect to new_user_session_path" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "#create" do
    let(:params) { { lesson_id: lesson.id, user_id: user.id, message: attributes_for(:message) } }
    # letメソッドでparamsを定義。

    context "log in" do   # contextでログインの有無で条件分岐
      before do
        login user
      end

      context "can save" do    # contextの中でさらに保存の成功、失敗で条件分岐。
        subject {
          post :create,
          params: params
        }

        it "count up message" do
          expect { subject }.to change(Message, :count).by(1)  # changeマッチャは引数が変化したかどうかを確かめる=createに成功したらテーブルのレコードが増えるため
        end

        it "redirects to lesson_message_path" do   # createアクションを動かした際のリダイレクト
          subject
          expect(response).to redirect_to(lesson_messages_path(lesson))
        end
      end

      context "can not save" do
        let(:invalid_params) { { lesson_id: lesson.id, user_id: user.id, message: attributes_for(:message, content: nil) } }

        subject {
          post :create,
          params: invalid_params
        }

        it "does not count up" do
          expect{ subject }.not_to change(Message, :count)
        end

        it "renders index" do
          subject
          expect(response).to render_template :index
        end
      end
    end

    context "not log in" do
      
      it "redirects to new_user_session_path" do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end