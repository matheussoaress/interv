require 'rails_helper'

describe BooksController, type: :controller do
  let(:parsed_reponse) { JSON.parse(response.body).deep_symbolize_keys }
  describe 'GET #index' do
    it 'should return all books' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(parsed_reponse.dig(:books, 0, :id)).to eq 1
    end
  end

  describe 'GET #show' do
    it 'should return a single book' do
      get :show, params: { id: 1 }
      expect(response).to have_http_status(:ok)
      expect(parsed_reponse.dig(:book, :id)).to eq 1
    end
  end

  describe 'PUT #update' do
    it 'should update and return a single book' do
      put :update, params: { id: 1, book: { title: 'new_title' } }
      expect(response).to have_http_status(:ok)
      expect(parsed_reponse.dig(:book, :id)).to eq 1
      expect(parsed_reponse.dig(:book, :title)).to eq 'new_title'
    end
  end

  describe 'POST #create' do
    it 'should create and return a single book' do
      post :create, params: { book: { title: 'new_title', author: 'My author', publication_year: 2022 } }
      expect(response).to have_http_status(:created)
      expect(parsed_reponse.dig(:book, :id)).to eq 11
      expect(parsed_reponse.dig(:book, :title)).to eq 'new_title'
    end
  end

  describe 'DELETE #destroy' do
    it 'should destroy and return a single book' do
      delete :destroy, params: { id: 1 }
      expect(response).to have_http_status(:ok)
      expect(parsed_reponse.dig(:book, :id)).to eq 1
      expect(parsed_reponse.dig(:book, :title)).to eq 'Title 1'
    end
  end
end