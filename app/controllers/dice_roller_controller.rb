class DiceRollerController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:slack_roll, :slack_choose]


  def roll_result(number_of_dice_to_roll, number_of_dice_sides)
    DiceRoller.new(number_of_dice_to_roll, number_of_dice_sides).result
  end

  def parse_and_roll(dice_roll_string)
    number_of_dice_to_roll, number_of_dice_sides = extract_dice_data dice_roll_string

    roll_result(number_of_dice_to_roll, number_of_dice_sides)
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

  # curl -X POST "http://127.0.0.1:8888/slack/choose" -d 'text=MHW%20or%20GRW'
  def slack_choose
    choose_string = CGI.unescape(params[:text])
    puts "string input ${choose_string}"

    choose_pattern = /(.+) or (.+)/
    match = choose_pattern.match choose_string
    puts "match", match
    even_choice = match[1]
    odd_choice = match[2]

    single_die = 1
    twenty_sided = 20
    number = roll_result(single_die, twenty_sided)

    is_even = (number % 2) === 0

    text = ''
    if is_even
      text = "Even roll, so choice is: #{even_choice}"
    else
      text = "Odd roll, so choice is: #{odd_choice}"
    end

    render json: {
      response_type: "in_channel",
      text: text,
    }
  end
end
