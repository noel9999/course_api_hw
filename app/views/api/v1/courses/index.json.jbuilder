json.data do
  json.courses do
    json.array! @courses do |course|
      json.partial! 'api/v1/courses/course', course: course
    end
  end
end
