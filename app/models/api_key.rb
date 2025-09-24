class ApiKey < ApplicationRecord
  # Associations
  belongs_to :user
  
  # Validations
  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :status, presence: true
  
  # Enums
  enum status: {
    pending: 'pending',
    processing: 'processing', 
    completed: 'completed',
    failed: 'failed'
  }
  
  # Scopes
  scope :recent, -> { order(created_at: :desc) }
  scope :active, -> { where.not(status: :failed) }
  
  # Callbacks
  before_create :generate_unique_id
  after_update :notify_status_change, if: :saved_change_to_status?
  
  # Instance methods
  def display_name
    "#{name} (#{id})"
  end
  
  def can_be_processed?
    pending? || failed?
  end
  
  private
  
  def generate_unique_id
    self.external_id = SecureRandom.uuid if external_id.blank?
  end
  
  def notify_status_change
    # TODO: Send notification about status change
    Rails.logger.info "Status changed to #{status} for #{self.class.name} #{id}"
  end
end
