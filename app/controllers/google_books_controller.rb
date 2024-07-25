class GoogleBooksController < ApplicationController
  def index
    search_google = SearchGoogleApi.new(params[:title])
    list_books = search_google.searchBookOnGoogle
    render json: list_books 
  end
end
