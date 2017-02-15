module Project.Messages exposing (..)

import Project.Models exposing (ProjectId)


type Msg
    = Raise ProjectId
    | ChangeTitle String
    | ChangeDescription String
    | CreateProject
