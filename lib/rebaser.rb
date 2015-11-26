require 'inquirer'
require 'io/console'

require 'rebaser/version'
require 'rebaser/open_branch_fetcher'
require 'rebaser/rebaser'

module Rebaser
  def self.execute(options)
    puts 'Rebaser'
    puts 'Wanna grow up to be'
    puts '♫  Be a rebaser  ♫'
    puts "\n"
    puts 'Fetching branches...'

    unless options[:username]
      options[:username] = Ask.input "Github username"
    end

    unless options[:password]
      puts "Github password:"
      options[:password] = STDIN.noecho(&:gets).chomp
    end

    unless options[:remote]
      options[:remote] = Ask.input "Where should I fetch branches from (in the form of `timminkov/rebaser`"
    end

    unless options[:token]
      if Ask.confirm "Need to enter a 2 factor authentication code?"
        options[:token] = Ask.input "2 factor code"
      end
    end

    branches = OpenBranchFetcher.new(
      username: options[:username],
      password: options[:password],
      token: options[:token],
      remote: options[:remote],
    ).fetch

    puts "\n\nHere's what I'll be rebasing today:\n"
    puts branches
    puts "\nI'll rebase these branches onto #{options[:rebase_branch]}."
    puts "If I run into merge conflicts, I'll skip that branch."
    puts "This can be dangerous as I will be force pushing."
    continue = Ask.confirm "Are you sure you want to continue?", default: false

    return unless continue

    remote = Ask.input "Please enter the remote name to push to", default: 'origin'
    unless options[:rebase_branch]
      options[:rebase_branch] = Ask.input "Please enter the branch to rebase onto", default: 'master'
    end

    rebaser = Rebaser.new(branches, options[:rebase_branch], remote)
    rebaser.begin

    puts "\nAll done!"
    puts "#{rebaser.successful_rebases.size} branches successfully rebased and pushed."
    puts "#{rebaser.failed_rebases.size} branches failed to rebase."
  end
end
