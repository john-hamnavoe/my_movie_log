# frozen_string_literal: true

class LookUpService
  def self.lookup_values(model, options = { id_to_include: nil })
    model_class = model_class(model)
    model_class.all.order(:name) if model_class
  end

  private

    def self.model_class(model)
      begin
        model.to_s.classify.constantize
      rescue
        nil
      end
    end
end
