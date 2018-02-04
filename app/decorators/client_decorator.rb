class ClientDecorator < ApplicationDecorator
  def fullname
    "#{firstname} #{lastname}"
  end

  def client
    __getobj__
  end
end