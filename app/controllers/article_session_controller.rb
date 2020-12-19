class ArticleSessionController < ApplicationController

    def take_id_article_for_contents
        id = @article.id
        article = Article.find()
    end
end
