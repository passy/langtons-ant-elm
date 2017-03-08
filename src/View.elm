module View exposing (root)

import Dict
import Html exposing (Html)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Types exposing (..)


root : Model -> Html Msg
root model =
    svg
        [ width "100vw"
        , height "100vh"
        , viewBox "-100 -100 200 200"
        ]
        [ worldView model.world
        , antView model.ant
        ]


tileSize : Int
tileSize =
    10


worldView : World -> Svg msg
worldView world =
    g []
        (Dict.toList world
            |> List.map (uncurry tileView)
        )


toColorCode : Color -> String
toColorCode color =
    case color of
        Black ->
            "black"

        White ->
            "white"


tileView : Position -> Color -> Svg msg
tileView position color =
    rect
        [ x <| toString <| Tuple.first position * tileSize
        , y <| toString <| Tuple.second position * tileSize
        , width <| toString tileSize
        , height <| toString tileSize
        , fill (toColorCode color)
        ]
        []


tupleProp : String -> Float -> Float -> String
tupleProp name a b =
    name ++ "(" ++ (toString a) ++ ", " ++ (toString b) ++ ")"

antView : Ant -> Svg msg
antView ant =
    let
        radius =
            toFloat tileSize / 2
        scaleFactor = 0.2486746987951807
        scale = tupleProp "scale" scaleFactor scaleFactor
        xpos = (\x -> (1 / scaleFactor) * x) <| toFloat ( Tuple.first ant.position * tileSize ) + radius
        ypos = (\x -> (1 / scaleFactor) * x) <| toFloat ( Tuple.second ant.position * tileSize ) + radius
        translate = tupleProp "translate" xpos ypos
    in
        Svg.path
            [ transform (String.join " " [scale, translate])
            , fill "red"
            , d "M62.387,60.396c1.021,1.247,2.776-0.53,1.766-1.766c-3.195-3.903-7.119-5.757-11.365-3.646    c-0.913-1.498-2.243-2.708-3.833-3.475c1.773-1.221,2.948-3.239,3.021-5.536c5.212-0.561,9.439-3.013,12.266-7.651    c0.84-1.379-1.32-2.633-2.156-1.26c-2.419,3.97-6.005,6.011-10.478,6.435c-0.64-1.871-2.045-3.387-3.849-4.162    c3.142-1.132,5.393-4.13,5.393-7.66c0-1.426-0.368-2.765-1.011-3.93c0.97-0.64,1.699-1.824,2.137-2.8    c1.048-2.33,0.998-5.101-0.963-6.924c-1.178-1.095-2.947,0.667-1.766,1.766c1.063,0.989,1.065,2.232,0.684,3.554    c-0.183,0.636-0.524,1.209-0.897,1.748c-0.211,0.305-0.827,0.576-0.539,0.644c-0.093-0.022-0.183-0.033-0.269-0.036    c-1.453-1.344-3.391-2.172-5.526-2.172s-4.073,0.828-5.526,2.172c-0.086,0.003-0.176,0.014-0.269,0.036    c0.281-0.066-0.132-0.2-0.371-0.449c-0.426-0.44-0.731-1.053-0.954-1.617c-0.539-1.362-0.552-2.834,0.572-3.879    c1.182-1.099-0.588-2.86-1.766-1.766c-1.883,1.751-1.993,4.341-1.089,6.626c0.421,1.063,1.203,2.404,2.263,3.098    c-0.643,1.165-1.011,2.504-1.011,3.93c0,3.53,2.251,6.528,5.393,7.66c-1.804,0.775-3.209,2.291-3.849,4.162    c-4.472-0.424-8.058-2.465-10.477-6.435c-0.836-1.373-2.996-0.119-2.156,1.26c2.826,4.639,7.053,7.091,12.265,7.651    c0.072,2.297,1.247,4.315,3.021,5.536c-1.589,0.767-2.919,1.978-3.833,3.475c-4.245-2.111-8.169-0.258-11.364,3.646    c-1.011,1.235,0.745,3.013,1.766,1.766c1.52-1.856,3.362-3.892,5.928-3.998c0.96-0.04,1.86,0.334,2.688,0.825    c-0.228,0.796-0.356,1.634-0.356,2.503c0,1.171,0.229,2.287,0.631,3.315c-4.398,0.87-7.639,3.178-9.744,7.387    c-0.718,1.436,1.436,2.7,2.156,1.26c1.956-3.909,4.758-5.7,8.884-6.366c1.67,2.146,4.27,3.531,7.199,3.531    s5.529-1.386,7.199-3.532c4.127,0.667,6.929,2.457,8.885,6.367c0.721,1.44,2.874,0.176,2.156-1.26    c-2.105-4.21-5.346-6.517-9.745-7.387c0.402-1.028,0.631-2.145,0.631-3.315c0-0.863-0.128-1.694-0.352-2.485    c0.705-0.41,1.449-0.737,2.28-0.829C58.733,56.118,60.869,58.543,62.387,60.396z" ]
            []
