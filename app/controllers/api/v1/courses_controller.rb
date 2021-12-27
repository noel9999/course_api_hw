class Api::V1::CoursesController < ApiController
  before_action :find_course, except: %w(index create)

  def index
    @courses = Course.includes(chapters: :lessons).page(params[:page]).per(params[:per_page])
  end

  def create
    @course = Course.create!(course_params)
    render :show, status: :created
  end

  def update
    @course.update!(course_params)
    # unlock this if we want to get the right order for chapters and lesson of that course after updating, but we would get another extra query. Or just try to fetch the course by SHOW or INDEX api
    # @course.reload
    render :show, status: :ok
  end

  def destroy
    @course.destroy!
    head :ok
  end

  def show
  end

  private

  def find_course
    @course = Course.includes(chapters: :lessons).find(params[:id])
  end

  def course_params
    params.permit(:title, :mentor_title, :description,
                  chapters_attributes: [:id, :title, :order, :_destroy,
                    lessons_attributes: [:id, :title, :description, :content, :order, :_destroy]])

  end
end
