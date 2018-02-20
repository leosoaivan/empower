class ContactDecorator < ApplicationDecorator
  def date_and_time
    created_at.strftime('%m/%d/%y at %-l:%M%P')
  end
end