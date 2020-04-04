class StepByStep

  def initialize
    @return_data = nil
    @states = []
  end

  def self.run!
    new.step_one
    @states << {started: true}
  end

  def step_one klass
    @states << {step_one: started}
    @return_data = klass.new
    @states << {step_one: completed}
    step_two
  end

  def step_two klass
    @states << {step_two: started}
    @return_data = klass.new(@return_data)
    @states << {step_two: completed}
    step_three
  end

  def step_three klass
    @return_data = klass.new(@return_data)
    step_four
  end

  def step_four klass
    @return_data = klass.new(@return_data)
    step_five
  end

  def step_five klass
    @return_data = klass.new(@return_data)
    done
  end

  private
  def done
    end
end
