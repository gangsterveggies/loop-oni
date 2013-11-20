class User < ActiveRecord::Base
  attr_accessor :grade, :updating_password, :updating_stats
  before_save :setup_user
  before_create :create_remember_token
  before_update :update_user
  mount_uploader :profile_image, ImageUploader

  validates :name,  presence: true, length: { maximum: 100 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, :if => :should_validate_password?
  validates :grade, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 12 }, :if => :should_validate_stats?
  validates :school, length: { maximum: 100 }, :allow_nil => true
  validates :city, length: { maximum: 100 }, :allow_nil => true
  has_secure_password

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def should_validate_password?
    updating_password || new_record?
  end

  def should_validate_stats?
    updating_stats
  end

  private
    def setup_user
      self.email = email.downcase
      self.qualifications = 0
      self.finals = 0
      self.iois = 0
      self.wins = 0
      self.bronze = 0
      self.silver = 0
      self.gold = 0
      create_grad_year
      if (grade.present? and Integer(grade) > 4 and Integer(grade) <= 12)
        self.contestant_type = 0
      else
        self.contestant_type = 1
      end
    end

    def update_user
      create_grad_year
      if (grade.present? and Integer(grade) > 4 and Integer(grade) <= 12)
        self.contestant_type = 0
      else
        self.contestant_type = 1
      end
    end


    def create_grad_year
      if (grade.present? and Integer(grade) > 0)
        self.graduation_year = get_year_from_grade(Integer(grade))
      else
        self.graduation_year = 0
      end
    end

    def get_year_from_grade (grade)
      return 12 - grade + ((Time.now - Time.utc(0, 2, 17, 0, 0))/1.year).round
    end

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
