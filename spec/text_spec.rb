require 'rspec'
require 'text'

RSpec.describe 'Text#sms' do

  context 'when given a valid number' do
    it 'sends a hello world text to a phonebook contact' do
      text = Text.new
      text.sms('matt', 'hello world')

      expect(text.body).to eq('hello world')
    end

    it 'sends a hello world text to a random number' do
      text = Text.new
      text.sms('+9086413192', 'hello world')

      expect(text.body).to eq('hello world')
    end

    it 'returns a successful Twilio::REST::Message object' do
      text = Text.new
      response = text.sms('matt', 'message')

      expect(response).to be_a(Twilio::REST::Message)
    end
  end

  context 'when given an invalid number' do
    it 'returns an exception message' do
      text = Text.new
      response = text.sms('', 'hello')

      expect(response).to eq("A 'To' phone number is required.")
    end
  end
end
