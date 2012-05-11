class PostsController < InheritedResources::Base
  def index
	
  end

  def show
	@post = Post.find(params[:id])
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
  end

  def destroy
	@post = Post.find(params[:id])
  end

end
