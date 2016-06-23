namespace :db do
  desc "Backup postgresql database and paperclip data and save it in database-files"
  task :backup => :environment do
    CONFIG = Rails.configuration.database_configuration
    DB = CONFIG[Rails.env]["database"]
    USER = CONFIG[Rails.env]["username"]
    PW = CONFIG[Rails.env]["password"]
    today_s = Date.today.strftime("%Y_%m_%d")
    rails_root = Rails.root

    Dir.mkdir("#{rails_root}/database_backups/files") unless File.exists?("#{rails_root}/database_backups/files")
    system "PGPASSWORD='#{PW}' /usr/bin/pg_dump -U #{USER} -E UTF-8 #{DB} > #{rails_root}/database_backups/#{DB}_#{today_s}.sql"

    if File.exist? "#{Rails.root}/public/system"
      system "/bin/tar zcfv database_backups/files/#{DB}_files_#{today_s}.tgz #{rails_root}/public/system"
    end
  end
end
