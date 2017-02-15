module Routing exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (..)
import Project.Models exposing (ProjectId)


type Route
    = Home
    | ProjectIndex
    | ProjectShow ProjectId
    | ProjectNew
    | NotFound


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map Home top
        , map ProjectNew (s "projects" </> s "new")
        , map ProjectShow (s "projects" </> string)
        , map ProjectIndex (s "projects")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFound


pageToUrl : Route -> String
pageToUrl route =
    let
        url =
            case route of
                Home ->
                    ""

                ProjectIndex ->
                    "projects"

                ProjectShow id ->
                    "projects/" ++ id

                ProjectNew ->
                    "projects/new"

                NotFound ->
                    "oops... not found"
    in
        "#" ++ url
