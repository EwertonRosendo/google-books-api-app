require "net/http"
require "json"

class SearchGoogleApi
  def initialize(title = "rails")
    @title = ERB::Util.url_encode(title)
  end

  def searchBookOnGoogle
    url = "https://www.googleapis.com/books/v1/volumes?q=title:#{@title}&maxResults=30&key=AIzaSyDXXnIr_YKRWAmhO5c0arzwTNj2Dys2h_k"
    uri = URI(url)

    begin
      response = Net::HTTP.get(uri)
      parsed_response = JSON.parse(response)
      list_books = []

      if parsed_response && parsed_response["items"]
        parsed_response["items"].each do |item|
          volume_info = item["volumeInfo"]
          book = {
            "title": volume_info["title"],
            "subtitle": volume_info["subtitle"],
            "description": volume_info["description"],
            "authors": volume_info["authors"],
            "publishedDate": volume_info["publishedDate"],
            "publisher": volume_info["publisher"],
            "thumbnail": volume_info["imageLinks"] ? volume_info["imageLinks"]["thumbnail"] : nil
          }
          list_books.push(book)
        end
      end

      list_books
    rescue => e
      # Trate o erro conforme necessário, por exemplo, registre-o ou mostre uma mensagem de erro
      puts "Erro ao buscar dados: #{e.message}"
      []
    end
  end
end
