require 'rails_helper'

RSpec.describe Api::V1::CoursesController, type: :controller do
  describe '#index' do
    let!(:course) { create(:course, :with_chapters) }
    let!(:course_b) { create(:course, :with_chapters) }

    context 'for successful case' do
      it 'returns ok and correct data' do
        get :index, params: {}, format: :json
        expect(response.status).to eq(200)
        expect(json_data['courses'][0]['title']).to eq(course.title)
        expect(json_data['courses'][0]['mentor_title']).to eq(course.mentor_title)
        expect(json_data['courses'][0]['chapters'][0]['title']).to eq(course.chapters.first.title)
        expect(json_data['courses'][1]['title']).to eq(course_b.title)
        expect(json_data['courses'][1]['mentor_title']).to eq(course_b.mentor_title)
        expect(json_data['courses'][1]['chapters'][0]['title']).to eq(course_b.chapters.first.title)
      end
    end
  end
end
