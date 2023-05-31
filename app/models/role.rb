class Role < ActiveRecord::Base
   has_many :auditions
   def actors
    auditions.pluck(:actor)
  end

  def locations
    auditions.pluck(:location)
  end

  def auditions
    Audition.where(role_id: id)
  end

  def lead
    hired_audition = auditions.find_by(hired: true)
    hired_audition || 'No actor has been hired for this role'
  end

  def understudy
    hired_auditions = auditions.where(hired: true).limit(2)
    if hired_auditions.length >= 2
      hired_auditions[1]
    else
      'No actor has been hired for understudy for this role'
    end
  end
end