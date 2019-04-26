n = Network.create!
c = Cluster.create!
Podcast.create! title: "Joe Rogan Podcast", network: n, cluster: c
