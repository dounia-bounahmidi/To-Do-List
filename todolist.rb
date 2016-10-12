# Modules to store prompts and strings 

module Menu 
	def menu
		"Welcome to ToDoApp.
		Menu: 
		1) Add
                2) Display
                3) Update
                4) Delete
                5) Write to a file
                6) Read from a file
                7) Set task status 
                Q) Quite the application"
    end 

    def show 
    	puts menu
    end 
end 

module Promptable
	def prompt(message="what would you like to do?", symbol=":>")
		puts message 
		puts symbol 
		gets.chomp
	end
end 

# Classes to create lists and tasks instances 

class List
	attr_reader :all_tasks

	def initialize 
		@all_tasks = [] 
	end 

	def add(task) 
		all_tasks.push(task)
	end 

	def display 
		all_tasks.map.with_index do |task, index| 
			"#{index}: #{task}" 
		end
	end

	def update(new_task, i)
		all_tasks[i.to_i] = new_task
	end 

	def delete(task_number)
		all_tasks.delete_at(task_number.to_i)
	end

	def write_to_file(filename) 
		IO.write(filename, @all_tasks.map(&:to_s).join("\n"))
	end 

	def read_from_file(filename)
		IO.readlines(filename).each do |line| 
			add(Task.new(line.chomp))
		end
	end

	def set_status(task_index, task_description, status)
	   all_tasks[task_index.to_i] = "[X]: " + task_description if status == "completed"
	end 
end 

class Task 

	attr_reader :description 
	attr_accessor :status

	def initialize(description)
	@description = description 
	end

	def to_s 
		description 
	end 
end 

#program runner 

include Menu 
include Promptable

my_list = List.new 
puts "Please choose from the following list:"
until ["q"].include?(user_input = prompt(show).downcase)
	case user_input 
	when "1" 
		my_list.add(Task.new( prompt("What task would you like to add?") )) 
	when "2"
		puts "List of tasks: #{my_list.display}"
	when "3"
		my_list.update( prompt("Enter new task"), prompt("Enter the task's index.") )
	when "4"
		puts "List of tasks: #{my_list.display}"
		my_list.delete( prompt("Enter the index of the task you would like to delete") )
	when "5" 
		my_list.write_to_file(prompt("Enter a file name."))
	when "6"
		my_list.read_from_file(prompt("Enter a file name."))
	when "7"
		my_list.set_status( prompt("Enter the task's index."), prompt("Enter the task's desciption"), prompt("Enter task's status") )
	else 
		puts "Sorry, I did not understand."
end
end 
 puts "Thanks for using the menu system!" 







