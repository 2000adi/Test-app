Rails.application.routes.draw do
  devise_for :users
  root to: 'books#index'

  post 'books/:id/book', to: 'books#create_booking', as: 'create_booking_book'
  get 'my_bookings', to: 'bookings#my_bookings'

  resources :books do
    post :book, on: :member
  end
end
