namespace :deploy do
  desc 'Grab the latest artifact from '
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

  before :published, :update_webapps
  after :published, :restart
end
