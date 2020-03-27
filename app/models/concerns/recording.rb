module Recording
  extend ActiveSupport::Concern
  
  included do
  end
  
  def recorded
    Recordable.new(self).listened
  end
end

# /episodes/:id/listened
# Episode.new.recorded