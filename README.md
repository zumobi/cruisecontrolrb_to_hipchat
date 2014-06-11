This is a little Sinatra app notifies Hipchat of any changes in the build status on your CruiseControl.rb install.

Heroku-ready! Just follow these steps:

## Installation

Install as a gem

    gem install cruisecontrolrb_to_hipchat

or add to your Gemfile

```
# Gemfile
gem "cruisecontrolrb_to_hipchat"
```

and run `bundle install`

or from source

```
git clone git@github.com:zumobi/cruisecontrolrb_to_hipchat.git
cd cruisecontrolrb_to_hipchat
bundle install
rake build
```

## Configuration

Make sure to define the following environment variable as they are required in either
you `.profile` or `/etc/profile.d/cruisecontrolrc_to_hipchat.sh` (for all users)

```
HIPCHAT_AUTH_TOKEN=your_auth_token
HIPCHAT_ROOM_ID=your_room_id
CC_URL=your_cruise_control_url
```

The following are optionals

Basic auth for your CruiseControlrb install (recommended):

```				
CC_USERNAME=your_username
CC_PASSWORD=your_password
```			

```
POLLING_INTERVAL							 # polling interval in minutes. defaults to 1 minute.
HIPCHAT_FROM=cruise-control    # who the messages are "from" in hipchat. defaults to 'cruise-control'		
```

## Running

As this gem uses dante, options are best describes [here](http://github.com/nesquena/dante) but here are some very simple
setup

### Run in foreground and STDOUT output (to test most likely)

```
cruisecontrolrb_to_hipchat
```

### Run in foreground with logs 

```
cruisecontrolrb_to_hipchat -l /var/log/myapp.log
```

### Run as a daemon with a pid file and logs

```
cruisecontrolrb_to_hipchat -d -P /var/run/myapp.pid -l /var/log/myapp.log
```

<img width="100px" src="http://1.bp.blogspot.com/-VYkLIx6dPTE/TapmnuECsJI/AAAAAAAAALY/L3c1FY4v--w/s1600/looney_tunes_thats_all_folks.jpg"  />