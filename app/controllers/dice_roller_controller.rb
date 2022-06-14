class DiceRollerController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:slack_roll]

  def parse_and_roll(dice_roll_string)
    number_of_dice_to_roll, number_of_dice_sides = extract_dice_data dice_roll_string

    DiceRoller.new(number_of_dice_to_roll, number_of_dice_sides).result
  end

  def extract_dice_data(dice_roll_string)
    dice_pattern = /(\d+)d(\d+)/

    match = dice_pattern.match dice_roll_string
    number_of_dice_to_roll = match[1].to_i
    number_of_dice_sides = match[2].to_i

    [number_of_dice_to_roll, number_of_dice_sides]
  end


  # http://127.0.0.1:8888/roll/1d6
  def roll
    @roll_string = params[:dice_to_roll]

    @total_of_rolls = parse_and_roll @roll_string
  end

  # curl -X POST "http://127.0.0.1:8888/slack/roll" -d 'text=1d20'
  def slack_roll
    roll_string = params[:text]

    total_of_rolls = parse_and_roll roll_string

    render json: {
      response_type: "in_channel",
      text: total_of_rolls
    }
  end
end
