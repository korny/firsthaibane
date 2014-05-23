set :stage, :production

server 'fallout-shelter', user: `whoami`.chomp, roles: %w(app web db), :primary => true

set :deploy_to, '/var/www/Kornelius-Kalnbach/firsthaibane.rubychan.de'
