Podcast.all.each(&:destroy)
Cluster.all.each(&:destroy)
Network.all.each(&:destroy)
n = Network.create!
c = Cluster.create!
