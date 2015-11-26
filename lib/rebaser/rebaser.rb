require 'inquirer'

module Rebaser
  class Rebaser
    attr_reader :successful_rebases, :failed_rebases

    def initialize(branches, rebase_branch, remote)
      @branches = branches
      @rebase_branch = rebase_branch
      @successful_rebases = []
      @failed_rebases = []
      @remote = remote
    end

    def begin
      checkout(rebase_branch)

      branches.each do |branch|
        checkout(branch)
        puts "Rebasing #{branch} onto #{rebase_branch}"
        output = attempt_rebase

        if output =~ /Automatic merge failed/
          abort_rebase
          failed_rebases << branch
        elsif output =~ /did not match any file/
          failed_rebases << branch
        else
          force_push(branch)
          successful_rebases << branch
        end
      end
    end

    private
    attr_reader :branches, :rebase_branch,:remote

    def checkout(branch)
      system "git checkout #{branch}"
    end

    def attempt_rebase
      system "git rebase #{rebase_branch}"
    end

    def abort_rebase
      system 'git rebase --abort'
    end

    def force_push(branch)
      system "git push -f #{remote} #{branch}"
    end
  end
end
