class EmailValidator
  include ActiveModel::Validations

  attr_accessor :recipient, :subject

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :recipient, presence: true,
                    format: { with: VALID_EMAIL_REGEX }
  validates :subject, presence: true, length: { minimum: 1 }

  def initialize(mail = {})
    @recipient, @subject = mail[:recipient], mail[:subject]
  end

  def to_key
    [42]
  end
end
