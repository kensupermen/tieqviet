class MessengerController < Messenger::MessengerController
  def webhook
    if fb_params.first_entry.callback.message?
      Messenger::Client.send(
        Messenger::Request.new(message, sender_id)
      )
    end

    head :ok
  end

  private

  def maps
    [
      [/k(h|H)/, 'x'],
      [/K(h|H)/, 'X'],
      [/c(?!(h|H))|q/, 'k'],
      [/C(?!(h|H))|Q/, 'K'],
      [/t(r|R)|c(h|H)/, 'c'],
      [/T(r|R)|C(h|H)/, 'C'],
      [/d|g(i|I)|r/, 'z'],
      [/D|G(i|I)|R/, 'Z'],
      [/g(i|ì|í|ỉ|ĩ|ị|I|Ì|Í|Ỉ|Ĩ|Ị)/, 'z'],
      [/G(i|ì|í|ỉ|ĩ|ị|I|Ì|Í|Ỉ|Ĩ|Ị)/, 'Z'],
      [/đ/, 'd'],
      [/Đ/, 'D'],
      [/p(h|H)/, 'f'],
      [/P(h|H)/, 'F'],
      [/n(g|G)(h|H)?/, 'q'],
      [/N(g|G)(h|H)?/, 'Q'],
      [/(g)(h|H)/, 'g'],
      [/(G)(h|H)/, 'G'],
      [/t(h|H)/, 'w'],
      [/T(h|H)/, 'W'],
      [/(n)(h|H)/, 'n\''],
      [/(N)(h|H)/, 'N\'']
    ]
  end

  def sender_id
    fb_params.first_entry.sender_id
  end

  def message_received
    fb_params.first_entry.callback.text
  end

  def translate(text)
    maps.each do |regex|
      text = text.gsub(regex[0], regex[1])
    end
    text
  end

  def message
    Messenger::Elements::Text.new(text: translate(message_received))
  end
end
