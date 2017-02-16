module Project.Views.Edit exposing (view, header)

import Html exposing (Html, div, text)
import Layout.Header
import Material
import Material.Button as Button
import Material.Grid exposing (grid, size, cell, offset, Device(..))
import Material.Options exposing (Style, onClick, onInput, css)
import Material.Textfield as Textfield
import Messages exposing (Msg(..))
import Models exposing (Model)
import Project.Messages
import Project.Models exposing (ProjectId, Project)
import Routing exposing (Route(..))


view : Model -> Project -> Html Msg
view model project =
    grid []
        [ cell cellOptions [ (titleField model project) ]
        , cell cellOptions [ (descriptionField model project) ]
        , cell
            [ offset Desktop 4
            , offset Tablet 2
            , size All 2
            ]
            [ submitButton model project ]
        , cell [ size All 2 ] [ cancelButton model project ]
        ]


titleField : Model -> Project -> Html Msg
titleField model project =
    Textfield.render Mdl
        [ 0, 0, 0 ]
        model.mdl
        [ Textfield.label "title"
        , Textfield.floatingLabel
        , Textfield.text_
        , Textfield.value project.title
        , css "width" "100%"
        , onInput (ProjectMsg << Project.Messages.UpdateTitle project)
        ]
        []


descriptionField : Model -> Project -> Html Msg
descriptionField model project =
    Textfield.render Mdl
        [ 0, 0, 1 ]
        model.mdl
        [ Textfield.label "description"
        , Textfield.floatingLabel
        , Textfield.textarea
        , Textfield.rows 6
        , Textfield.value project.description
        , css "width" "100%"
        , onInput (ProjectMsg << Project.Messages.UpdateDescription project)
        ]
        []


submitButton : Model -> Project -> Html Msg
submitButton model projectModel =
    Button.render Mdl
        [ 0, 0, 2 ]
        model.mdl
        [ Button.raised
        , Button.ripple
        , Button.colored
        , css "width" "100%"
        , onClick (ProjectMsg Project.Messages.UpdateProject)
        ]
        [ text "Submit" ]


cancelButton : Model -> Project -> Html Msg
cancelButton model project =
    Button.render Mdl
        [ 0, 0, 3 ]
        model.mdl
        [ Button.raised
        , Button.ripple
        , css "width" "100%"
        , onClick <| NavigateTo <| Just (ProjectShow project.id)
        ]
        [ text "cancel" ]


header : Model -> List (Html Msg)
header model =
    Layout.Header.defaultHeader "Edit project"


cellOptions : List (Style a)
cellOptions =
    [ size All 12 ]
