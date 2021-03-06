class Player < ApplicationRecord
  
  include PgSearch
  pg_search_scope :search_by_full_name, :against => [ [:first_name, 'B'], [:last_name, 'A']], :using => { :tsearch => { :prefix => true } }

  has_many :crimes
  has_many :teams, -> { distinct }, through: :crimes
  has_many :positions, -> { distinct }, through: :crimes
  has_many :legal_encounters, -> { distinct }, through: :crimes
  has_many :crime_categories, -> { distinct }, through: :crimes

  # Scopes 
  scope :top, -> { select("players.id, COUNT(crimes.id) AS crimes_count").joins(:crimes).group("players.id").order("crimes_count DESC").limit(10).map(&:id) }

  def titleized_full_name
    "#{first_name.titleize} #{last_name.titleize}"
  end

  def last_arrest_associated_team
    latest_crime.team
  end

  def last_arrest_associated_position
    latest_crime.position
  end

  def crimes_count
    crimes.count
  end

  private 

  def latest_crime
    crimes.order('date_of_incident DESC').first
  end
end
