module ApplicationHelper

  # To reset the sequence of the ID in a table.
  # TODO: Move somewhere else
  def resetTableID
    ActiveRecord::Base.connection.reset_pk_sequence!('users')
  end


   # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Ruby on Rails Tutorial Sample App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  # Instruments column sorting
  def sortable(column, title=nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    logger.tagged("INSTRUMENT:") { logger.info "direction #{direction}" }
    logger.tagged("INSTRUMENT:") { logger.info "sort: #{title}" }
    link_to title, sort: column, direction: direction
  end


  def current_user_email
    session[:current_user_email] || 'No email is saved.'
  end
end
