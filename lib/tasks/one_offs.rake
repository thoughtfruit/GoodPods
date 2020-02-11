namespace :one_offs do

  task :start_import => :environment do
    DiscoveryService.start!
  end
  
  task :new_pods => :environment do
    PodcastIngestion.search 'relayfm'
    PodcastIngestion.search 'earwolf'
    PodcastIngestion.search 'earwolf'
    PodcastIngestion.search 'venture podcast'
    PodcastIngestion.search 'web development podcast'
    PodcastIngestion.search 'angel podcast'
    PodcastIngestion.search 'angel podcast'
    PodcastIngestion.search "grad school"
    PodcastIngestion.search "graduate school"
    PodcastIngestion.search "physics frontiers"
    PodcastIngestion.search "physics"
    PodcastIngestion.search "cosmology"
    PodcastIngestion.search "astrophysics"
    PodcastIngestion.search "getting things done"
    PodcastIngestion.search "gtd"
    PodcastIngestion.search "dungeons and dragons"
    PodcastIngestion.search "video games"
    PodcastIngestion.search "self help"
    PodcastIngestion.search "real social dynamics"
    PodcastIngestion.search "grounded"
  end

  task :re_ingest_small_logos => :environment do
    Podcast.order("created_at desc").all.each do |podcast|
      t = HTTParty.get("https://itunes.apple.com/search?term=#{podcast.title} podcast").body
      t = JSON.parse(t)
      unless logo_url == t['results'][0]['artworkUrl100']
        podcast.update! logo_url: t['results'][0]['artworkUrl100']
      end
      puts "Updated logo #{podcast.logo_url}".green
    end
  end

  task :add_pods_to_collections => :environment do
    # Step 1
    PodcastIngestion.search('network_you_wanna_add podcasts')

    # Step 2
    ['add_networks_youve_already_imported_here_to_add_to_collection'].each do |network|
      c = Collection.find_or_create_by(title: network)
      PodcastIngestion.find(network).each do |result|
        if result
          p = Podcast.where(title: result['collectionName'])
          p.first.update! collection_id: c.id
          puts "Saved podcast #{p.first.title} to collection #{c.title}".green
        end
      end
    end
  end

  task :add_large_logos => :environment do
    Podcast.all.each do |podcast|
      begin
        if podcast.title.include? "Conan" or podcast.title.include? 'Oprah'
        else
          t = HTTParty.get("https://itunes.apple.com/search?term=#{podcast.title} podcast").body
          t = JSON.parse(t)
          podcast.update! logo_url_large: t['results'][0]['artworkUrl600']
          puts "Updated logo with large variant #{podcast.logo_url_large}".green
        end
      rescue
      end
    end
  end

  task :fix_empty_bios => :environment do
    Podcast.where(bio: nil).each do |podcast|
      begin
        if podcast.title.include? "Conan" or podcast.title.include? 'Oprah'
        else
          t = HTTParty.get("https://itunes.apple.com/search?term=#{podcast.title} podcast").body
          t = JSON.parse(t)
          if t['results'][0]['feedUrl']
            @feed_xml = Nokogiri::XML(open(t['results'][0]['feedUrl']))
            bis = @feed_xml.at('rss').at('channel').at('description').inner_html()
            bio = bio.strip
            podcast.update! bio: bio
            puts "Updated #{podcast.title} bio with feed description".red
          else
            podcast.update! bio: t['results'][0]['longDescription']
            puts "Updated #{podcast.title} bio with longDescription".green
          end
        end
      rescue
        next
      end
    end
  end

  task :fix_genres => :environment do
    Podcast.all.each do |podcast|
      begin
        if podcast.title.include? "Conan" or podcast.title.include? 'Oprah'
        else
          t = HTTParty.get("https://itunes.apple.com/search?term=#{podcast.title} podcast").body
          t = JSON.parse(t)
          podcast.update! genre: t['results'][0]['genres'][0]
          puts "Updated #{podcast.title} genre".green
        end
      rescue
        next
      end
    end
  end

end
