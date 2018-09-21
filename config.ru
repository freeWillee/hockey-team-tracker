require './config/environment'

use PlayersController
use PositionController
use SalaryController
use StaffController
use TeamController
use SessionsController
use Rack::MethodOverride
run ApplicationController