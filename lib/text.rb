require 'twilio-ruby'

class Text

  attr_accessor :body

  def initialize
    account_sid = 'AC820c6e45190f3ed928574057ca7b333e'
    auth_token = 'b3560f0a2a16f109b8d8833ded97b268'
    @client = Twilio::REST::Client.new account_sid, auth_token
  end


  def sms(to_number, message)
    @body = message
    somebody = check_phonebook(to_number)
    twilio_number = "+15005550006"

    begin
      @client.account.messages.create(body: @body.to_s,
                                      to: somebody.to_s,
                                      from: twilio_number)
    rescue Twilio::REST::RequestError => e
      puts e.message
    end
  end

  def check_phonebook(to_number)
    if PhoneBook.send_to.keys.include? to_number
      PhoneBook.send_to[to_number]
    else
      to_number
    end
  end
end

class PhoneBook
  def self.send_to
    {
      "matt" => "+19545520169",
      "ashley" => "+19086423192"
    }
  end
end

text = Text.new
text.sms(ARGV[0].to_s, ARGV[1].to_s)
