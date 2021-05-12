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
end
