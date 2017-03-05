class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  belongs_to :user
  has_many :ticket_types

  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}

  def self.published?
    where.not(published_at: nil)
  end

  def self.search(name)
    if name
      self.where("name ILIKE ? AND starts_at > ? AND published_at IS NOT NULL", "%#{name}%", Time.now)
    else
      where("starts_at > ? AND published_at IS NOT NULL", Time.now)
    end
  end
end
