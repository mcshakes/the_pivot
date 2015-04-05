require "rails_helper"
require "support/factory_girl"

RSpec.feature "Unauthenticated user", type: :feature do
  xit "cannot view account page until logged in" do
