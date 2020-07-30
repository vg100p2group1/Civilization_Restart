module Display.Define exposing(defines)
import Svg 
import Messages exposing (Msg)
import Svg.Attributes 

defines : Svg.Svg Msg
defines =
    let
      g1 = Svg.g[Svg.Attributes.id "Wall2"][
          Svg.image 
            [ Svg.Attributes.xlinkHref "./images/Environment/Wall2.png"
            , Svg.Attributes.preserveAspectRatio "none meet"
            , Svg.Attributes.width <| String.fromFloat 50
            , Svg.Attributes.height <| String.fromFloat 50
            -- , Svg.Attributes.fill "black"
            ][]
        ]
      g2 = Svg.g[Svg.Attributes.id "Wall1"][
          Svg.image 
            [ Svg.Attributes.xlinkHref "./images/Environment/Wall1.png"
            , Svg.Attributes.preserveAspectRatio "none meet"
            , Svg.Attributes.width <| String.fromFloat 100
            , Svg.Attributes.height <| String.fromFloat 50
            -- , Svg.Attributes.fill "black"
            ][]
        ]
      g3 = Svg.g[Svg.Attributes.id "Ex1"][
          Svg.image 
            [ Svg.Attributes.xlinkHref "./images/Explosion/Ex_01.png"
            , Svg.Attributes.preserveAspectRatio "none meet"
            , Svg.Attributes.width <| String.fromFloat 20
            , Svg.Attributes.height <| String.fromFloat 20
            -- , Svg.Attributes.fill "black"
            ][]]
      g4 = Svg.g[Svg.Attributes.id "Ex2"][
          Svg.image 
            [ Svg.Attributes.xlinkHref "./images/Explosion/Ex_02.png"
            , Svg.Attributes.preserveAspectRatio "none meet"
            , Svg.Attributes.width <| String.fromFloat 20
            , Svg.Attributes.height <| String.fromFloat 20
            -- , Svg.Attributes.fill "black"
            ][]]
        
      g5 = Svg.g[Svg.Attributes.id "Bullet1_R"][
          Svg.image 
            [ Svg.Attributes.xlinkHref "./images/Gun/Bullet1_R.png"
            , Svg.Attributes.preserveAspectRatio "none meet"
            , Svg.Attributes.width <| String.fromFloat 20
            , Svg.Attributes.height <| String.fromFloat 20
            -- , Svg.Attributes.fill "black"
            ][]]
      g6 = Svg.g[Svg.Attributes.id "Bullet1"][
          Svg.image 
            [ Svg.Attributes.xlinkHref "./images/Gun/Bullet1.png"
            , Svg.Attributes.preserveAspectRatio "none meet"
            , Svg.Attributes.width <| String.fromFloat 20
            , Svg.Attributes.height <| String.fromFloat 20
            -- , Svg.Attributes.fill "black"
            ][]]  
      g7 = Svg.g[Svg.Attributes.id "Bullet2_R"][
          Svg.image 
            [ Svg.Attributes.xlinkHref "./images/Gun/Bullet2_R.png"
            , Svg.Attributes.preserveAspectRatio "none meet"
            , Svg.Attributes.width <| String.fromFloat 40
            , Svg.Attributes.height <| String.fromFloat 40
            -- , Svg.Attributes.fill "black"
            ][]]  
      g8 = Svg.g[Svg.Attributes.id "Bullet2"][
          Svg.image 
            [ Svg.Attributes.xlinkHref "./images/Gun/Bullet2.png"
            , Svg.Attributes.preserveAspectRatio "none meet"
            , Svg.Attributes.width <| String.fromFloat 40
            , Svg.Attributes.height <| String.fromFloat 40
            -- , Svg.Attributes.fill "black"
            ][]]  
    in
        Svg.defs []([g1,g2,g3,g4,g5,g6,g7,g8]++definePlayer++defineWeapon++defineMonsters)


definePlayer : List (Svg.Svg Msg)
definePlayer =
    let
        g1 = Svg.g[Svg.Attributes.id "R_1"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/R_1.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 40
                , Svg.Attributes.height <| String.fromFloat 40
                -- , Svg.Attributes.fill "black"
                ][]
            ]
        g2 = Svg.g[Svg.Attributes.id "R_2"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/R_2.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 40
                , Svg.Attributes.height <| String.fromFloat 40
                -- , Svg.Attributes.fill "black"
                ][]
            ]
        g3 = Svg.g[Svg.Attributes.id "R_3"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/R_3.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 40
                , Svg.Attributes.height <| String.fromFloat 40
                -- , Svg.Attributes.fill "black"
                ][]
            ]
        g4 = Svg.g[Svg.Attributes.id "L_1"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/L_1.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 40
                , Svg.Attributes.height <| String.fromFloat 40
                -- , Svg.Attributes.fill "black"
                ][]
            ]
        g5 = Svg.g[Svg.Attributes.id "L_2"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/L_2.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 40
                , Svg.Attributes.height <| String.fromFloat 40
                -- , Svg.Attributes.fill "black"
                ][]
            ]
        g6 = Svg.g[Svg.Attributes.id "L_3"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/L_3.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 40
                , Svg.Attributes.height <| String.fromFloat 40
                -- , Svg.Attributes.fill "black"
                ][]
            ]
    in
        [g1,g2,g3,g4,g5,g6]
    

