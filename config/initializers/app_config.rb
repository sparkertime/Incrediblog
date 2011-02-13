class YamlConfig
  def initialize(file)
    @settings = YAML.load_file(file)
    @settings.each do |key, value|
      instance_eval <<-END_METHOD
      def self.#{key}
        @settings[#{key.inspect}]
      end
    END_METHOD
    end
  end
end

config_path = Rails.root.join('config', 'config.yml')
raise 'Please copy <root>/config/config.yml.example into <config>.yml and update accordingly before running the app' unless config_path.exist?

AppConfig = YamlConfig.new(config_path)
