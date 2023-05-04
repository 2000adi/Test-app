Rails.application.routes.draw do
  devise_for :users
  root to: 'books#index'

  post 'books/:id/book', to: 'books#create_booking', as: 'create_booking_book'
  get 'my_bookings', to: 'bookings#my_bookings'
  get 'bookings', to: 'bookings#bookings_index', as: 'bookings_index'

  resources :books do
    post :book, on: :member
  end
end
