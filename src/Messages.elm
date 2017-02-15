module Messages exposing (..)

import Material
import Navigation exposing (Location)
import Routing exposing (Route)
import Project.Messages exposing (Msg(..))


type Msg
    = Mdl (Material.Msg Msg)
    | NewLocation Location
    | NavigateTo (Maybe Route)
    | ProjectMsg Project.Messages.Msg
