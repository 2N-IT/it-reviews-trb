class UsersController < ApplicationController
  def create
    run User::Create
  end
end
