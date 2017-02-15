module Project.Views.New exposing (view, header)

import Html exposing (Html, div, text)
import Layout.Header
import Material
import Material.Button as Button
import Material.Grid exposing (grid, size, cell, Device(..))
import Material.Options exposing (Style, onClick, onInput)
import Material.Textfield as Textfield
import Messages exposing (Msg(..))
import Models exposing (Model)
import Project.Messages
import Project.Models
import Routing exposing (Route(..))


view : Model -> Html Msg
view model =
    grid []
        [ cell cellOptions [ (titleField model model.projectModel) ]
        , cell cellOptions [ (descriptionField model model.projectModel) ]
        , cell cellOptions [ submitButton model model.projectModel ]
        ]


titleField : Model -> Project.Models.Model -> Html Msg
titleField model projectModel =
    Textfield.render Mdl
        [ 0, 0, 0 ]
        model.mdl
        [ Textfield.label "title"
        , Textfield.floatingLabel
        , Textfield.text_
        , Textfield.value projectModel.projectForm.title
        , onInput (ProjectMsg << Project.Messages.ChangeTitle)
        ]
        []


descriptionField : Model -> Project.Models.Model -> Html Msg
descriptionField model projectModel =
    Textfield.render Mdl
        [ 0, 0, 1 ]
        model.mdl
        [ Textfield.label "description"
        , Textfield.floatingLabel
        , Textfield.textarea
        , Textfield.rows 6
        , Textfield.value projectModel.projectForm.description
        , onInput (ProjectMsg << Project.Messages.ChangeDescription)
        ]
        []


submitButton : Model -> Project.Models.Model -> Html Msg
submitButton model projectModel =
    Button.render Mdl
        [ 0, 0, 2 ]
        model.mdl
        [ Button.raised
        , Button.ripple
        , Button.colored
        , onClick (ProjectMsg Project.Messages.CreateProject)
        ]
        [ text "Submit" ]


header : Model -> List (Html Msg)
header model =
    Layout.Header.defaultHeader "New project"


cellOptions : List (Style a)
cellOptions =
    [ size All 12 ]
