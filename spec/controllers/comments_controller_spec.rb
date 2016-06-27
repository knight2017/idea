require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:idea) {Idea.create(title: "aaaaa", body:"bbbbb")}
  let(:user){User.create(
  first_name:"#{ Faker::Name.first_name }",
  last_name: "#{ Faker::Name.first_name }",
  email: "abc@gmail.com",
  password:"#{Faker::Internet.password}")}

  describe "#create" do
    context "with user not signed in" do
      it "redirects to new user page" do
          post :create, idea_id: idea.id, comment: {body: 'HAHAHA'}
          expect(response).to redirect_to(new_user_path)
      end
    end
    context "with user signed in" do
      before {request.session[:user_id] = user.id}
      context "with valid attributes" do
        def valid_request
          post :create, idea_id: idea.id, comment: {body: 'HAHAHA'}
        end
        it "redirect to the idea show page" do
          valid_request
          expect(response).to redirect_to idea_path(idea)
        end
        it "associates the comment with the logged in user" do
          valid_request
          expect(Comment.last.user).to eq(user)
        end
      end
    end
  end

  describe 'destroy' do
    # def valid_request
    #   post :create, idea_id: idea.id, user_id: user.id, comment: {body: 'HAHAHA'}
    # end
    before {request.session[:user_id] = user.id}
    it "the creator can delete comment" do
        idea
        user
        c = Comment.new body: 'HAHAHA'
        c.user = user
        c.idea = idea
        c.save
        count_before = Comment.count
        user1 = User.create(
        first_name:"#{ Faker::Name.first_name }",
        last_name: "#{ Faker::Name.first_name }",
        email: "abcwde@gmail.com",
        password:"#{Faker::Internet.password}")
        request.session[:user_id] = user1.id
        delete :destroy, id: Comment.first.id
        count_after  = Comment.count
        expect(count_before).to eq(count_after + 1)
    end
    it "onwer can delete all comments" do
        user1 = User.create(
        first_name:"#{ Faker::Name.first_name }",
        last_name: "#{ Faker::Name.first_name }",
        email: "abcwde@gmail.com",
        password:"#{Faker::Internet.password}")
        idea.user = user
        request.session[:user_id] = user1.id
        count_before = Comment.count
        c = Comment.new body: 'HAHAHA'
        c.user = user1
        c.idea = idea
        c.save
        request.session[:user_id] = user.id
        delete :destroy, id: Comment.last.id
        count_after  = Comment.count
        expect(count_before).to eq(count_after)
    end


  end


end
