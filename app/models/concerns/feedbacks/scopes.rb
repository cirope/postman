module Feedbacks::Scopes
  extend ActiveSupport::Concern

  module ClassMethods
    def first_from from
      find_by from: from.downcase
    end
  end
end
