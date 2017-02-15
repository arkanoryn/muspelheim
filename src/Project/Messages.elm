module Project.Messages exposing (..)

import Project.Models exposing (ProjectId, Project)


type Msg
    = Raise ProjectId
    | ChangeTitle String
    | ChangeDescription String
    | CreateProject
    | UpdateTitle Project String
    | UpdateDescription Project String
    | DeleteProject Project
