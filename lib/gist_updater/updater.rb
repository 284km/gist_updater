# frozen_string_literal: true

module GistUpdater
  # Updates according to user configuration
  class Updater
    # @param options [Hash] options generated by Thor
    # @param config_class [Class] a Class which has configuration duty
    def initialize(options, config_class = Config)
      @user             = options[:user] || ENV['GISTUPDATER_USER']
      @access_token     = options[:token] || ENV['GISTUPDATER_ACCESS_TOKEN']
      @config           = config_class.new(options[:yaml])
      GistUpdater.debug = options[:debug]
    end

    # Update your Gist
    #
    # @return [Array<Sawyer::Resource>] Updated resource(s)
    def update(content_class = Content)
      updated = []

      config.each do |gist_id:, file_paths:|
        file_paths.each do |file_path|
          updated << update_by_gist(gist_id, file_path, content_class)
        end
      end

      updated.compact
    end

    private

    attr_reader :user, :access_token, :config

    # Update a Gist file
    #
    # @return (see GistUpdater::Content#update_if_need)
    def update_by_gist(id, file_path, content_class)
      content_class.new(
        user: user,
        access_token: access_token,
        gist_id: id,
        file_path: file_path
      ).update_if_need
    end
  end
end
