require "net/http"
require "json"

class SearchGoogleApi
  def initialize(title = "rails")
    @title = ERB::Util.url_encode(title)
  end

  def searchBookOnGoogle
    url = "https://www.googleapis.com/books/v1/volumes?q=title:#{@title}&key=AIzaSyDXXnIr_YKRWAmhO5c0arzwTNj2Dys2h_k"
    uri = URI(url)

    response = JSON.parse(Net::HTTP.get(uri))
    list_books = []

    unless response.nil?
      response["items"].each do |item|
        volume_info = item["volumeInfo"]
        book = {
          "title": volume_info["title"],
          "subtitle": volume_info["subtitle"],
          "description": volume_info["description"],
          "authors": volume_info["authors"],
          "publishedDate": volume_info["publishedDate"],
          "publisher": volume_info["publisher"],
          "thumbnail": volume_info["imageLinks"]["thumbnail"]
        }
        list_books.push(book)
      end
      list_books
    end
  end
end