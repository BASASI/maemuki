class StatusAnalyzer
  @queue = :default

  def self.perform(user)
    identity = user.identities.find_by(provider: 'twitter')
    identity.statuses.group_by { |status| status.created_at.to_date }.each do |date, statuses|
      results = iminos(statuses.map(&:text))
      stat = identity.statistics.build(date: date, count: statuses.length)
      results.each do |result|
        case result.spn.to_i
        when 1 then stat.positive_count += 2
        when 2 then stat.negative_count += 2
        when 3 then stat.positive_count += 1
        when 4 then stat.negative_count += 1
        end
      end
      stat.save!
    end
  end

  def self.iminos(statuses)
    iminos_client.request statuses
  end

  def self.iminos_client
    Iminos::Client.new { |config| config.access_key = 'X5VcCPy7pdtWKXCo' }
  end
end
