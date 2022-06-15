Jets.application.routes.draw do
  get 'roll/:dice_to_roll', to: 'dice_roller#roll'
  post 'slack/roll', to: 'dice_roller#slack_roll'
  post 'slack/choose', to: 'dice_roller#slack_choose'

  root "jets/public#show"

  # The jets/public#show controller can serve static utf8 content out of the public folder.
  # Note, as part of the deploy process Jets uploads files in the public folder to s3
  # and serves them out of s3 directly. S3 is well suited to serve static assets.
  # More info here: https://rubyonjets.com/docs/extras/assets-serving/
  any "*catchall", to: "jets/public#show"
end
