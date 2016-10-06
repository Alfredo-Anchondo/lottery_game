require 'rails_helper'
 require "cancan/matchers"



RSpec.describe UsersController, type: :controller do
  describe "POST #create" do
   context "with valid attributes" do
     it "create new user" do
       count =  User.count
        user = create(:user)
       expect(User.count).to eq(count + 1)
     end
   end
 end
end
