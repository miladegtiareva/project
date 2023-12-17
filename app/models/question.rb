class Question < ApplicationRecord
  include Authorship
    has_many :answers, dependent: :destroy
    belongs_to :user
    validates :title, presence: true
    validates :content, presence: true
    scope :search_by_title, ->(query) { where('LOWER(content) LIKE ?', "%#{query.downcase}%") if query.present? }
  end