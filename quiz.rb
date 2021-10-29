# TO DO:
# This is the file that you will run in your terminal with: ruby quiz.rb
require 'json'

filepath = 'data/halloween.json'

questions_file = File.read(filepath)

@questions = JSON.parse(questions_file)
@lives_count = 3
@score = 0

def compare_answer(question, user_answer)
  user_answer == question["correct_answer_key"]
end

def ask_question(question)
  puts "Question: #{question["question"]}"
  puts "Possible Answers:"
  question["possible_answers"].each do |letter, answer|
    puts "#{letter} -> #{answer}"
  end
  user_answer = gets.chomp.upcase
  result = compare_answer(question,user_answer)
  print `clear`
  if result
    @score += 10
    puts "You may proceed, mortal. You have #{@lives_count} lives left"
    puts "Your score is #{@score}"
    puts ""
  else
    @lives_count -= 1
    puts " "
    puts "🩸 Wrong answer, mortal! 🧛🏻‍♂️"
    puts "You have #{@lives_count} lives left"
    puts " "
    if @lives_count > 0
      ask_question(question)
    else
      puts "Your are out of lives, mortal!"
    end
  end
end

# Don't forget, if you are storing your questions in a json or csv file, you will need to
#                                                  parse that file first to get the data!

puts '-----------------------------------------------'
puts '---      !Welcome to the Wagon Pub-Quiz!    ---'
puts "-   This quiz's theme is: ~🦇 Halloween 🦇~  -"
puts '-----------------------------------------------'


23.times do
  print '🎃 '
  sleep(0.1)
end
puts ''

puts "You have: #{@lives_count} lives."
puts 'Every time you get a question wrong, you loose a life.'
@questions.each do |question|
  ask_question(question)
  break if @lives_count <= 0
end

puts "You made it out alive with #{@lives_count} lives left" if @lives_count > 0
puts "You will be with me forever 🧛🏻‍♂️" if @lives_count <= 0
puts "Your final score was #{@score}"
