module Project.Views.Show exposing (view, header)

import Html exposing (Html, div, text, h1, h4, p)
import Project.Models exposing (Project, ProjectId)
import Messages exposing (Msg(..))
import Layout.Header
import Models exposing (Model)


view : Project -> Html Msg
view project =
    div []
        [ h1 [] [ text project.title ]
        , h4 [] [ text project.id ]
        , div []
            [ p [] [ text project.description ]
            ]
        ]


header : Model -> ProjectId -> List (Html Msg)
header model id =
    Layout.Header.defaultHeader (projectTitle model id)


projectTitle : Model -> ProjectId -> String
projectTitle model id =
    let
        maybeProject =
            model.projectModel.projects
                |> List.filter (\project -> project.id == id)
                |> List.head
    in
        case maybeProject of
            Just project ->
                project.title

            Nothing ->
                "Unknown project"
