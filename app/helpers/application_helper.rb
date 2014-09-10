module ApplicationHelper
  def flash_class name
    # Translate rails conventions to bootstrap conventions
    case name.to_sym
    when :notice
      :success
    when :alert
      :error
    else
      name
    end
  end

  def row_status_class game
    if game.won?
      :won
    elsif game.lost?
      :lost
    else
      :playing
    end
  end

  def user_sans_current
    User.where.not(id: current_user.id)
  end

  def show_challenger(game)
    if game.challenged_user == current_user
      game.user.email
    else
      game.challenged_user.email
    end
  end

  def show_play?(game)
    return true unless game.challenged_user
    return true if game.challenged_user == current_user
  end

end
