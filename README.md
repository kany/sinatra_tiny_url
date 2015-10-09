# Sinatra Tiny Url

App inspired by this tutorial:
http://code.tutsplus.com/tutorials/how-to-build-a-shortlink-app-with-ruby-and-redis--net-20984

This Sinatra app generates a small url with a 5 character code from a given url.  The code in the url generated will have the following characteristics:
- Will be 5 characters long
- Will always be a new code
- Will not differ from another code by only 1 character
- Will not include ambiguous characters such as I,l,1,0,O
- Will not include excluded words

# Setup
1) git clone this repo
2) bundle install
3) type 'rackup', press Enter

# Running Tests
1) type 'cucumber', press Enter
or
2) type 'rspec', press Enter

