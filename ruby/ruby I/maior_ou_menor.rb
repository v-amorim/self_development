# frozen_string_literal: true

def boas_vindas
  puts 'Bem vindo ao jogo da adivinhação'
end

def sorteia_numero_secreto
  puts 'Escolhendo um número secreto entre 0 e 200...'
  sorteado = 175
  puts 'Escolhido... que tal adivinhar hoje nosso número secreto?'
  sorteado
end

def pede_um_numero(tentativa, limite_de_tentativas)
  puts "Tentativa #{tentativa + 1} de #{limite_de_tentativas}"
  print 'Entre com o número: '
  gets.to_i
end

def checa_se_acertou(numero_secreto, chute)
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
limite_de_tentativas = 3

limite_de_tentativas.times do |tentativa|
  chute = pede_um_numero(tentativa, limite_de_tentativas)
  break if checa_se_acertou(numero_secreto, chute)
end
