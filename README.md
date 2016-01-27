#Install Dependencies
$ gem install thor
$ gem install rspec-kickstarter

#Generate Classes
$ ruby inheritify.rb inherit isr_retention_payment_entry --project_dir=. --template_file=templates/entry_template.erb --spec_dir=.