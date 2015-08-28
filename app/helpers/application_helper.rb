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
end
