module View exposing (view)

import Html exposing (Html, div, text, span)
import Html.Attributes exposing (style)
import Layout.Drawer as Drawer
import Layout.Header as Header
import Layout.SubMenu as SubMenu
import Material.Color as Color
import Material.Layout as Layout
import Material.Scheme as Scheme
import Messages exposing (Msg(..))
import Models exposing (Model)
import Project.Views.Index
import Project.Views.Show
import Project.Views.New
import Project.Models exposing (ProjectId)
import Routing exposing (Route(..))
import Layout.Header as MyHeader


view : Model -> Html Msg
view model =
    Scheme.topWithScheme Color.Blue Color.LightBlue <|
        Layout.render Mdl
            model.mdl
            [ Layout.fixedHeader
            , Layout.fixedDrawer
            ]
            { header = determineHeader model
            , drawer = (Drawer.view model)
            , tabs = (SubMenu.view model)
            , main =
                [ div
                    [ style [ ( "padding", "1rem" ) ] ]
                    [ pageContent model ]
                ]
            }


determineHeader : Model -> List (Html Msg)
determineHeader model =
    case model.route of
        ProjectShow id ->
            Project.Views.Show.header model id

        ProjectNew ->
            Project.Views.New.header model

        ProjectIndex ->
            Project.Views.Index.header model

        _ ->
            MyHeader.defaultHeader "Header undefined!!"


pageContent : Model -> Html Msg
pageContent model =
    case model.route of
        Home ->
            div [] [ text "Home" ]

        ProjectIndex ->
            Project.Views.Index.view model

        ProjectShow id ->
            projectShowPage model id

        ProjectNew ->
            Project.Views.New.view model

        NotFound ->
            notFoundView


projectShowPage : Model -> ProjectId -> Html Msg
projectShowPage model projectId =
    let
        maybeProject =
            model.projectModel.projects
                |> List.filter (\project -> project.id == projectId)
                |> List.head
    in
        case maybeProject of
            Just project ->
                Project.Views.Show.view project

            Nothing ->
                notFoundView


notFoundView : Html msg
notFoundView =
    div [] [ text "404 - Not found!" ]
