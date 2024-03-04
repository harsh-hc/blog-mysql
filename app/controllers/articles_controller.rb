class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    # print "Id of article: #{params[:id]}"
    @article = Article.find_by_id(params[:id])
    # print "Article #{@article}"
    # artcle not available
    if @article.nil?
      redirect_to articles_path
    end


  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status)
    end
end
