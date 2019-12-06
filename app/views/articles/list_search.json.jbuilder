json.array! @search_articles do |article|
  json.id article.id
  json.title article.title
  json.detail article.detail
  json.image article.image.url
  json.prefecture article.prefecture.name
end