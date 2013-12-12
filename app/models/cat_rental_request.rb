class CatRentalRequest < ActiveRecord::Base
  STATUS = %w(APPROVED PENDING DENIED)
  attr_accessible :cat_id, :start_date, :end_date, :status

  validates :cat_id, :start_date, :end_date, :presence => true
  validate :overlapping_requests

  before_validation(on: :create) do
    self.status ||= "PENDING"
  end

  validates :status, :inclusion => STATUS

  belongs_to :cat

  def overlapping_approved_requests
    CatRentalRequest
      .where(:status => "APPROVED")
      .where(:cat_id => cat_id)
      .where("start_date <= ?", end_date)
      .where("end_date >= ?", start_date)
  end


  def overlapping_requests
    unless overlapping_approved_requests.empty?
      errors[:time_period] << "No timeslot available here."
    end
  end
end