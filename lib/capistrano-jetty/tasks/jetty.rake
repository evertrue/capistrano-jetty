namespace :deploy do
  task :validate do
    on release_roles :all do
      deployed_artifact_filename = fetch(:deployed_artifact_filename)
      jetty_webapps_path         = fetch(:jetty_webapps_path)

      %w(deployed_artifact_filename jetty_webapps_path).each do | var_name |
        var = eval(var_name)

        if var.nil?
          error "capistrano-scm-jenkins: #{var_name} is not set"

          exit 1
        end
      end
    end
  end

  desc 'Grab the latest artifact from the release_path'
  task :update_webapps do
    on roles(:app) do
      execute :cp, "#{release_path}/#{fetch(:deployed_artifact_filename)}",
        "#{fetch(:jetty_webapps_path)}/#{fetch(:deployed_artifact_filename)}"
    end
  end

  desc 'Restart Jetty'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :sudo, :service, 'jetty', 'restart'
    end
  end

  before 'deploy:check', 'deploy:validate'
  before 'deploy:published', 'deploy:update_webapps'
  after 'deploy:published', 'deploy:restart'
end
