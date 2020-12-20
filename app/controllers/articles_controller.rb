class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :autorize_autotification, only: [:new, :create, :edit, :destroy, :update, :new_comment, :create_comment]
  # before_action :redirect_user_article, only: [ :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
    #@comments = Comment.all

  end

  def search
    @articles = Article.where("title LIKE ?","%" + params[:q] + "%")
  end
  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @point = 1
    @article = Article.new(article_params)

    @article.user = @current_user
    @current_point = @article.user.point

    respond_to do |format|
      if @article.save
        #mise a jour du point de l'utilisateur courant
        @current_user.point = @current_point + @point
        #recherche de l'utilisateur pour sauvegarder les modifications
        @users = User.where(id: @current_user.id)
        @users.each do |user_modification|
          user_modification.update_attribute(:point, @current_user.point)
          user_modification.save
        end
        # #on recupere l'id du commentaire 
         @comment = Comment.new
         @comment.article = @article
        # @comment.save
        @content = Content.new
        @content.userid = @current_user.id
        @content.username = @current_user.username
        @content.article_id = @article.id
        @content.content = @article.content
        @content.save


        # #User.update(@current_user)
        # #@update_user.point = @current_point + @point
        # logger.info " -> nombre de points: .... : " + @current_user.point.to_s + " /// User  ////////// : " +  @current_user.name.to_s 

        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    @point = 0.5
    @last_user = @article.user
    @article.user = @current_user
    @current_point = @article.user.point
    # respond_to do |format|
    # logger.info "last user ::::::::::: " + @last_user.id.to_s
    # logger.info "New user ========== " + @article.user.id.to_s

    if @article.update(article_params)
        #mise a jour du point de l'utilisateur courant
        @article.user.point = @current_point + @point
        #recherche de l'utilisateur pour sauvegarder les modifications
        @users = User.where(id: @current_user.id)
        @users.each do |user_modification|

          user_modification.update_attribute(:point, @current_user.point)
          user_modification.save
        end

        #notification du l'ancien editeur apres un save de l'update
        NotificationModificatedMailer.when_modificated(@last_user).deliver_now

        #mise a jour du contenu
        @content = Content.new
        @content.userid = @current_user.id
        @content.username = @current_user.username
        @content.article_id = @article.id
        @content.content = @article.content
        @content.save

        #logger.info "Coucou" 
        #logger.info  @content.article_id.to_s
        #logger.info  @content.content.to_s
        # format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        # format.json { render :show, status: :ok, location: @article }
      # else
      #   format.html { render :edit }
      #   format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    # end
  end

  #gestion des commentaires : 
  def index_comment
    @comments = Comment.all
  end

  #comments new
  def new_comment
    @comment = Comment.new
  end

  #comments create
  def create_comment
    @comment = Comment.new(comment_params)
    #@comment.article_id = @article.id

    logger.info "Commentaire id: " + @comment.id.to_s
    logger.info "Commentaire id: " + @comment.comment.to_s
    logger.info "Commentaire user: " + @comment.user_id.to_s
    logger.info "Commentaire article: " + @comment.article_id.to_s

    if @comment.save
        logger.info "Commentaire id: " + @comment.id.to_s
        logger.info "Commentaire user: " + @comment.user_id.to_s
        logger.info "Commentaire article: " + @comment.article_id.to_s
        redirect_to '/articles'
        else
            redirect_to new_comment_path, notice: 'Error, comments invalid !'
    end 
  end



  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    #authetifation user
    def autorize_autotification
      if @current_user.nil?
        redirect_to sign_in_path
      end
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content, :image)
    end

    #params of comments
    def comment_params
      params.require(:comment).permit(:comment, :article_id, :user_id)
    end

    # def redirect_user_article
    #   if @current_user.id == @article.user.id
    #     redirect_to action: 'show', id: @current_user.id
    #   end 
    # end
end
