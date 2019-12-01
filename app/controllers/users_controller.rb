# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    run User::Operation::Create::Present
  end

  def create
    run User::Operation::Create
  end

  def activate
    run User::Operation::Activate
  end
end
