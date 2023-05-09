Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root to: 'books#index'

  post 'books/:id/book', to: 'books#create_booking', as: 'create_booking_book'
  get 'my_bookings', to: 'bookings#my_bookings'
  get 'bookings', to: 'bookings#bookings_index', as: 'bookings_index'

  resources :user_books do
    resources :book_chapters
  end
  get 'my_books', to: 'user_books#my_books'

  resources :books do
    post :book, on: :member
  end
end
