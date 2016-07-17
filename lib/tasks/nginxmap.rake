task :nginxmap => :environment do
  puts %Q(map $uri $rails_route_list {\n    default "false";)
  routelist = Rails.application.routes.routes
  paths = routelist.collect { |path| /[^:(*]*/.match(path.path.spec.to_s)[0] }
  paths.uniq!
  paths << '/$' if paths.delete("/")
  paths.map! { |path| %Q(    ~^#{path} "true";) }
  puts paths
  puts "}"
end
