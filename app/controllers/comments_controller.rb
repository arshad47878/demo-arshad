class CommentsController < ApplicationController
  before_action :find_articles, only: [:create, :destroy]
  def create
    @comment = @article.comments.create(comment_params)
    redirect_to articles_path(@article)
  end

  def destroy
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to articles_path(@article)
  end

  private
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
  def find_articles
    @article = Article.find(params[:id])
  end
end
