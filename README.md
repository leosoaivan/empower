[![Build Status](https://travis-ci.org/leosoaivan/empower.svg?branch=master)](https://travis-ci.org/leosoaivan/empower)

# Empower
Empower is a client advocacy and management system designed to help you cultivate client relationships, manage the delivery of services, and track outcomes and trends.

The project is currently live [here](https://floating-tor-80170.herokuapp.com/clients), and a guest account is available for poking around. The username is `utester` and the password is `testing123`.

At this moment, the main features available for viewing is searching for clients and basic CRUD operations for episodes/contacts. The search function is implemented by dynamically sending calls to named scopes, which (hopefully) will allow other search parameters to be easily implemented in the future. There is a branch with ElasticSearch installed and set up. However, ES's "more results is better" philosophy didn't quite match what I was looking for, and I couldn't configure ES how I wanted it just yet.

## Getting Started
N/A

### Prerequisites
N/A

### Installing
N/A

## Running the tests
1. Make sure you have RSpec installed

    `gem install rspec`

2. Run the tests!

    `$ rspec`

## Deployment
N/A

## Built With
* [Ruby on Rails](http://rubyonrails.org/) - Web framework
* [Materialize](https://materializecss.com/) - CSS-based frontend framework
* [Heroku](https://www.heroku.com/home) - Cloud platform/server
* [RSpec](http://rspec.info/) - Testing framework
* [Capybara](https://github.com/teamcapybara/capybara) - Integration/Feature testing DSL
* [Travis](https://travis-ci.org) - Continuous integration & delivery
* [Devise](https://github.com/plataformatec/devise) - Authentication, plus [Cancancan](https://github.com/CanCanCommunity/cancancan) and [Rolify](https://github.com/RolifyCommunity/rolify) for authorization and role management, respectively. 

## To-Do
N/A

## Contributing
1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## Versioning
* Ruby 2.4.1
* Rails 5.1.4

## Authors
* LPSV

## License
N/A

## Acknowledgments
* The Odin Project
* Google
* Stack Overflow
* [RailsCasts #163: Self-Referential Association](http://railscasts.com/episodes/163-self-referential-association)
