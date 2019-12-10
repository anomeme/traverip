crumb :root do
  link "トップページ", root_path
end

crumb :mypage do 
  link "マイページ"
end

crumb :area do |area|
  if current_page?(controller: 'articles', action: 'show')
    article = Article.find(params[:id])
    prefecture = Prefecture.find(article.prefecture_id)
  else
    prefecture = Prefecture.find(params[:id])
  end

  if prefecture.parent_id != nil
    area = Prefecture.find(prefecture.parent_id)
  else
    area = prefecture
  end
  link area.name, prefecture_path(id: area.id)
  parent :root
end

crumb :area_spot do |area|
  if current_page?(controller: 'articles', action: 'show')
    article = Article.find(params[:id])
    prefecture = Prefecture.find(article.prefecture_id)
  else
    prefecture = Prefecture.find(params[:id])
  end
  link prefecture.name, prefecture_path(id: prefecture.id)
  if prefecture.parent_id == 1 || prefecture.parent_id == 47
    parent :root
  else
    parent :area
  end
end

crumb :area_show do |article|
  article = Article.find_by(id: params[:id])
  link article.title, article_path
  parent :area_spot
end

crumb :list do 
  link "記事一覧"
end

crumb :search do 
  link "記事検索"
end

crumb :favorite do 
  link "お気に入り"
end


# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).