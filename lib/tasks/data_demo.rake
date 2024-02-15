# frozen_string_literal: true

namespace :data do
  desc 'Create demo data using our factories'

  task demo: :environment do
    include FactoryBot::Syntax::Methods
    conference = create(:full_conference, title: 'Open Source Event Manager Demo', short_title: 'moragademo' ,description: "This is a [Moraga Event Manager](https://github.com/opensouthcode/moraga) demo instance. You can log in as **admin** with the password **password123** or just you just [sign up](/accounts/sign_up) with your own user. We hope you enjoy checking out all the functionality, if you have questions don't hesitate to contact us)!\r\n\r\n## Data will be destroyed every thirty minutes or whenever someone updates the [Moraga source code on github](https://github.com/opensouthcode/moraga).")
    conference.contact.update(email: 'moragademo@moraga.io', sponsor_email: 'moragademo@moraga.io')
    create(:admin, email: 'admin@moraga.io', username: 'admin', password: 'password123', password_confirmation: 'password123')
  end
end
