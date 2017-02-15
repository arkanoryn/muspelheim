module Update exposing (..)

import Material
import Models exposing (Model)
import Messages exposing (Msg(..))
import Navigation exposing (..)
import Routing exposing (parseLocation, pageToUrl)
import Project.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Mdl msg_ ->
            Material.update Mdl msg_ model

        NewLocation location ->
            let
                newRoute =
                    parseLocation location
            in
                ({ model | route = newRoute } ! [])

        NavigateTo maybePage ->
            case maybePage of
                Nothing ->
                    model ! []

                Just page ->
                    model ! [ Navigation.newUrl (Routing.pageToUrl page) ]

        ProjectMsg projectMsg ->
            let
                ( projectModel, cmd ) =
                    Project.Update.update projectMsg model.projectModel
            in
                ( { model | projectModel = projectModel }, Cmd.map ProjectMsg cmd )
