namespace :deploy do
  task :validate do
    on release_roles :all do
      deployed_artifact_filename = fetch(:deployed_artifact_filename)
      jetty_webapps_path         = fetch(:jetty_webapps_path)
      load_balancer_backend      = fetch(:load_balancer_backend)

      %w(
        deployed_artifact_filename
        jetty_webapps_path
        load_balancer_backend
      ).each do | var_name |
        var = eval(var_name)

        if var.nil?
          error "capistrano-jetty: #{var_name} is not set"

          exit 1
        end
      end
    end
  end

  desc 'Rotate servers out of HAProxy pool, stop Jetty, deploy artifact, ' \
       'restart Jetty, rotate server back into HAProxy pool'
  task :rolling_restart do
    on roles(:app), in: :sequence, wait: 5 do |server|
      current_app_server = server.hostname

      on roles(:load_balancer) do
        execute(
          :sudo,
          '/usr/local/bin/haproxyctl',
          'disable server',
          "#{fetch(:load_balancer_backend)}/#{current_app_server}"
        )
      end

      sleep 3

      execute :sudo, :service, 'jetty', 'stop'

      execute(
        :cp,
        "#{release_path}/#{fetch(:deployed_artifact_filename)}",
        "#{fetch(:jetty_webapps_path)}/#{fetch(:deployed_artifact_filename)}"
      )

      execute :sudo, :service, 'jetty', 'start'

      on roles(:load_balancer) do
        execute(
          :sudo,
          '/usr/local/bin/haproxyctl',
          'enable server',
          "#{fetch(:load_balancer_backend)}/#{current_app_server}"
        )
      end
    end
  end

  before 'deploy:check', 'deploy:validate'
  after 'deploy:publishing', 'deploy:rolling_restart'
end
