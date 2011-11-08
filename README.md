AlexPearce.me Sinatra App
=========================

A very simple Sinatra app for my homepage. Arguably Sinatra is too much for something like this, but I wanted to find out what all the hubbub was about. (Also, I don't think it is too much, it was either this or PHP, and I think this is *far* prettier, which is what really counts.)

Environment variables `GMAIL_PW` and `LASTFM_KEY` should be set in a config file somewhere:

    export GMAIL_PW="super_secret"
    export LASTFM_KEY="also_super_secret"
    
I keep mine in `~/.env`, then source this is `~/.bashrc`:

    if [ -f ~/.env ]; then
      . ~/.env
    fi
    
Tests are run with `rspec spec`.