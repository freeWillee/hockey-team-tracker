require './config/environment'

use PlayersController
use TeamController
use SessionsController
use UsersController
use Rack::MethodOverride

run ApplicationController