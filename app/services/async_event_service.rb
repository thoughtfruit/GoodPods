class AsyncEventService

  def initialize(actor:, steps:)
    @actor = actor
    @steps = steps
    pool
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
    @_steps ||= @steps
  end
end
