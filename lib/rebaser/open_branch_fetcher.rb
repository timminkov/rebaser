require 'github_api'

module Rebaser
  class OpenBranchFetcher
    def initialize(username:, password:, token:, remote:, rebase_branch:)
      @username = username
      @password = password
      @token = token
      @remote = remote
      @rebase_branch = rebase_branch
    end

    def fetch
      github = Github.new do |config|
        config.basic_auth = "#{username}:#{password}"
        if token
          config.connection_options = {headers: {'X-GitHub-OTP' => token}}
        end
        config.auto_pagination = true
      end

      remote_user = remote.split('/').first
      remote_repo = remote.split('/').last

      pull_requests = github.pull_requests.list remote_user, remote_repo, state: 'open'

      branches = pull_requests.map { |pr| pr.head.ref if pr.base.ref === rebase_branch }.compact
      branches
    end

    private
    attr_reader :username, :password, :token, :remote, :rebase_branch
  end
end
