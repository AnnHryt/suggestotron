class Topic < ApplicationRecord
  has_many :votes, dependent: :destroy

  def self.sorted(direction)      
    return Topic.order('lower(title)') if direction.nil?
    #  if direction.nil? is the same as unless direction

    sorted_topics = all.sort_by do |topic|
      topic.votes.count
    end

    return sorted_topics.reverse if direction == "desc"

    sorted_topics
  end

  def upvote
      votes.create
  end
    
  def downvote
        votes.first.destroy if votes.exists?
  end

end