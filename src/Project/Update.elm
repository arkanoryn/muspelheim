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
            { projectModel | projectForm = (changeTitle projectModel.projectForm str) } ! []

        ChangeDescription str ->
            { projectModel | projectForm = (changeDescription projectModel.projectForm str) } ! []

        CreateProject ->
            { projectModel
                | projects = addNewProject projectModel
                , projectForm = initProject
            }
                ! [ Navigation.newUrl (Routing.pageToUrl ProjectIndex) ]

        UpdateTitle project str ->
            let
                updateTitle existingProject =
                    if existingProject.id == project.id then
                        changeTitle project str
                    else
                        existingProject
            in
                { projectModel | projects = (List.map updateTitle projectModel.projects) } ! []

        UpdateDescription project str ->
            let
                updateDescription existingProject =
                    if existingProject.id == project.id then
                        changeDescription project str
                    else
                        existingProject
            in
                { projectModel | projects = (List.map updateDescription projectModel.projects) } ! []

        UpdateProject ->
            projectModel ! [ Navigation.newUrl (Routing.pageToUrl ProjectIndex) ]

        DeleteProject project ->
            let
                removeProject existingProject =
                    if existingProject == project then
                        []
                    else
                        [ existingProject ]
            in
                { projectModel | projects = List.concat (List.map removeProject projectModel.projects) } ! []


changeTitle : Project -> String -> Project
changeTitle project newTitle =
    { project | title = newTitle }


changeDescription : Project -> String -> Project
changeDescription project newDescription =
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
