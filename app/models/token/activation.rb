class Token::Activation < ::Token
  after_save :send_token


  def confirm!
    super
    member.active!
  end

  private

  def send_token
    TokenMailer.activation(member.email, token).deliver
  end
end
