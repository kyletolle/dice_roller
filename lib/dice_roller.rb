class DiceRoller
  attr_accessor :number_of_dice_to_roll, :number_of_dice_sides
  def initialize(number_of_dice_to_roll, number_of_dice_sides)
    self.number_of_dice_to_roll = number_of_dice_to_roll
    self.number_of_dice_sides = number_of_dice_sides
  end

  def result
    number_of_dice_to_roll.times.map do
      get_random_number(@number_of_dice_sides)
    end
    .sum
  end

  private

    def get_random_number(max)
      rand(max) + 1
    end
end
