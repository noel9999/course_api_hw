require 'rails_helper'

RSpec.describe Api::V1::CoursesController, type: :controller do
  describe '#index' do
    let!(:course) { create(:course, :with_chapters) }

    let!(:course_b) { create(:course, :with_chapters) }

    context 'for successful case' do
      it 'returns ok and correct data' do
        get :index, params: {}, format: :json
        expect(response.status).to eq(200)
        expect(json_data['courses'][0]['title']).to eq(course.reload.title)
        expect(json_data['courses'][0]['mentor_title']).to eq(course.mentor_title)
        expect(json_data['courses'][0]['chapters'][0]['title']).to eq(course.chapters.first.title)
        expect(json_data['courses'][1]['title']).to eq(course_b.reload.title)
        expect(json_data['courses'][1]['mentor_title']).to eq(course_b.mentor_title)
        expect(json_data['courses'][1]['chapters'][0]['title']).to eq(course_b.chapters.first.title)
      end
    end
  end

  describe '#create' do
    context 'for successful case' do
      let(:params) do
        {
          title: 'StarWars',
          mentor_title: 'George Lucas',
          description: '^_^',
          chapters_attributes: [
            {
              title: 'New Hope'
            },
            { title: nil },
            {
              title: 'The Empire Strikes Back',
              lessons_attributes: [
                {
                  title: "^_^",
                  content: "@_@",
                  description: "~_~"
                },
                {
                  title: "Foo",
                  content: "Bar"
                },
              ]
            }
          ]
        }
      end

      it 'returns created and data' do
        expect { post :create, params: params, format: :json }.to change { Course.count }.by(1)
        .and change { Chapter.count }.by(2)
        .and change { Lesson.count }.by(2)

        expect(response.status).to eq(201)
        expect(response).to render_template(:show)
        expect(json_data['course']['title']).to eq(params[:title])
        expect(json_data['course']['memetor_title']).to eq(params[:memetor_title])
        expect(json_data['course']['chapters'][-1]['title']).to eq(params[:chapters_attributes][-1][:title])
        expect(json_data['course']['chapters'][-1]['lessons'][-1]['title']).to eq(params[:chapters_attributes][-1][:lessons_attributes][-1][:title])
        expect(json_data['course']['chapters'][-1]['lessons'][-1]['content']).to eq(params[:chapters_attributes][-1][:lessons_attributes][-1][:content])
        expect(json_data['course']['chapters'][-1]['lessons'][-1]['description']).to eq(params[:chapters_attributes][-1][:lessons_attributes][-1][:description])
      end
    end

    context 'for failed case' do
      context 'without course title  and mentor_title provided' do
        let(:params) do
          {
            description: '^_^',
            chapters_attributes: [
              {
                title: 'The Empire Strikes Back',
                lessons_attributes: [
                  {
                    title: "^_^",
                    content: "@_@",
                    description: "~_~"
                  }
                ]
              }
            ]
          }
        end

        it 'returns 422' do
          expect { post :create, params: params, format: :json }.to change { Course.count }.by(0)
          expect(response.status).to eq(422)
          expect(json_body['code']).to eq('ActiveRecord::RecordInvalid')
        end
      end

      context 'without chapter title provided' do
        let(:params) do
          {
            title: 'StarWars',
            mentor_title: 'George Lucas',
            description: '^_^',
            chapters_attributes: [
              {
                title: 'The Empire Strikes Back'
              },
              {
                title: nil,
                lessons_attributes: [
                  {
                    title: 'Foo',
                    content: 'Bar'
                  }
                ]
              }
            ]
          }
        end

        it 'returns 422' do
          expect { post :create, params: params, format: :json }.to change { Course.count }.by(0)
          .and change { Chapter.count }.by(0)
          .and change { Lesson.count }.by(0)
          expect(response.status).to eq(422)
          expect(json_body['code']).to eq('ActiveRecord::RecordInvalid')
        end
      end

      context 'without lesson title provided' do
        let(:params) do
          {
            title: 'StarWars',
            mentor_title: 'George Lucas',
            description: '^_^',
            chapters_attributes: [
              {
                title: 'New Hope',
                lessons_attributes: [
                  {
                    title: 'Foo',
                    content: 'Bar'
                  }, {
                    title: '',
                    content: 'Bar'
                  }
                ]
              }
            ]
          }
        end

        it 'returns 422' do
          expect { post :create, params: params, format: :json }.to change { Course.count }.by(0)
          .and change { Chapter.count }.by(0)
          .and change { Lesson.count }.by(0)
          expect(response.status).to eq(422)
          expect(json_body['code']).to eq('ActiveRecord::RecordInvalid')
        end
      end
    end
  end

  describe '#update' do
    let!(:course) { create(:course, :with_chapters).reload }
    let(:chapter) { course.chapters.first }
    let(:lesson) { chapter.lessons.first }
    let(:lesson_to_delete) { chapter.lessons.last }

    context 'for successful case' do
      let(:params) do
        {
          id: course.id,
          title: 'StarTrek',
          description: '>_<',
          chapters_attributes: [
            {
              id: chapter.id,
              title: 'Into Darkness',
              lessons_attributes: [
                {
                  id: lesson.id,
                  title: "nutella",
                  content: "B-ready",
                  description: "=_="
                },
                {
                  id: lesson_to_delete.id,
                  _destroy: '1'
                },
              ]
            }
          ]
        }
      end

      it 'returns ok and data' do
        expect { patch :update, params: params, format: :json }.to change { Lesson.count }.by(-1)

        expect(response.status).to eq(200)
        expect(response).to render_template(:show)
        expect(course.reload.title).to eq(params[:title])
        expect(course.description).to eq(params[:description])
        expect(chapter.reload.title).to eq(params[:chapters_attributes][0][:title])
        expect(lesson.reload.title).to eq(params[:chapters_attributes][0][:lessons_attributes][0][:title])
        expect(lesson.content).to eq(params[:chapters_attributes][0][:lessons_attributes][0][:content])
        expect(lesson.description).to eq(params[:chapters_attributes][0][:lessons_attributes][0][:description])
      end
    end

    context 'for failed case' do
      context 'without course title empty' do
        let(:params) do
          {
            id: course.id,
            title: '',
            description: '>_<',
            chapters_attributes: [
              {
                id: chapter.id,
                title: 'Into Darkness',
                lessons_attributes: [
                  {
                    id: lesson.id,
                    title: "nutella",
                    content: "B-ready",
                    description: "=_="
                  },
                  {
                    id: lesson_to_delete.id,
                    _destroy: '1'
                  },
                ]
              }
            ]
          }
        end

        it 'returns 422' do
          patch :update, params: params, format: :json
          expect(response.status).to eq(422)
          expect(json_body['code']).to eq('ActiveRecord::RecordInvalid')
          expect(course.reload.description).not_to eq(params[:mentor_title])
        end
      end

      context 'with lesson title empty' do
        let(:params) do
          {
            id: course.id,
            title: 'StarTrek',
            description: '>_<',
            chapters_attributes: [
              {
                id: chapter.id,
                title: 'Into Darkness',
                lessons_attributes: [
                  {
                    id: lesson.id,
                    title: "",
                    content: "B-ready",
                    description: "=_="
                  }
                ]
              }
            ]
          }
        end

        it 'returns 422' do
          patch :update, params: params, format: :json
          expect(response.status).to eq(422)
          expect(json_body['code']).to eq('ActiveRecord::RecordInvalid')
          expect(course.reload.title).not_to eq(params[:title])
          expect(chapter.reload.title).not_to eq(params[:chapters_attributes][0][:title])
          expect(lesson.reload.title).not_to eq(params[:chapters_attributes][0][:lessons_attributes][0][:title])
        end
      end
    end
  end
end
