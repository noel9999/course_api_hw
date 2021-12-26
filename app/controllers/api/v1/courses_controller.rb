class Api::V1::CoursesController < ApiController
  before_action :find_course, except: %w(index)

  def index
    @courses = Course.includes(chapters: :lessons).page(params[:page]).per(params[:per_page])
  end

  def create

  end

  def update

  end

  def destroy

  end

  def show

  end

  private

  def find_course
    @course = Course.includes(chapters: :lessons).find(params[:id])
  end
end
