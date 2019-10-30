class UsersController < ApplicationController
  def new
    run User::Create::Present
  end

  def create
    run User::Create
  end

  def activate
    run User::Activate
  end
end
