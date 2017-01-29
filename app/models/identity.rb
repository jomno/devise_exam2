class Identity < ActiveRecord::Base
  belongs_to :user
  validates :uid, :provider, presence: true
  validates :uid, uniqueness: { :scope => :provider }

  def self.find_for_oauth(auth)
    identity = find_by(provider: auth.provider, uid: auth.uid)
    identity = create(provider: auth.provider, uid: auth.uid) if identity.nil?
    identity
  end
end
