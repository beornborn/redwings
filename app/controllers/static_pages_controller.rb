class StaticPagesController < ApplicationController

  def home
    require 'trello'

    Trello.configure do |config|
      config.developer_public_key = '32000478b8ee948f67b044b476ea1df0'
      config.member_token = '3c513844d61023ae9bc6a72ddd5f6b4494568af9c9663c3ac92b871986f28835'
    end

    @me = Trello::Member.find("maxkachanov")
    @org = @me.organizations.first
  end

  def greeting
  end

end

