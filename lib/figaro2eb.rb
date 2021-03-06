require "figaro2eb/version"
require "yaml"

module Figaro2eb
  class Application

    def initialize
    end

    def run
      self.check_args
      self.load_application_yml
      self.create_script
      self.add_script_to_gitignore
      self.generate_script
    end

    def check_args
      if ARGV.length != 2
        puts "USAGE: figaro2eb target_rails_env target_eb_env"
        exit
      end
    end

    # Load in YAML file
    def load_application_yml
      begin
        @keys = YAML.load_file('config/application.yml')
      rescue
        puts "Cannot find config/application.yml. Are you in your Rails root directory?"
        exit
      end
    end

    # Create bash script
    def create_script
      begin
        @script = File.open('create-env-vars.sh', 'w')
      rescue
        puts "Cannot open create-env-vars.sh. Please try again."
        exit
      end
    end

    # Add the script to your .gitignore
    def add_script_to_gitignore
      if File.readlines(".gitignore").grep(/create-env-vars.sh/).size == 0
        open('.gitignore', 'a') do |file|
          file << "\ncreate-env-vars.sh\n"
        end
      end
    end

    # Generate script
    def generate_script
      # Make sure it's bash!
      @script.write("#!/bin/bash\n")

      # Write out the command...
      @script.write("eb setenv ")

      self.push_keys
      self.push_eb_environment
    end

    # Push the keys that are at the top level
    def push_keys
      @keys.each do |key, value|
        if value.is_a? String 
          @script.write("#{key}='#{value}' ")
        else
          self.rails_environment_check key
        end
      end
    end

    def rails_environment_check key
      if ARGV[0] == key
        self.push_environment_keys key
      end
    end

    def push_environment_keys key
      @keys[key].each do |key, value|
        self.check_value key, value
        self.check_if_value_empty key, value
      end
    end

    def check_value key, value
      if (/^[a-zA-Z0-9\-.:\/@+-]*$/.match(value))
        @script.write("#{key}='#{value}' ")
      else
        puts "The value of #{key} contains special characters that are not allowed by setvar. You will have to manually add this to the EB configuration."
      end
    end

    def check_if_value_empty key, value
      if value.is_a?(String) && value.empty?
        puts "The value of #{key} is empty. You will have to manually add this to the EB configuration."
      end
    end

    def push_eb_environment
      @script.write("-e #{ARGV[1]}")
    end
  end
end
