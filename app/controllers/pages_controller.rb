class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def supplies
  end

  def home
  end
end
