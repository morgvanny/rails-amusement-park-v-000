class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    @message =  "Sorry. "
    if enough_tickets && tall_enough
      start_ride
    elsif tall_enough && !enough_tickets
      @message + no_tickets
    elsif !tall_enough && enough_tickets
      @message + too_short
    else
      @message + no_tickets + ' ' + too_short
    end
  end

  def enough_tickets
    if self.user.tickets >= self.attraction.tickets then true else false end
  end

  def tall_enough
    if self.user.height >= self.attraction.min_height then true else false end
  end

  def no_tickets
    "You do not have enough tickets the #{self.attraction.name}."
  end

  def too_short
    "You are not tall enough to ride the #{self.attraction.name}."
  end

  def start_ride
    new_happiness = self.user.happiness + self.attraction.happiness_rating
    new_nausea = self.user.nausea + self.attraction.nausea_rating
    new_tickets =  self.user.tickets - self.attraction.tickets
    self.user.update(
      happiness: new_happiness,
      nausea: new_nausea,
      tickets: new_tickets
    )
    "Thanks for riding the #{self.attraction.name}!"
  end
end
