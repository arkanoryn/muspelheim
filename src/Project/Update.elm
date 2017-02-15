module Project.Update exposing (update)

import Project.Messages exposing (Msg(..))
import Project.Models

update : Msg -> Project.Models.Model -> (Project.Models.Model, Cmd Msg)
update msg projectModel =
    case msg of
        Raise k ->
            {projectModel | raised = k } ! []
