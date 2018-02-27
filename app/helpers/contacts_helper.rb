module ContactsHelper
  def form_url(contact)
    contact.new_record? ? [@episode, contact] : contact
  end

  def form_field_active?(contact)
    contact.new_record? ? "" : "active"
  end

  def form_submit_text(contact)
    contact.new_record? ? "Create Contact" : "Edit Contact" 
  end
end
