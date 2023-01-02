# frozen_string_literal: true

def boas_vindas
  puts 'Bem vindo ao jogo da adivinhação'
end

def escolhe_dificuldade
  puts 'Qual o nível de dificuldade?'
  puts '(1) Fácil (2) Médio (3) Difícil'
  print 'Escolha: '
  gets.to_i
end

def numero_maximo(dificuldade)
  case dificuldade
  when 1
    30
  when 2
    60
  when 3
    100
  else
    puts 'Dificuldade inválida'
  end
end

def sorteia_numero_secreto(dificuldade)
  puts "Escolhendo um número secreto entre 1 e #{numero_maximo(dificuldade)}..."
  sorteado = rand(1..numero_maximo(dificuldade))
  puts 'Escolhido... que tal adivinhar hoje nosso número secreto?'
  sorteado
end

def pede_um_numero(chutes, tentativa, limite_de_tentativas)
  puts "Tentativa #{tentativa + 1} de #{limite_de_tentativas}"
  puts "Chutes anteriores: #{chutes.sort}" if tentativa.positive?
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

def quer_jogar?
  puts 'Deseja jogar novamente? (S/N)'
  gets.strip.upcase.eql? 'S'
end

def jogar(dificuldade)
  numero_secreto = sorteia_numero_secreto(dificuldade)
  pontos = 1000
  limite_de_tentativas = 10
  chutes = []

  limite_de_tentativas.times do |tentativa|
    chutes << pede_um_numero(chutes, tentativa, limite_de_tentativas)
    pontos -= (chutes.last - numero_secreto).abs / 2.0
    break if acertou?(numero_secreto, chutes.last)
  end

  puts "Você obteve #{pontos} pontos."
  puts "O número secreto era #{numero_secreto}" unless numero_secreto.eql? chutes.last
end

boas_vindas
dificuldade = escolhe_dificuldade

loop do
  jogar(dificuldade)
  break unless quer_jogar?
end
