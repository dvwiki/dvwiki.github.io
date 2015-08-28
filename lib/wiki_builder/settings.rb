require 'yaml'

module WikiBuilder
  # Loads configuration data and makes it accessible
  module Settings
    # There was a request to operate on the settings, but settings haven't been
    # loaded before.
    class SettingsNotLoadedError < RuntimeError
    end

    # There was a request to load the settings, but settings have already been
    # loaded before.
    class SettingsAlreadyLoadedError < RuntimeError
    end

    # Are the settings already loaded?
    #
    # @return [Boolean]
    def self.loaded?
      !@settings.nil?
    end

    # Loads the configuration, needs to be done before everything else, also
    # it is not allowed to call it twice!
    #
    # @param path [String, Path] The path where the config file should be
    # @return [NilClass] the return-value shall be used for nothing, therefore
    #   it is nil!
    # @raise [SettingsAlreadyLoadedError] When configuration was already loaded
    def self.load(path = './settings.yml')
      fail 'Configuration already loaded!' unless @settings.nil?
      @settings = (YAML.load_file path)['settings']
      nil
    end

    # Returns any configuration value associated with the given `key`.
    #
    # @param key [String, Symbol] The key for the value
    # @return [String, Hash, NilClass] The value associated with `key`
    # @raise [SettingsNotLoadedError] When you have not called {.load} before.
    # @raise [ArgumentError] when the given `key` is neither a `String` nor a
    #   `Symbol`
    def self.[](key)
      fail SettingsNotLoadedError unless self.loaded?
      fail ArgumentError unless [String, Symbol].member? key.class
      @settings[key.to_s]
    end
  end
end
