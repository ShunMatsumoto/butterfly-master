class LessonsController < ApplicationController

  before_action :set_lesson, only: [:edit, :update]

  def index
  end

  def new
    @lesson = Lesson.new
    @lesson.users << current_user
  end


  def create
    @lesson = Lesson.new(lesson_params)
    if @lesson.save
      redirect_to root_path, notice: "レッスンを作成しました"
    else
      render :new
    end
  end


  def edit
  end


  def update
      if @lesson.update(lesson_params)
        redirect_to lesson_messages_path(@lesson), notice: "レッスンを更新しました"
      else
        render :edit
      end
  end

  private

  def lesson_params
  params.require(:lesson).permit(:name, user_ids: [] )
  end

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

end
