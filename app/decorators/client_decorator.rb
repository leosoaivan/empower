class ClientDecorator < ApplicationDecorator
  def fullname
    "#{firstname} #{lastname}"
  end

  def mmddyyyy
    dob.strftime("%m/%d/%Y") unless dob.nil?
  end

  def fullname_and_id
    fullname + " - ##{id}"
  end

  def client
    __getobj__
  end
end