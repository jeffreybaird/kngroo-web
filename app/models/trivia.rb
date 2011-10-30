class Trivia < ActiveRecord::Base

  belongs_to :hop
  belongs_to :venue
  has_many :confirmations
  
  validates_presence_of :hop_id, :venue_id, :question, :answer
  
  set_table_name 'trivia'

  def wrong_answers
    unfiltered = Trivia.where(:numeric_answer => numeric_answer).
            where(['id != ?',id]).
            where('answer != ?',answer).
            order('random()').
            limit(5)
    filtered = []
    for e in unfiltered
      filtered << e unless filtered.map(&:answer).uniq.include?(e.answer)
    end
    filtered[0..2]
  end
  
end
