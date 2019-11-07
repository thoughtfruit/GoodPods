class ItunesWebScraper

  LETTERS = ['a', 'b', 'c', 'd', 'e', 'f', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']

  GENRES = ['podcasts-arts', 'podcasts-business', 'podcasts-comedy', 'podcasts-education', 'podcasts-games-hobbies', 'podcasts-government-organizations',
            'podcasts-health', 'podcasts-kids-family', 'podcasts-music', 'podcasts-news-politics', 'podcasts-religion-spirituality', 'podcasts-science-medicine',
            'podcasts-society-culture', 'podcasts-sports-recreation', 'podcasts-tv-film', 'podcasts-technology']

  def initialize
    @letter_map = LETTERS.map(&:upcase)
    @letter_index = 0
    @genre_index = 0
    @page = 1
    @doc = Nokogiri::HTML(open("https://itunes.apple.com/us/genre/#{GENRES[@genre_index]}/id1301?mt=2&letter=#{@letter_map[@letter_index]}&page=#{@page}"))
    @cluster = Cluster.new
    @network = Network.new
    parse
  end


  def parse
    @page_length = @doc.css('div#selectedcontent li a').group_by(&:text).length

    # Check if there are any podcasts on this page number, for this letter
    if end_of_letter()

      # Get the link attribute for each podcast on this page, and iterate
      @doc.css('div#selectedcontent li a').group_by { |show| begin show['href'] rescue show end}.each do |link|
        if link
          puts "Iterating over podcasts for genre: #{GENRES[@genre_index]} letter #{@letter_map[@letter_index]} in page #{@page}"
          fetch_and_save(link)

          # Check if complete with this page
          if end_of_page()
            # Set a new page and recurse
            @page += 1
            puts "Setting new page: #{@page} and continuing"
            @doc = Nokogiri::HTML(open("https://itunes.apple.com/us/genre/#{GENRES[@genre_index]}/id1301?mt=2&letter=#{@letter_map[@letter_index]}&page=#{@page}"))
            parse
          end
        end
      end
    else
      if end_of_genre()
        # We are at the end (Z) time to set the next genre, start at a, page 1, and recurse
        @genre_index += 1
        @letter_index = 1
        @page = 1
        puts "Setting new genre: #{GENRES[@genre_index]} for letter #{@letter_map[@letter_index]} and page #{@page} continuing"
        @doc = Nokogiri::HTML(open("https://itunes.apple.com/us/genre/#{GENRES[@genre_index]}/id1301?mt=2&letter=#{@letter_map[@letter_index]}&page=#{@page}"))
        parse
      else
        # Set a new letter, start at page 1, and recurse
        @letter_index += 1
        @page = 1
        puts "Setting new letter: #{@letter_map[@letter_index]} and page: #{@page} and continuing"
        @doc = Nokogiri::HTML(open("https://itunes.apple.com/us/genre/#{GENRES[@genre_index]}/id1301?mt=2&letter=#{@letter_map[@letter_index]}&page=#{@page}"))
        parse
      end
    end
  end

  def fetch_and_save(link)
    # Get podcast ID (always last item in link)
    if link != nil
      full_id = link[0].split('/')[link[0].split('/').length - 1]

      # Remove the "id" prefix on all GUIDs
      if full_id
        raw_id = full_id.split('id')[1]

        # Get `feedUrl` from iTunes search API now that we have the ID
        return_string = Faraday.get("https://itunes.apple.com/lookup?id=#{raw_id}").body
        return_json = JSON.parse(return_string)
        if return_json
          if return_json['results']
            if return_json['results'][0]
              feed_url = return_json['results'][0]['feedUrl']

              unless Podcast.where(title: return_json['results'][0]['trackName']).any?
                pod = Podcast.create!(title: return_json['results'][0]['trackName'], cluster: @cluster, network: @network)
                if pod
                  pod.update! feed_url: feed_url
                  pod.update! logo_url: return_json['results'][0]['artworkUrl100']
                end
              end
              puts "Saved podcast #{return_json['results'][0]['trackName']}"
              puts "Page length: #{@page_length}"
              @page_length -= 1
            end
          end
        end
      end
    end
  end

  private
  def end_of_genre
    @letter_map[@letter_index] == "A"
  end

  def end_of_page
    @page_length == 0
  end

  def end_of_letter
    @page_length > 1
  end
end
