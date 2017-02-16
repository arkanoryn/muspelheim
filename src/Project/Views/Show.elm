module Project.Views.Show exposing (view, header)

import Html exposing (Html, div, text, h1, h4, p)
import Html.Attributes
import Project.Models exposing (Project, ProjectId)
import Messages exposing (Msg(..))
import Layout.Header
import Models exposing (Model)
import Html.Attributes exposing (style)


view : Model -> Project -> Html Msg
view model project =
    div []
        [ h1 [] [ Html.text project.title ]
        , h4 [] [ Html.text project.id ]
        , div [ style [ ("overflow-x", "scroll")
                      , ("overflow-y", "hidden")
                      ]
              ]
              [ p
                [ style [ ("width", "3000px") ] ]
                [ Html.text project.description ]
              ]
        , div [] []
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
