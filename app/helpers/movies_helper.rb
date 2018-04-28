# frozen_string_literal: true

module MoviesHelper
  def people_text(count)
    base_text = 'people'
    count == 1 ? base_text.singularize : base_text
  end
end
