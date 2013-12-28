class Token < ActiveRecord::Base

  serialize :params

  validates_presence_of :token

  after_initialize do |t|
    t.token ||= SecureRandom.hex(3).upcase
    t.params ||= {
        pl: "en",
        apptype: [],
        extra: []
    }
  end


end
