module Project.Update exposing (update)

import Navigation
import Project.Messages exposing (Msg(..))
import Project.Models exposing (Project, initProject)
import Routing exposing (Route(..))


update : Msg -> Project.Models.Model -> ( Project.Models.Model, Cmd Msg )
update msg projectModel =
    case msg of
        Raise k ->
            { projectModel | raised = k } ! []

        ChangeTitle str ->
            { projectModel | projectForm = (changeTitle projectModel str) } ! []

        ChangeDescription str ->
            { projectModel | projectForm = (changeDescription projectModel str) } ! []

        CreateProject ->
            { projectModel
                | projects = addNewProject projectModel
                , projectForm = initProject
            }
                ! [ Navigation.newUrl (Routing.pageToUrl ProjectIndex) ]


changeTitle : Project.Models.Model -> String -> Project
changeTitle projectModel newTitle =
    let
        project =
            projectModel.projectForm
    in
        { project | title = newTitle }


changeDescription : Project.Models.Model -> String -> Project
changeDescription projectModel newDescription =
    let
        project =
            projectModel.projectForm
    in
        { project | description = newDescription }


addNewProject : Project.Models.Model -> List Project
addNewProject projectModel =
    let
        newProject =
            projectModel.projectForm

        newId =
            (List.length projectModel.projects) + 1 |> toString
    in
        projectModel.projects ++ [ { newProject | id = newId } ]
