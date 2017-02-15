module Models exposing (..)

import Material
import Routing
import Project.Models


type alias Model =
    { mdl :          Material.Model
    , debug_mode :   Bool
    , route :        Routing.Route
    , projectModel : Project.Models.Model
    }


initialModel : Routing.Route -> Model
initialModel route =
    { mdl          = Material.model
    , debug_mode   = False
    , route        = route
    , projectModel = Project.Models.initModel
    }
