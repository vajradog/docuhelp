class Page < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }

  has_ancestry
  has_paper_trail class_name: 'PageVersion', meta: { author_username: :user_name, word_count: :count_word }

  validates_presence_of :title, :content

  belongs_to :user
  has_many :freq_infos

  include PgSearch
  pg_search_scope :search, against: [:title, :content],
  using: {tsearch: {dictionary: "english"} }

  def self.text_search(query)
    if query.present?
       search(query)
    else
      all
    end
  end

  def count_word
    content.split(' ').count
  end


  #def self.title_search(search)
  #  if search.present?
  #     title_search(search)
  #  else
  #    all
  #  end
  #end


  #def self.title_search(search)
   # if title_search
   #   where('title LIKE ?', "%#{search}%")
   # else
   #   all
   # end
  #end

end
