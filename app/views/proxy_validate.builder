xml.instruct!
xml.cas :serviceResponse, "xmlns:cas" => "http://www.yale.edu/tp/cas" do
  if presenter.proxy_ticket_result.valid?
    xml.cas :authenticationSuccess do
      xml.cas(:user, presenter.username)
      
      if presenter.proxy_granting_ticket_iou
        xml.cas(:proxyGrantingTicket, presenter.proxy_granting_ticket_iou)
      end
      
      if presenter.proxies
        xml.cas(:proxies) do
          presenter.proxies.each { |proxy| xml.cas(:proxy, proxy) }
        end
      end
      
      presenter.extra_attributes.each do |attr, value|
        xml.send(attr, value)
      end
    end
  else
    xml.cas(:authenticationFailure, presenter.proxy_ticket_result.message,
      :code => presenter.proxy_ticket_result.message_category)
  end
end