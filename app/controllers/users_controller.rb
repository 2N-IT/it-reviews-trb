# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    run User::Operation::Create::Present
    render cell(User::Cell::New, @form), layout: false
  end

  def create
    run User::Operation::Create do |result|
      return redirect_to users_path(id: result['model'].id)
    end
    p @form
    render cell(User::Cell::New, @form), layout: false
  end

  def activate
    run User::Operation::Activate do |result|
      return redirect_to 'smt.......'
    end
    render cell(User::Cell::Welcome, @form), layout: false
  end
end
