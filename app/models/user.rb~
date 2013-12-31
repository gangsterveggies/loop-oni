class User < ActiveRecord::Base
  has_many :read_relationships, foreign_key: "user_id", dependent: :destroy
  has_many :read_articles, through: :read_relationships, source: :article
  attr_accessor :grade, :updating_password, :updating_stats
  has_many :participate_relationships, foreign_key: "user_id", dependent: :destroy
  has_many :participate_contests, through: :participate_relationships, source: :contest
  attr_accessor :grade, :updating_password, :updating_stats
  before_create :setup_user
  before_update :update_user
  mount_uploader :profile_image, ImageUploader

  validates :name,  presence: true, length: { maximum: 100 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, :if => :should_validate_password?
  validates :grade, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 12 }, :if => :should_validate_stats?
  validates :school, length: { maximum: 100 }, :allow_nil => true
  validates :city, length: { maximum: 100 }, :allow_nil => true
  validates :qualifications, :presence => false
  validates :finals, :presence => false
  validates :iois, :presence => false
  has_secure_password

  def read?(article)
    read_relationships.find_by(article_id: article.id)
  end

  def read!(article)
    read_relationships.create!(article_id: article.id)
  end

  def unread!(article)
    read_relationships.find_by(article_id: article.id).destroy!
  end

  def participate?(contest)
    participate_relationships.find_by(contest_id: contest.id)
  end

  def participate!(contest)
    participate_relationships.create!(contest_id: contest.id)
  end

  def unparticipate!(contest)
    participate_relationships.find_by(contest_id: contest.id).destroy!
  end

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

  def send_password_reset
    self.password_reset_token = User.new_remember_token
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def send_email_validation
    self.email_validation_token = User.new_remember_token
    self.email_validated_at = DateTime.now() + 100.years
    save!
    UserMailer.email_validation(self).deliver
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
      create_remember_token
    end

    def update_user
      create_grad_year
    end

    def create_grad_year
      if (grade.present? and Integer(grade) > 0)
        self.graduation_year = get_year_from_grade(Integer(grade))
      elsif (grade.present?)
        self.graduation_year = 0
      end
      if (grade.present? and Integer(grade) > 4 and Integer(grade) <= 12)
        self.contestant_type = 0
      elsif (grade.present?)
        self.contestant_type = 1
      end
    end

    def get_year_from_grade (grade)
      return 12 - grade + ((Time.now - Time.utc(0, 2, 17, 0, 0))/1.year).round
    end

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
