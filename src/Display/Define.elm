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
            , Svg.Attributes.width <| String.fromFloat 40
            , Svg.Attributes.height <| String.fromFloat 40
            -- , Svg.Attributes.fill "black"
            ][]]
      g4 = Svg.g[Svg.Attributes.id "Ex2"][
          Svg.image 
            [ Svg.Attributes.xlinkHref "./images/Explosion/Ex_02.png"
            , Svg.Attributes.preserveAspectRatio "none meet"
            , Svg.Attributes.width <| String.fromFloat 40
            , Svg.Attributes.height <| String.fromFloat 40
            -- , Svg.Attributes.fill "black"
            ][]]
        
      g5 = Svg.g[Svg.Attributes.id "Bullet1_R"][
          Svg.image 
            [ Svg.Attributes.xlinkHref "./images/Gun/Bullet1_R.png"
            , Svg.Attributes.preserveAspectRatio "none meet"
            , Svg.Attributes.width <| String.fromFloat 40
            , Svg.Attributes.height <| String.fromFloat 40
            -- , Svg.Attributes.fill "black"
            ][]]
      g6 = Svg.g[Svg.Attributes.id "Bullet1"][
          Svg.image 
            [ Svg.Attributes.xlinkHref "./images/Gun/Bullet1.png"
            , Svg.Attributes.preserveAspectRatio "none meet"
            , Svg.Attributes.width <| String.fromFloat 40
            , Svg.Attributes.height <| String.fromFloat 40
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
      g9 = Svg.g[Svg.Attributes.id "Floor1"][
          Svg.image 
            [ Svg.Attributes.xlinkHref "./images/Floor/Floor1.png"
            , Svg.Attributes.preserveAspectRatio "none meet"
            , Svg.Attributes.width <| String.fromFloat 1600
            , Svg.Attributes.height <| String.fromFloat 1600
            -- , Svg.Attributes.fill "black"
            ][]]   
      g10 = Svg.g[Svg.Attributes.id "Treasure1"][
          Svg.image 
            [ Svg.Attributes.xlinkHref "./images/Treasure/Treasure1.png"
            , Svg.Attributes.preserveAspectRatio "none meet"
            , Svg.Attributes.width <| String.fromFloat 100
            , Svg.Attributes.height <| String.fromFloat 100
            -- , Svg.Attributes.fill "black"
            ][]] 
      g11 = Svg.g[Svg.Attributes.id "Floor"][
          Svg.image 
            [ Svg.Attributes.xlinkHref "./images/Floor/2.png"
            , Svg.Attributes.preserveAspectRatio "none meet"
            , Svg.Attributes.width <| String.fromFloat 50
            , Svg.Attributes.height <| String.fromFloat 50
            -- , Svg.Attributes.fill "black"
            ][]]
      g12 = Svg.g[Svg.Attributes.id "Laser1"][
          Svg.image 
            [ Svg.Attributes.xlinkHref "./images/Door/Laser1.png"
            , Svg.Attributes.preserveAspectRatio "none meet"
            , Svg.Attributes.width <| String.fromFloat 50
            , Svg.Attributes.height <| String.fromFloat 200
            -- , Svg.Attributes.fill "black"
            ][]] 
      g13 = Svg.g[Svg.Attributes.id "Laser2"][
          Svg.image 
            [ Svg.Attributes.xlinkHref "./images/Door/Laser2.png"
            , Svg.Attributes.preserveAspectRatio "none meet"
            , Svg.Attributes.width <| String.fromFloat 200
            , Svg.Attributes.height <| String.fromFloat 50
            -- , Svg.Attributes.fill "black"
            ][]]
      g14 = Svg.g[Svg.Attributes.id "Road1"][
          Svg.image 
            [ Svg.Attributes.xlinkHref "./images/Road/Road1.png"
            , Svg.Attributes.preserveAspectRatio "none meet"
            , Svg.Attributes.width <| String.fromFloat 900
            , Svg.Attributes.height <| String.fromFloat 600
            -- , Svg.Attributes.fill "black"
            ][]] 
      g15 = Svg.g[Svg.Attributes.id "Road2"][
          Svg.image 
            [ Svg.Attributes.xlinkHref "./images/Road/Road2.png"
            , Svg.Attributes.preserveAspectRatio "none meet"
            , Svg.Attributes.width <| String.fromFloat 600
            , Svg.Attributes.height <| String.fromFloat 900
            -- , Svg.Attributes.fill "black"
            ][]] 
      g16 = Svg.g[Svg.Attributes.id "Hole"][
          Svg.image 
            [ Svg.Attributes.xlinkHref "./images/Blackhole/Hole.gif"
            , Svg.Attributes.preserveAspectRatio "none meet"
            , Svg.Attributes.width <| String.fromFloat 1000
            , Svg.Attributes.height <| String.fromFloat 1000
            -- , Svg.Attributes.fill "black"
            ][]]
      g17 = Svg.g[Svg.Attributes.id "Light"][
          Svg.image 
            [ Svg.Attributes.xlinkHref "./images/Floor/Light.png"
            , Svg.Attributes.preserveAspectRatio "none meet"
            , Svg.Attributes.width <| String.fromFloat 2000
            , Svg.Attributes.height <| String.fromFloat 2000
            -- , Svg.Attributes.fill "black"
            ][]] 
    in
        Svg.defs []([g1,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13,g14,g15,g16,g17]++definePlayer++defineWeapon++defineMonsters++defineGate++defineObstacle)


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
        b1 = Svg.g[Svg.Attributes.id "Boss1"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Boss/Boss1.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 200
                , Svg.Attributes.height <| String.fromFloat 200
                -- , Svg.Attributes.transform "scale(-1,1)"
                ][]
            ]
        b2 = Svg.g[Svg.Attributes.id "Boss2"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Boss/Boss2.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 200
                , Svg.Attributes.height <| String.fromFloat 200
                -- , Svg.Attributes.transform "scale(-1,1)"
                ][]
            ]
        b3 = Svg.g[Svg.Attributes.id "Boss3"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Boss/Boss3.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 200
                , Svg.Attributes.height <| String.fromFloat 200
                -- , Svg.Attributes.transform "scale(-1,1)"
                ][]
            ]
        

    in
        [g1,g2,g3,g4,g1L,g2L,g3L,b1,b2,b3]

