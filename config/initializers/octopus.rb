module Octopus
  def self.shards_in(group=nil)
    config[Rails.env].try(:[], group.to_s).try(:keys)
  end
  def self.followers
    shards_in(:followers)
  end
  class << self
    alias_method :followers_in, :shards_in
    alias_method :slaves_in, :shards_in
  end
end
if Octopus.enabled?
  Octopus.config[Rails.env]['master'] = ActiveRecord::Base.connection.config
  ActiveRecord::Base.connection.initialize_shards(Octopus.config)
end