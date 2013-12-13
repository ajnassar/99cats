# encoding: utf-8
module SessionsHelper
  def current_user
    User.find_by_session_token(session[:session_token])
  end

  def login_user!(user)
    session[:session_token] = user.session_token
  end

  def require_logged_in!
    if current_user.nil?
      flash[:errors] = "Please log in to view awesome cats! :)"
      redirect_to new_session_url
    end
  end

  def require_cat_ownage!
    cat = Cat.find_by_id(params[:id])
    if current_user.id != cat.user_id
      flash[:errors] = "You do not own that cat! Cannot edit! (╯°□°）╯︵ ┻━┻"
      redirect_to cat_url(cat.id)
    end
  end
end
