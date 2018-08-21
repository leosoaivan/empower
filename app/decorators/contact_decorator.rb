class ContactDecorator < ApplicationDecorator
  def date_and_time
    created_at.strftime('%m/%d/%y at %-l:%M%P')
  end

  def petitioner
    petitioner = ClientDecorator.new(episode.petitioner)
  end
end