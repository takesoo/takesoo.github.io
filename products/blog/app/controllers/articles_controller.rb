class ArticlesController < ApplicationController

  before_action :move_to_index, except: [:index, :show]

  def index
    @articles = Article.page(params[:page]).per(5)

  end

  def new
    @article = Article.new
  end

  def create
    Article.create(text: article_params[:text], user_id: current_user.id)
    redirect_to root_path
  end

  def show
    @article = Article.find(params[:id])
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy if current_user.id == article.user_id
    redirect_to root_path
  end

  def edit
    article = Article.find(params[:id])
    @article = article if article.user_id == current_user.id
  end

  def update
    article = Article.find(params[:id])
    article.update(text: article_params[:text])
    redirect_to root_path
  end

private
  def article_params
    params.require(:article).permit(:text)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
