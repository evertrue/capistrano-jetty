namespace :deploy do
  task :validate do
    on release_roles :all do
      deployed_artifact_filename = fetch(:deployed_artifact_filename)
      jetty_webapps_path         = fetch(:jetty_webapps_path)

      %w(
        deployed_artifact_filename
        jetty_webapps_path
      ).each do | var_name |
        var = eval(var_name)

        if var.nil?
          error "capistrano-jetty: #{var_name} is not set"

          exit 1
        end
      end
    end
  end

  desc 'Stop Jetty, deploy artifact, start Jetty'
  task :rolling_restart do
    on roles(:app), in: :sequence, wait: 5 do |server|
      execute :sudo, :service, 'jetty', 'stop'

      execute(
        :cp,
        "#{release_path}/#{fetch(:deployed_artifact_filename)}",
        "#{fetch(:jetty_webapps_path)}/#{fetch(:deployed_artifact_filename)}"
      )

      execute :sudo, :service, 'jetty', 'start'
    end
  end

  before 'deploy:check', 'deploy:validate'
  after 'deploy:publishing', 'deploy:rolling_restart'
end
