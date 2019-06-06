require 'rest-client'
require 'json'
require 'yaml'

def users_api_call(id)
  user_id = id.to_i
  if user_id != 0
    query_specific_user(user_id)
  else
    query_all_data
  end
end

def query_specific_user(user_id)
  api_info = RestClient.get("https://reqres.in/api/users/#{user_id}")
  user_data = JSON.parse(api_info).to_yaml()
  File.open("users.yml", 'w') { |file| file.write(user_data) }
  puts File.read("users.yml")
end

def query_all_data
  api_info = RestClient.get("https://reqres.in/api/users/")
  user_data = JSON.parse(api_info)
  total = JSON.parse(api_info)["total"]
    (1..total).each do |n|
      api_info = RestClient.get("https://reqres.in/api/users/#{n}")
      user_data = JSON.parse(api_info).to_yaml()
      File.open("users.yml", 'w') { |file| file.write(user_data) }
      puts File.read("users.yml")

    end
end

def welcome
  puts "Hello! Please enter an id or leave blank"
end

def get_id
  gets.chomp
end

def run_program
  welcome
  id = get_id
  users_api_call(id)
end

run_program
