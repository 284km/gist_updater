# frozen_string_literal: true

require 'thor'

module GistUpdater
  # CLI Interface
  class Commands < Thor
    package_name 'gist_updater'
    default_task :update
    class_option :yaml, type: :string, aliases: :y,
                        desc: 'User definition YAML file',
                        default: 'gist_updater.yml'
    class_option :user, type: :string, aliases: :u,
                        desc: 'GitHub username'
    class_option :token, type: :string, aliases: :t,
                         desc: 'GitHub personal access token'
    class_option :debug, type: :boolean, aliases: :d,
                         desc: 'Debug mode', default: false

    desc 'update', 'Update your Gist files (default)'
    # CLI Interface to update your Gist
    #
    # @return (see GistUpdater::Updater#update)
    def update
      Updater.new(options).update
    end

    desc 'version', 'Display version'
    # CLI Interface to display version
    #
    # @return (see Kernel.puts)
    def version
      puts VERSION
    end
  end
end
