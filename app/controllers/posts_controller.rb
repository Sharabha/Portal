class PostsController < InheritedResources::Base
  def index
	#add filtering based on publication date here
	if params[:competition_posts]
		@posts = Post.where(:competition_id => params[:competition_posts])
		@competition = Competition.find(params[:competition_posts])
	else
		@posts = Post.where("competition_id IS NULL")
	end
  end

  def show
	@post = Post.find(params[:id])
	if @post.competition_id?
		@return_path = competition_posts_path(@post.competition_id)
	else
		@return_path = posts_path
	end
  end

  def new
	@post = Post.new
  end

  def create
    @post = Post.new(params[:post])
	@post.user_id = current_user.id
    if @post.save
      redirect_to @post 
    else
      render :action => "new"
    end
  end

  def edit
	@post = Post.find(params[:id])
  end

  def update
	@post = Post.find(params[:id])
	if @post.update_attributes(params[:post])
      redirect_to @post
    else
      render :action => "edit"
    end
  end

  def destroy
	@post = Post.find(params[:id])
	@post.destroy
  end

end
