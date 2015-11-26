require 'optparse'

module Rebaser
  class Parser
    def initialize(args)
      @args = args
    end

    def parse
      options = {}

      OptionParser.new do |opts|
        opts.on("--username USERNAME", String, "Your github username") do |v|
          options[:username] = v
        end

        opts.on("--password PASSWORD", String, "Your github password") do |v|
          options[:password] = v
        end

        opts.on("--token TOKEN", String, "Your github two factor authentication code") do |v|
          options[:token] = v
        end

        opts.on("--remote REMOTE", String, "The git remote in the form of `timminkov/rebaser`") do |v|
          options[:remote] = v
        end

        opts.on("--branch BRANCH", String, "Branch name to rebase onto") do |v|
          options[:rebase_branch] = v
        end
      end.parse(args)

      options
    end

    private
    attr_reader :args
  end
end
