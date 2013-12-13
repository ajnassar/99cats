class Cat < ActiveRecord::Base
  COLORS = %w(Brown Black White Tiger)
  SEX = %w(M F)
  attr_accessible :age, :birth_date, :color, :name, :sex, :user_id

  validates :age, :birth_date, :color, :name, :sex, :presence => true
  validates :color, :inclusion => COLORS
  validates :sex, :inclusion => SEX
  validates :age, :numericality => true

  has_many(
    :rental_requests,
    :class_name => "CatRentalRequest",
    :dependent => :destroy
    )

    belongs_to :user


end