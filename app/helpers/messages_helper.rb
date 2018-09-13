module MessagesHelper
  def self_or_other(message)
    message.sender == current_user ? 'self' : 'other'
  end

  def message_interlocutor(message)
    message.sender == message.conversation.sender ? message.conversation.sender : message.conversation.recipient
  end
end
