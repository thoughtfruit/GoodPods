module Recording
  extend ActiveSupport::Concern
  class Test
  
    def recorded
      Recordable.new(self).listened
    end
  end
end

# /episodes/:id/listened
# Episode.new.recorded