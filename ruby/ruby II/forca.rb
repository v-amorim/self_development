# frozen_string_literal: true

def boas_vindas
  puts 'Bem vindo ao jogo da forca!'
end

def escolhe_palavra_secreta
  puts 'Escolhendo uma palavra secreta...'
  palavra_secreta = 'programador'
  puts "Escolhida uma palavra com #{palavra_secreta.size} letras... Boa sorte!"
  palavra_secreta
end

def quer_jogar?
  puts 'Deseja jogar novamente? (S/N)'
  gets.strip.upcase.eql? 'S'
end

def mensagem(pontos, palavra_secreta)
  puts "Você obteve #{pontos} pontos."
  # puts "O número secreto era #{palavra_secreta}" unless palavra_secreta.eql? chutes.last
end

def pede_um_chute(erros, chutes)
  puts 'Entre com uma letra ou uma palavra'
  chute = gets.strip.downcase
  chute
end

def acertou?(palavra_secreta, chutes, pontos)
  letra? = chute.size == 1
  if letra?
  else
    if palavra_secreta.eql? chute
      puts 'Parabéns! Acertou!'
      pontos += 100
      true
    else
      puts 'Que pena... errou!'
      pontos -= 30
      false
    end
  end
end

def jogar(palavra_secreta)
  tentativas = 5
  chutes = []
  pontos = 0

  tentativas.times do
    chutes << pede_um_chute(erros, chutes)
    puts "Já chutou #{chutes}"
    break if acertou?(palavra_secreta, chutes, pontos)
  end

  mensagem(pontos, palavra_secreta)
end

boas_vindas
palavra_secreta = escolhe_palavra_secreta

loop do
  jogar(palavra_secreta)
  break unless quer_jogar?
end
