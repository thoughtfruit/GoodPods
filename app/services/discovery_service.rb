#### ==== Examples
#
#     DiscoveryService.for \
#       scraper: Scraper::Podcasts::Chartable
#
#     DiscoveryService.for \
#       scraper: Scraper::Episodes
#
class DiscoveryService
  
  def self.for podcasts:, episodes:, scraper:
    @scraper = scraper
    scraper.new
  end

end
