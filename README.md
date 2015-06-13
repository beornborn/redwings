# redwings
team management service

проект представляет собой приложение для организации эффективного взаимодействия между ментором и учениками.

если вам сообщили, что вы добавлены на проект, убедитесь, что у вас есть доступ на доску RedWings в трелло, и что вы состоите в команде RedWings в гит-оганизации kiev-ruby.

вся необходимая информация о проекте на данный момент находится в этом ридми и на доске RedWings

если возникли вопросы, обращайтесь к ментору в slack


в трелло пользуйтесь лейблами, когда переводите в ready, добавляйте меня в мемберы таска.
выполненные задания заливаем в соответстующей ветке, делаем пул-реквест, ассайним на меня

WORKING WITH THE GIT-FLOW APPROACH http://danielkummer.github.io/git-flow-cheatsheet/

relation model
https://drive.google.com/file/d/0B4NAAlVHXYk5a3FWTG1XWXp3U28/view?usp=sharing (open via draw.io)


# Setup guide:

##### Install PostqreSQL version 9.4 [more](http://www.postgresql.org/download/linux/ubuntu/)

###### 1. Update (or create it if it isn’t there) the file named /etc/apt/sources.list.d/pgdg.list and add this line "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" to it:

* terminal: echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" | sudo tee -a /etc/apt/sources.list.d/pgdg.list

###### 2. Update the apt-get repostitor with the following two lines (note the first threes lines are a single continued command line):

* terminal: wget --quiet -O - \ https://www.postgresql.org/media/keys/ACCC4CF8.asc | \ sudo apt-key add - sudo apt-get update

###### 3. Install Postgres 9.4:

* terminal: sudo apt-get install postgresql-9.4

###### 4. Install pgAdmin III:

* terminal: sudo apt-get install pgadmin3


##### Bundler install [more](http://bundler.io)

* terminal: gem install bundler 

##### Configuration

* terminal: git clone https://github.com/kiev-ruby/redwings.git 

* terminal: bundle install

##### Setup your databases from the command line [more](https://www.digitalocean.com/community/tutorials/how-to-setup-ruby-on-rails-with-postgres)

Login to postgresql prompt as the postgres user

* terminal: sudo su postgres -c psql

* terminal: CREATE DATABASE database_name;


##### Run

* terminal: rails s 

##### Work with git flow 

* http://danielkummer.github.io/git-flow-cheatsheet/

