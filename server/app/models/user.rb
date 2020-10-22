class User < ApplicationRecord
    has_many :questions, dependent: :nullify
    has_many :answers, dependent: :nullify

    has_many :sent_gifts, class_name: 'Gift', foreign_key: :sender_id, dependent: :nullify
    has_many :received_gifts, class_name: 'Gift', foreign_key: :receiver_id, dependent: :nullify
    
    has_one_attached :avatar
    # Step: 2
    # 👇🏻This will check address to be valid, if valid address it will convert it into longitude and latitude and will save it in User table
    geocoded_by :address
    after_validation :geocode


    #👆has_one :avatar_attachment, dependent: :destoy
    # has_one :avatar_blob, through: :avatar_attachment


    has_secure_password
    # Provies user authentication features on the model 
    # it is called in. Requires a column named 'password_digest'
    # and the gem 'bcrypt'
    #   - It will add two attribute accessors for 'password'
    #       and 'password_confirmation'
    #   - It will add presence validation for the 'password' field
    #   - It will save passwords assigned to 'password' using 
    #       bcrypt to hash and store it in the 'password_digest'
    #       column, meaning that we will never store plain text 
    #       passwords.
    #   - It will add a method named 'authenticate' to verify 
    #       a user's password. If called with the correct password,
    #       it will return the user. Otherwise, it will return 'false'
    # The attribute accessor 'password_confirmation' is optional. If 
    # it is present, a validation will be added to verfify that it is
    # identical to the 'password' accessor.

    has_many :likes 
    has_many :liked_questions, through: :likes, source: :question

    has_many :job_posts, dependent: :nullify 

    # Docs:
    # has_and_belongs_to_many(name, scope=nil, {options}, &extension)
    # The options are as follows:
    # :class_name => the model that the association points to
    # :join_table => the join table used to creat this association 
    # :foreign_key => on the join table, which foreign key points to this current model
    # :association_foreign_key => on the join table, which foreign key points to
    #   the associated table

    VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX,unless: :from_oauth?
    
    def from_oauth?
        uid.present? && provider.present?
    end
    def self.create_from_oauth(oauth_data)
    name= oauth_data["info"]["name"]&.split || oauth_data["info"]["nickname"]
    self.create(
        first_name: name[0],
        last_name: name[1] || "",
        uid: oauth_data["uid"],
        provider: oauth_data["provider"],
        oauth_raw_data: oauth_data,
        password: SecureRandom.hex(32)
    )
    end
    def self.find_by_oauth(oauth_data)
        self.find_by(uid: oauth_data["uid"],provider: oauth_data["provider"])
    end

    def full_name 
        "#{first_name} #{last_name}".strip
    end
end
