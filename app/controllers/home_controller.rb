class HomeController < ApplicationController
  def index
    @vendors = Vendor.all
  end
end
