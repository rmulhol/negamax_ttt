Gem::Specification.new do |s|
  s.name          = 'negamax_ttt'
  s.version       = '0.0.0'
  s.description   = 'unbeateable tic tac toe ai engine'
  s.summary       = 'an engine for setting up and running tic tac toe games with an unbeatable ai player'
  s.authors       = 'Rob Mulholand'
  s.homepage      = 'http://rmulhol.github.io'
  s.email         = 'robmulholand@gmail.com'
  s.license       = 'MIT'
  s.files         = ['Rakefile', 'README.md']
  s.files         += Dir.glob("lib/negamax_ttt.rb")
end