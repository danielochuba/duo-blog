require 'swagger_helper'

describe 'Posts API' do
  path '/api/v1/:user_id/posts' do
    get 'Retrieves a list of posts' do
      tags 'Posts'
      produces 'application/json'

      response '200', 'List of posts retrieved' do
        run_test!
      end
    end
  end
end
