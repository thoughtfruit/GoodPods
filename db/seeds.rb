Podcast.all.each(&:destroy)
Cluster.all.each(&:destroy)
Network.all.each(&:destroy)
n = Network.create!
c = Cluster.create!
Podcast.create! title: "Joe Rogan Podcast", network: n, cluster: c
Podcast.create! title: "Start Here: Ruby on Rails", network: n, cluster: c
Podcast.create! title: "Jocko Podcast", network: n, cluster: c
Podcast.create! title: "JavaScript Jabber", network: n, cluster: c
Podcast.create! title: "The Ruby on Rails Show", network: n, cluster: c
Podcast.create! title: "Road Work", network: n, cluster: c
Podcast.create! title: "Mueller She Wrote", network: n, cluster: c
