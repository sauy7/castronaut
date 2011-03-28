xml.instruct!
xml.cas :serviceResponse, "xmlns:cas" => "http://www.yale.edu/tp/cas" do
  if presenter.service_ticket_result.valid?
    xml.cas :authenticationSuccess do
      xml.cas(:user, presenter.username)
      
      if presenter.proxy_granting_ticket_iou
        xml.cas(:proxyGrantingTicket, presenter.proxy_granting_ticket_iou)
      end
      
      presenter.extra_attributes.each do |attr, value|
        xml.tag!(attr, value)
      end
    end
  else
    xml.cas(:authenticationFailure, presenter.service_ticket_result.message,
      :code => presenter.service_ticket_result.message_category)
  end
end