json.(course, :id, :title, :mentor_title, :description,:created_at)
json.chapters course.chapters do |chapter|
  json.(chapter, :id, :title, :order, :created_at)
  json.lessons chapter.lessons do |lesson|
    json.(lesson, :id, :title, :content, :description, :order, :created_at)
  end
end
