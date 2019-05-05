# frozen_string_literal: true

class WelcomeController < ApplicationController

  def index
    if user_signed_in?
      redirect_to admin_user_index_path
    end
  end
  
end
