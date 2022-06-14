class DiceRollerController < ApplicationController
  def get_random_number(max)
    rand(max) + 1
  end

  def roll
    # render json: { rolling: params[:diceToRoll]}
    dice_pattern = /(\d+)d(\d+)/
    dice_to_roll = params[:dice_to_roll]
    @dice_to_roll = dice_to_roll

    match = dice_pattern.match dice_to_roll
    number_of_dice_to_roll = match[1].to_i
    number_of_dice_sides = match[2].to_i

    total_of_rolls = number_of_dice_to_roll.times.map do
      get_random_number(number_of_dice_sides)
    end
    .sum

    @total_of_rolls = total_of_rolls
  end
end
