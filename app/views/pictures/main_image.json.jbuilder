json.id @main_image.id
json.user_id @main_image.user.id
json.user_name @main_image.user.name
json.article_title @main_image.article.title
# json.prefecture @main_image.article.prefecture_id.name
json.title @main_image.title
json.image @main_image.image.url
json.date @main_image.created_at.strftime("%Y/%m/%d %H:%M")