# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  ALLOWED_CONTENT_TYPES = '
    icon/jpg
    icon/png
    icon/gif
  '
end
