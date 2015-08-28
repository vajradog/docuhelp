class Page < ActiveRecord::Base
  has_ancestry
  validates_presence_of :title, :content

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
