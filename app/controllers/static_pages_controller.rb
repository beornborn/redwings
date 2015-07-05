class StaticPagesController < ApplicationController

  def home
  end

  def greeting
  end

  def trello
    @trello_user = Trello::Member.find("redwingsruby")
    @org = Trello::Organization.find("rubyredwings")
  end
end

