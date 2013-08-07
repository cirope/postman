module Attributes::Downcase
  extend ActiveSupport::Concern
  include Attributes::Caller

  module ClassMethods
    def downcase_fields *fields
      before_validation do |model|
        call_on_each_field model: model, fields: fields, method: 'downcase'
      end
    end
  end
end
