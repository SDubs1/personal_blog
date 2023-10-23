class PostsController < ApplicationController
  # Displays all posts
  def index
    # Fetch all the posts from the database, order them by timestamp in descending order, and assign them to the @posts instance variable
    @posts = Post.all.order(timestamp: :desc)
  end

  # Displays a single post
  def show
    # Fetch the post from the database and assign it to the @post instance variable
    @post = Post.find(params[:id])
  end

  # Displays a form for creating a new post
  def new
    # Initialize a new Post object and assign it to the @post instance variable
    @post = Post.new
  end

  # Creates a new post (handles the form submission)
  def create
    # Initialize a new Post object with the form data and assign it to the @post instance variable
    @post = Post.new(post_params)
    # Save the post to the database
    if @post.save
      redirect_to posts_path, notice: "Post successfully created!"
    # If the post fails to save, render the new post form again
    else
      render :new
    end
  end

  # Updates a post (handles the form submission)
  # Edits a post (displays a form for editing a post)
  def edit
    # Fetch the post from the database and assign it to the @post instance variable
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to post_path(@post), notice: "Post was successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "Post was successfully deleted!"
  end


  private

  # Defines the parameters that are allowed to be submitted by a form
  def post_params
    # Only allow the title and content parameters to be submitted
    params.require(:post).permit(:title, :content)
  end
end
