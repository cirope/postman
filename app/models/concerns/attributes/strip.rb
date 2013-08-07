module Attributes::Strip
  extend ActiveSupport::Concern
  include Attributes::Caller

  module ClassMethods
    def strip_fields *fields
      before_validation do |model|
        call_on_each_field model: model, fields: fields, method: 'strip'
      end
    end
  end
end
