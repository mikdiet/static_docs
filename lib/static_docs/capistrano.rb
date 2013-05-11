Capistrano::Configuration.instance(:must_exist).load do
  namespace :static_docs do

    desc 'Import all pages to database.'
    task :import do
      rake = fetch(:rake, "rake")
      rails_env = fetch(:rails_env, "production")

      run "cd #{current_path}; #{rake} RAILS_ENV=#{rails_env} static_docs:import"
    end

    after  'deploy:cold', 'static_docs:import'
  end
end
