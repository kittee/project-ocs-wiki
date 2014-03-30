module ArticleHelper
  def list_categories(article)
    array = []
    article.categories.each do |cat|
      array << cat.name
    end
    array.join(", ")
  end
end