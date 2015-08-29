module ApplicationHelper
  def highlight_query_results(content,queries)
    if queries.blank?
      content
    else
      temp = content
      queries.each do |q|
        temp.gsub!(/(#{q})/i , '<mark>\1</mark>')
      end
    end
    temp
  end

  def find_version_author_name(version)
    user = User.find_version_author(version)
    user ? user.username : ''
  end

end
