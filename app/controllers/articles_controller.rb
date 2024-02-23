class ArticlesController < ApplicationController
  before_action :jwt_authenticate, only: [:create, :update, :destroy, :feed]
  def index
    articles = Article.all

    if articles
      render json: articles, status: :ok
    else
      error_render(articles)
    end
  end

  def show
    article = Article.find_by(id: params[:id])
    if article
      render json: article, status: :ok
    else
      error_render(article)
    end
  end

  def feed
    articles = Article.where(user_id: @user.id)
    if articles
      render json: articles, status: :ok
    else
      error_render(articles)
    end
  end

  def create
    article = Article.new(article_params)
    article.user_id = @user.id
    if article.save
      render json: article, status: :ok
    else
      error_render(article)
    end
  end

  def update
    article = Article.find_by(id: params[:id])
    if article.update(article_params)
      render json: article, status: :ok
    else
      error_render(article)
    end
  end

  def destroy
    article = Article.find_by(id: params[:id])
    if article.destroy
      render json: article, status: :ok
    else
      error_render(article)
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :description, :body, :user_id)
  end

  def error_render(article)
    render json: { errors: article.errors.full_messages }, status: :unprocessable_entity
  end
end
