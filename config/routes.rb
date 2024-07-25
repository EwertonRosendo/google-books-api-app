Rails.application.routes.draw do
  # Return a list of books from google
  get "/google-books", to: "google_books#index", as: "googleBooks" # return a react-view about the book seached
  get "/google-books/:title", to: "google_books#index" # return a react-view about the book seached
end
