# frozen_string_literal: true

puts 'Bem vindo ao jogo da adivinhação'
puts 'Escolhendo um número secreto entre 0 e 200...'
numero_secreto = 42
tentativas = 3

tentativas.times do |tentativa|
  puts "Tentativa #{tentativa + 1} de #{tentativas}"
  puts 'Entre com o número'
  chute = gets.to_i

  if numero_secreto.eql? chute
    puts 'Acertou!'
    break
  elsif numero_secreto > chute
    puts 'O número secreto é maior!'
  else
    puts 'O número secreto é menor!'
  end
end
