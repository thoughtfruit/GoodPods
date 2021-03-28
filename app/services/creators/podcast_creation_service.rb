class Creators::PodcastCreationService

  def initialize(podcast:)
    build podcast
    and_store
  end

  private
    def build podcast
      @podcast = Podcast.find_by title: podcast[0].strip
    end

    def and_store
      puts "Storing"
      Podcast.store @podcast if @podcast
    end
end # /class