defineGate : List (Svg.Svg Msg)
defineGate =
    let
        g0 = Svg.g[Svg.Attributes.id "Gate0"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Gate/Gate_0.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 200
                , Svg.Attributes.height <| String.fromFloat 200
                -- , Svg.Attributes.fill "black"
                ][]
            ]
        g1 = Svg.g[Svg.Attributes.id "Gate1"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Gate/Gate_1.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 200
                , Svg.Attributes.height <| String.fromFloat 200
                -- , Svg.Attributes.fill "black"
                ][]
            ]
        g2 = Svg.g[Svg.Attributes.id "Gate2"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Gate/Gate_2.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 200
                , Svg.Attributes.height <| String.fromFloat 200
                -- , Svg.Attributes.fill "black"
                ][]
            ]
        g3 = Svg.g[Svg.Attributes.id "Gate3"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Gate/Gate_3.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 200
                , Svg.Attributes.height <| String.fromFloat 200
                -- , Svg.Attributes.fill "black"
                ][]
            ]
        g4 = Svg.g[Svg.Attributes.id "Gate4"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Gate/Gate_4.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 200
                , Svg.Attributes.height <| String.fromFloat 200
                -- , Svg.Attributes.fill "black"
                ][]
            ]
        g5 = Svg.g[Svg.Attributes.id "Gate5"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Gate/Gate_5.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 200
                , Svg.Attributes.height <| String.fromFloat 200
                -- , Svg.Attributes.fill "black"
                ][]
            ]
        g6 = Svg.g[Svg.Attributes.id "Gate6"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Gate/Gate_6.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 200
                , Svg.Attributes.height <| String.fromFloat 200
                -- , Svg.Attributes.fill "black"
                ][]
            ]
        g7 = Svg.g[Svg.Attributes.id "Gate7"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Gate/Gate_7.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 200
                , Svg.Attributes.height <| String.fromFloat 200
                -- , Svg.Attributes.fill "black"
                ][]
            ]
        g8 = Svg.g[Svg.Attributes.id "Gate8"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Gate/Gate_8.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 200
                , Svg.Attributes.height <| String.fromFloat 200
                -- , Svg.Attributes.fill "black"
                ][]
            ]
        g9 = Svg.g[Svg.Attributes.id "Gate9"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Gate/Gate_9.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 200
                , Svg.Attributes.height <| String.fromFloat 200
                -- , Svg.Attributes.fill "black"
                ][]
            ]
        g10 = Svg.g[Svg.Attributes.id "Gate10"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Gate/Gate_10.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 200
                , Svg.Attributes.height <| String.fromFloat 200
                -- , Svg.Attributes.fill "black"
                ][]
            ]
        g11 = Svg.g[Svg.Attributes.id "Gate11"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Gate/Gate_11.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 200
                , Svg.Attributes.height <| String.fromFloat 200
                -- , Svg.Attributes.fill "black"
                ][]
            ]
        g12 = Svg.g[Svg.Attributes.id "Gate12"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Gate/Gate_12.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 200
                , Svg.Attributes.height <| String.fromFloat 200
                -- , Svg.Attributes.fill "black"
                ][]
            ]
        g13 = Svg.g[Svg.Attributes.id "Gate13"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Gate/Gate_13.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 200
                , Svg.Attributes.height <| String.fromFloat 200
                -- , Svg.Attributes.fill "black"
                ][]
            ]
        g14 = Svg.g[Svg.Attributes.id "Gate14"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Gate/Gate_14.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 200
                , Svg.Attributes.height <| String.fromFloat 200
                -- , Svg.Attributes.fill "black"
                ][]
            ]
    in 
        [g0,g1,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13,g14]

defineObstacle : List (Svg.Svg Msg)
defineObstacle =
    let
        g0 = Svg.g[Svg.Attributes.id "Obstacle1"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Obstacle/Obstacle1.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 100
                , Svg.Attributes.height <| String.fromFloat 1200
                -- , Svg.Attributes.fill "black"
                ][]
            ]
        g1 = Svg.g[Svg.Attributes.id "Obstacle2"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Obstacle/Obstacle2.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 400
                , Svg.Attributes.height <| String.fromFloat 200
                -- , Svg.Attributes.fill "black"
                ][]
            ]
        g2 = Svg.g[Svg.Attributes.id "Obstacle3"][
            Svg.image 
                [ Svg.Attributes.xlinkHref "./images/Obstacle/Obstacle3.png"
                , Svg.Attributes.preserveAspectRatio "none meet"
                , Svg.Attributes.width <| String.fromFloat 800
                , Svg.Attributes.height <| String.fromFloat 800
                -- , Svg.Attributes.fill "black"
                ][]
            ]
    in 
        [g0,g1,g2]
