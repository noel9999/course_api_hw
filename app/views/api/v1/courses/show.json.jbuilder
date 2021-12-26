json.data do
  json.course do
    json.partial! 'api/v1/courses/course', course: @course
  end
end
