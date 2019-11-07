class DailyJob
	# include Synchronizer

	# Set synchronizer to run every hour
	def initialize
		Eventor.step_one   = DiscoverService
		Eventor.step_two   = PodcastIngestionService
		Eventor.step_three = XmlValidationService
		Eventor.step_four  = EpisodeIngestionService
		Eventor.step_five  = DatabaseCleaningService
		begin
			Synchronizer.run!
		rescue SynchronizerError
			puts "some shit"
		end
	end

end