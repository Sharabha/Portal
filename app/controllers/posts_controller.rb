class PostsController < InheritedResources::Base
  def index
	#add filtering based on competition and publication date here
	@posts = Post.all
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
