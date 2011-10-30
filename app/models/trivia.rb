class Trivia < ActiveRecord::Base

  belongs_to :hop
  belongs_to :venue
  has_many :confirmations
  
  validates_presence_of :hop_id, :venue_id, :question, :answer
  
  set_table_name 'trivia'

  def wrong_answers
    Trivia.where(:numeric_answer => numeric_answer).
            where(['id != ?',id]).
            where('answer != ?',answer).
            group('id,answer').
            order('random()').
            limit(3)
  end
  
end
