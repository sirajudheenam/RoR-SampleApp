json.extract! article, :id, :title, :content, :magazine_id, :created_at, :updated_at
json.url article_url(article, format: :json)
