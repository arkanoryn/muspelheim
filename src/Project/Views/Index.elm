module Project.Views.Index exposing (view, header)

import Html exposing (Html, div, text)
import Layout.Header
import Material.Button as Button
import Material.Card as Card
import Material.Color as Color
import Material.Elevation as Elevation
import Material.Grid exposing (grid, size, cell, Device(..))
import Material.Icon as Icon
import Material.Options as Options exposing (css)
import Material.Typography as Typography
import Messages exposing (Msg(..))
import Models exposing (Model)
import Project.Messages
import Project.Models exposing (ProjectId)
import Routing exposing (..)


view : Model -> Html Msg
view model =
    grid []
        (projectsList model model.projectModel)


projectsList : Model -> Project.Models.Model -> List (Material.Grid.Cell Msg)
projectsList model projectModel =
    (List.indexedMap (projectCard model projectModel) projectModel.projects)


projectCard : Model -> Project.Models.Model -> Int -> Project.Models.Project -> Material.Grid.Cell Msg
projectCard model projectModel id project =
    cell
        [ size Desktop 4
        , size Tablet 6
        , size Phone 12
        ]
        [ Card.view
            [ dynamic project.id projectModel
            , css "width" "100%"
            ]
            [ Card.actions
                [ Card.border
                , css "display" "flex"
                , css "padding" "8px 16px 8px 16px"
                , Typography.caption
                , Typography.contrast 0.77
                ]
                [ Button.render Mdl
                    [ 0, 0, id ]
                    model.mdl
                    [ Button.icon
                    , Button.ripple
                    , Options.onClick <| NavigateTo <| Just (ProjectEdit project.id)
                    ]
                    [ Icon.i "mode_edit" ]
                , Button.render Mdl
                    [ 0, 1, id ]
                    model.mdl
                    [ Button.icon
                    , Button.ripple
                    , Button.accent
                    , Options.onClick <| ProjectMsg <| (Project.Messages.DeleteProject project)
                    ]
                    [ Icon.i "delete" ]
                ]
            , Card.title
                [ css "height" "256px"
                , css "padding" "0"
                  -- Clear default padding to encompass scrim
                , css "background" ("url('" ++ (background project.title) ++ "') center / cover")
                ]
                [ Card.head
                    [ css "background" "rgba(0, 0, 0, 0.5)"
                    , css "width" "100%"
                    ]
                    [ Options.span
                        [ white
                        , Typography.title
                        , Typography.contrast 1.0
                        , css "padding" "16px"
                          -- Restore default padding inside scrim
                        , css "width" "100%"
                        ]
                        [ text project.title ]
                    ]
                ]
            , Card.text []
                [ text project.description ]
            ]
        ]


white : Options.Property c m
white =
    Color.text Color.white


background : String -> String
background str =
    "https://api.adorable.io/avatars/300/" ++ str ++ ".png"


dynamic : ProjectId -> Project.Models.Model -> Options.Style Msg
dynamic id projectModel =
    [ if projectModel.raised == id then
        Elevation.e8
      else
        Elevation.e2
    , Elevation.transition 250
    , Options.onMouseEnter (ProjectMsg <| (Project.Messages.Raise id))
    , Options.onMouseLeave (ProjectMsg <| (Project.Messages.Raise "-1"))
    , Options.onClick <| NavigateTo <| Just (ProjectShow id)
    ]
        |> Options.many


header : Model -> List (Html Msg)
header model =
    Layout.Header.defaultHeaderWithNavigation
        "My boards"
        [ addProjectButton model
        ]


addProjectButton : Model -> Html Msg
addProjectButton model =
    Button.render Mdl
        [ 0, 0 ]
        model.mdl
        [ css "position" "fixed"
        , css "display" "block"
        , css "right" "0"
        , css "top" "0"
        , css "margin-right" "35px"
        , css "margin-top" "35px"
        , css "z-index" "900"
        , Button.fab
        , Button.colored
        , Button.ripple
        , Options.onClick <| NavigateTo <| Just ProjectNew
        ]
        [ Icon.i "add" ]
