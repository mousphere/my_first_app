# frozen_string_literal: true

module ApplicationHelper
  def content(use_turbolinks_visit_control)
    'reload' if use_turbolinks_visit_control
  end
end
