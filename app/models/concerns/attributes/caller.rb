module Attributes::Caller
  def call_on_each_field model: nil, fields: nil, method: nil
    raise ArgumentError if [model, fields, method].any? &:blank?

    fields.each do |n|
      model[n] = model[n].method(method).call if model[n].respond_to? method
    end
  end
end
