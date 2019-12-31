class MessagesController < ApplicationController

  before_action :set_lesson

  def index
    @message = Message.new
    @messages = @lesson.messages.includes(:user)
  end

  def create
    @message = @lesson.messages.new(message_params)
    if @message.save
      respond_to do |format|
        format.html { redirect_to lesson_messages_path(@lesson), notice: "メッセージが送信されました" }
        format.json
      end
    else
      @messages = @lesson.message.includes(:user)
      flash.now[:alert] = "メッセージを入力してください"
      render :index
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end

  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end

end
