# Figaro2eb

Generates a shell script from Figaro's application.yml to set environment variables on an Elastic Beanstalk instance.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'figaro2eb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install figaro2eb

## Usage

1. Install the gem
    ```
    gem install figaro2eb
    ```

2. Go to your Rails app's root directory
    ```
    cd /path/to/application
    ```

3. Run it!
    ```
    figaro2eb target\_rails\_env target\_eb\_env
    ```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/figaro2eb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
