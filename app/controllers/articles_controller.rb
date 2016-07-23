class ArticlesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

	def index
    @articles = Article.all.page(params[:page]).per(5)
  end

	def show
    @article = Article.friendly.find(params[:id])
    if request.path != article_path(@article)
      redirect_to @article, status: :moved_permanently
    end
  end

	def new
    @article = Article.new
	end

	def edit
  	@article = Article.friendly.find(params[:id])
	end

	def create
		@article = Article.new(article_params)

		if @article.save
  		redirect_to @article
		else
  		render 'new'
  	end
  end

  def update
  	@article = Article.friendly.find(params[:id])

  	if @article.update(article_params)
    	redirect_to @article
  	else
    	render 'edit'
  	end
	end

	def destroy
  	@article = Article.friendly.find(params[:id])
  	@article.destroy

  	redirect_to articles_path
	end

	private
  	def article_params
    	params.require(:article).permit(:title, :text, :image, :remote_image_url)
  	end
end
