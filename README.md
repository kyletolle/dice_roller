# Dice Roller

This application is for rolling dice! You can hit a URL and pass in the number and sided-ness of the dice you want to roll. Like `1d6`, `3d8`, `5d20`, etc.

Try it out at https://b1zjj8qe7e.execute-api.us-west-2.amazonaws.com/dev/roll/5d10 and feel free to change the dice in the URL to your liking.

There are also endpoints that are meant for a Slack slash command to hit for things like `/roll 5d4` and `/choose Lasgna or Mac and Cheese`.

## Dependencies

```
brew install rbenv postgres shared-mime-info
ruby-build -l
rbenv install 2.7.6
rbenv shell 2.7.6
gem install jets
npm install -g yarn
```

## Configuration

```
export AWS_PROFILE=rubyonjets
npm config set registry https://registry.npmjs.org/
```

## Development

```
jets generate controller NAME [action action] [options]
```

## Local Testing

```
jets serve
open http://127.0.0.1:888/roll/2d6
```

# Deployment

```
jets deploy
```
