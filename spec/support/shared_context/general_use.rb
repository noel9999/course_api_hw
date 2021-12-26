RSpec.shared_context 'general_use' do
  let(:json_body) { JSON.parse(response.body) }
  let(:json_data) { JSON.parse(response.body)['data'] }
end
