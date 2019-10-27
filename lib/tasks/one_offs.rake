namespace :one_offs do

  task :import_relayfm_shows => :environment do
    Podcast.import_from_search('relayfm')
  end

  task :import_earwolf_shows => :environment do
    Podcast.import_from_search('earwolf')
  end

  task :import_venture_capitalist_shows => :environment do
    Podcast.import_from_search('venture podcast')
    Podcast.import_from_search('web development podcast')
    Podcast.import_from_search('angel podcast')
  end

  task :re_ingest_small_logos => :environment do
    Podcast.all.each do |podcast|
      begin
        if podcast.title.include? "Conan" or podcast.title.include? 'Oprah'
        else
          t = HTTParty.get("https://itunes.apple.com/search?term=#{podcast.title} podcast").body
          t = JSON.parse(t)
          podcast.update! logo_url: t['results'][0]['artworkUrl100']
          puts "Updated logo #{podcast.logo_url}".green
        end
      rescue
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

  task :fix_empty_genres => :environment do
    Podcast.where(genre: nil).each do |podcast|
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
