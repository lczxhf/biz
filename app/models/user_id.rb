#encoding:utf-8

class UserId
  include Mongoid::Document

  field :next_id

  def self.generate_next_id
    user_id = UserId.first || UserId.new({:next_id => 10000})
    current_id = 0

    # user_id.with_lock do
      while current_id <= 0
        current_id = user_id.next_id
        user_id.next_id = user_id.next_id + 1
      end
      user_id.save
    # end

    current_id
  end
end

