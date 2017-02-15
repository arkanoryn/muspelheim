module Layout.Header exposing (defaultHeader, defaultHeaderWithNavigation)

import Html exposing (Html, text, span)
import Material.Layout as Layout
import Messages exposing (Msg)


defaultHeader : String -> List (Html Msg)
defaultHeader headerText =
    [ Layout.row
        []
        [ Layout.title [] [ text headerText ]
        ]
    ]


defaultHeaderWithNavigation : String -> List (Html Msg) -> List (Html Msg)
defaultHeaderWithNavigation headerText navigation =
    [ Layout.row
        []
        [ Layout.title [] [ text headerText ]
        , Layout.spacer
        , Layout.navigation []
            navigation
        ]
    ]
