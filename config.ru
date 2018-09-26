require './config/environment'

use PlayersController
use StaffController
use TeamController
use SessionsController
use Rack::MethodOverride
run ApplicationController