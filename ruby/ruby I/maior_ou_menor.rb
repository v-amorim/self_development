# frozen_string_literal: true

def boas_vindas
  puts 'Bem vindo ao jogo da adivinhação'
end

def sorteia_numero_secreto
  puts 'Escolhendo um número secreto entre 0 e 200...'
  sorteado = rand(0..200)
  puts 'Escolhido... que tal adivinhar hoje nosso número secreto?'
  sorteado
end

def pede_um_numero(chutes, tentativa, limite_de_tentativas)
  puts "Tentativa #{tentativa + 1} de #{limite_de_tentativas}"
  puts "Chutes anteriores: #{chutes}" if tentativa.positive?
  print 'Entre com o número: '
  gets.to_i
end

def acertou?(numero_secreto, chute)
  if numero_secreto.eql? chute
    puts 'Acertou!'
    return true
  elsif numero_secreto > chute
    puts 'O número secreto é maior!'
  else
    puts 'O número secreto é menor!'
  end
  false
end

boas_vindas
numero_secreto = sorteia_numero_secreto
pontos = 1000
limite_de_tentativas = 10
chutes = []

limite_de_tentativas.times do |tentativa|
  chutes << pede_um_numero(chutes, tentativa, limite_de_tentativas)
  pontos -= (chutes.last - numero_secreto).abs / 2.0
  break if acertou?(numero_secreto, chutes.last)
end

puts "Você obteve #{pontos} pontos."
puts "O número secreto era #{numero_secreto}" unless acertou?(numero_secreto, chutes.last)