defineWeapon : List (Svg.Svg Msg)
defineWeapon =
    let
        g1 = Svg.g[Svg.Attributes.id "Gun_1_R"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Gun/Gun_1_R.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 20
                , Svg.Attributes.height <| String.fromFloat 20
                -- , Svg.Attributes.fill "black"
                ][]
            ]
        g2 = Svg.g[Svg.Attributes.id "Gun_1_L"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Gun/Gun_1_L.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 20
                , Svg.Attributes.height <| String.fromFloat 20
                -- , Svg.Attributes.fill "black"
                ][]
            ]
        
        g3 = Svg.g[Svg.Attributes.id "Gun_2_R"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Gun/Gun_2_R.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 30
                , Svg.Attributes.height <| String.fromFloat 16
                -- , Svg.Attributes.fill "black"
                ][]
            ]
        
        g4 = Svg.g[Svg.Attributes.id "Gun_2_L"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Gun/Gun_2_L.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 30
                , Svg.Attributes.height <| String.fromFloat 16
                -- , Svg.Attributes.fill "black"
                ][]
            ]
        
        g5 = Svg.g[Svg.Attributes.id "Gun_3_R"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Gun/Gun_3_R.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 40
                , Svg.Attributes.height <| String.fromFloat 40
                -- , Svg.Attributes.fill "black"
                ][]
            ]
        
        g6 = Svg.g[Svg.Attributes.id "Gun_3_L"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Gun/Gun_3_L.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 40
                , Svg.Attributes.height <| String.fromFloat 40
                -- , Svg.Attributes.fill "black"
                ][]
            ]

        g7 = Svg.g[Svg.Attributes.id "Gun_4_R"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Gun/Gun_4_R.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 40
                , Svg.Attributes.height <| String.fromFloat 20
                -- , Svg.Attributes.fill "black"
                ][]
            ]

        g8 = Svg.g[Svg.Attributes.id "Gun_4_L"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Gun/Gun_4_L.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 40
                , Svg.Attributes.height <| String.fromFloat 20
                -- , Svg.Attributes.fill "black"
                ][]
            ]
    in
        [g1,g2,g3,g4,g5,g6,g7,g8]

defineMonsters : List (Svg.Svg Msg)
defineMonsters =
    let
        g1 = Svg.g[Svg.Attributes.id "Robot1"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Robot/R1.gif"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 40
                , Svg.Attributes.height <| String.fromFloat 40
                -- , Svg.Attributes.fill "black"
                ][]
            ]
        g2 = Svg.g[Svg.Attributes.id "Robot2"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Robot/R2.gif"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 40
                , Svg.Attributes.height <| String.fromFloat 40
                -- , Svg.Attributes.fill "black"
                ][]
            ]
        g3 = Svg.g[Svg.Attributes.id "Robot3"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Robot/R4.gif"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 40
                , Svg.Attributes.height <| String.fromFloat 40
                -- , Svg.Attributes.fill "black"
                ][]
            ]
        g4 = Svg.g[Svg.Attributes.id "Robot4"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Robot/R5.gif"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 40
                , Svg.Attributes.height <| String.fromFloat 40
                -- , Svg.Attributes.fill "black"
                ][]
            ]
        g1L = Svg.g[Svg.Attributes.id "Robot1L"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Robot/R1L.gif"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 40
                , Svg.Attributes.height <| String.fromFloat 40
                -- , Svg.Attributes.transform "scale(-1,1)"
                ][]
            ]
        g2L = Svg.g[Svg.Attributes.id "Robot2L"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Robot/R2L.gif"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 40
                , Svg.Attributes.height <| String.fromFloat 40
                -- , Svg.Attributes.transform "scale(-1,1)"
                ][]
            ]
        g3L = Svg.g[Svg.Attributes.id "Robot3L"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Robot/R4L.gif"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 40
                , Svg.Attributes.height <| String.fromFloat 40
                -- , Svg.Attributes.transform "scale(-1,1)"
                ][]
            ]

    in
        [g1,g2,g3,g4,g1L,g2L,g3L]