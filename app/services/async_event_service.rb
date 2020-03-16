class AsyncEventService

  def initialize(actor:, step_one:, step_two:)
    @actor    = actor
    @step_one = step_one
    @step_two = step_two
  end

  def run
    @threads.each(&:join)
  end

  def pool
    @threads = steps.map { |step|
      Thread.new { @actor.send(step) }
    }
    self
  end

  def steps
    [@step_one, @step_two]
  end
end
