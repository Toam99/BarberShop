require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def get_db 
    db = SQLite3::Database.new 'barbershop.db'
    db.results_as_hash = true
    return db
end

configure do
    db = get_db
    db.execute 'CREATE TABLE IF NOT EXISTS  
        "Users" 
        (
            "Id" INTEGER PRIMARY KEY AUTOINCREMENT, 
            "username" TEXT, 
            "phone" TEXT, 
            "date_stamp" TEXT, 
            "barber" TEXT, 
            "color" TEXT
        )'
end 

get '/' do
       erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School !!!</a>"            
end

get '/about' do       
    erb :about
end

get '/visit' do
    erb :visit
end

get '/contacts' do
    erb :contacts
end

post '/visit' do

    @username = params[:username]
    @phone = params[:phone]
    @datetime = params[:datetime]
    @barber = params[:barber]
    @color = params[:color]

    # hash for validation
    hh = {    :username => 'Enter your name',
              :phone => 'Enter your phone number',
              :datetime => 'Enter date and time' }

    @error = hh.select {|key,_| params[key] == ''}.values.join(", ")

    if @error != ''
        return erb :visit
    end

    db = get_db
    db.execute 'insert into 
    Users 
    (
        username, 
        phone, 
        date_stamp, 
        barber, 
        #color
    )
    values ( ?, ?, ?, ?, ?)', [@username, @phone, @datetime, @barber, @color] 

    erb "OK, username is #{@username}, #{@phone}, #{@datetime}, #{@barber}, #{@color}"

end

get '/showusers' do        
    erb "Hello World"
end
