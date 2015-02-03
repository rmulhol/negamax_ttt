Gem::Specification.new do |s|
  s.name          = 'negamax_ttt'
  s.version       = '0.0.1'
  s.description   = 'unbeateable tic tac toe ai engine'
  s.summary       = 'an engine for setting up and running tic tac toe games with an unbeatable ai player'
  s.authors       = 'Rob Mulholand'
  s.homepage      = 'https://github.com/rmulhol/negamax_ttt'
  s.email         = 'robmulholand@gmail.com'
  s.license       = 'MIT'
  s.files         = ['Rakefile', 'README.md']
  s.files         += Dir.glob("lib/**/*")
  s.files         += Dir.glob("test/**/*")
end