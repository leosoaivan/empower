class Client < ApplicationRecord
  resourcify
  
  has_many :petitioned_episodes, class_name: 'Episode', foreign_key: 'petitioner_id'
  has_many :responded_episodes, class_name: 'Episode', foreign_key: 'respondent_id' 

  has_many :respondents, through: :petitioned_episodes
  has_many :petitioners, through: :responded_episodes

  validates :firstname, presence: true
  validates :lastname,  presence: true

  def all_episodes
    self.petitioned_episodes.or(self.responded_episodes)
  end  

  # Elasticsearch settings
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  ES_CLIENT = {
    analysis: {
      filter: {
        ngram_filter: {
          type: "edge_ngram",
          min_gram: 2,
          max_gram: 20
        }
      },
      analyzer: {
        my_analyzer: {
          type: "custom",
          tokenizer: "standard",
          filter: ["lowercase", "ngram_filter"]
        }
      }
    }
  }

  settings ES_CLIENT do
    mappings dynamic: false do
      indexes :id, type: :text, boost: 2
      indexes :firstname, type: :text, analyzer: 'my_analyzer'
      indexes :lastname, type: :text, analyzer: 'my_analyzer'
    end
  end

  def as_index_json(options = nil)
    self.as_json(only: [:id, :firstname, :lastname])
  end

  def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          bool: {
            should: [
              { 
                match: { id: query["id"] }
              },
              {
                bool: {
                  should: [
                    { match: { firstname: query["firstname"] } },
                    { match: { lastname: query["lastname"] } }
                  ]
                }
              }
            ]
          }
        }
      }
    )
  end
end
