Cluster.all.each(&:destroy)
Network.all.each(&:destroy)
Group.all.each(&:destroy)
n = Network.create!
c = Cluster.create!

podcast = Podcast.last
genre = Genre.last

Group.create!(
  title: "Group 1",
  description: "Group for podcasts",
  podcast: podcast,
  genre: genre
)
