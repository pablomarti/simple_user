namespace :simple_user do
	Rake::Task['db:seed'].enhance ['simple_user:load_first_admin']

	desc "Loads first admin into DB"
	task :load_first_admin => :environment do
		admin_user = SimpleUser::AdminUser.new(
			:username => "admin",
			:email => "admin@example.com",
			:password => "welcome123",
			:password_confirmation => "welcome123"
		)
		admin_user.save

		admin_user.add_role "admin"
	end
end