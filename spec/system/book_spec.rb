require 'rails_helper'

RSpec.describe 'Book', type: :system, js: true do
  it 'index' do
    visit book_index_path

    take_screenshot
  end
end
