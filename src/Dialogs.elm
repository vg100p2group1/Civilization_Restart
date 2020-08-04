module Dialogs exposing (initdialog)

import Model exposing (Sentence,sentenceInit,Side(..))

initdialog : List Sentence
initdialog =  
    [
        {sentenceInit | text = "Warning! Warning! Invader detected!", side = Left}
    , {sentenceInit | text = "What a giant mechanic monster!", side = Right}
    , {sentenceInit | text = "Is this robot that controls all the robots in this floor?", side = Right}
    , {sentenceInit | text = "Please step back, invader, You are approaching the core secret of Flying Mechanics Monetarism", side = Left}
    , {sentenceInit | text = "If you step foward anymore, you will be annihilated", side = Left}
    , {sentenceInit | text = "What do you mean by Flying Mechanics Monetarism?", side = Right}
    , {sentenceInit | text = "You robots can believe in religions?", side = Right}
    , {sentenceInit | text = "Please turn back in 5 seconds, 5... 4... 3...", side = Left}
    , {sentenceInit | text = "It seems that it can't understand me. The only way to pass is to fight!", side = Right}
    , {sentenceInit | text = "2...1... Invader doesn't react, executing attacking program", side = Left}
    ]

dialog2 : List Sentence
dialog2 = 
    [
        {sentenceInit | text = "An invader! It has been ten years since the last invader come to this floor", side = Left}
    , {sentenceInit | text = "Oh! A robot that have enough intellegent to talk to", side = Right}
    , {sentenceInit | text = "What do you mean by ten years? Our commander didnn't send any soldier to fight with robot before me.", side = Right}
    , {sentenceInit | text = "A.... human? Really? ", side = Left}
    , {sentenceInit | text = "If you step foward anymore, you will be annihilated", side = Left}
    , {sentenceInit | text = "What do you mean by Flying Mechanics Monetarism?", side = Right}
    , {sentenceInit | text = "You robots can believe in religions?", side = Right}
    , {sentenceInit | text = "Please turn back in 5 seconds, 5... 4... 3...", side = Left}
    , {sentenceInit | text = "It seems that it can't understand me. The only way to pass is to fight!", side = Right}
    , {sentenceInit | text = "2...1... Invader doesn't react, executing attacking program", side = Left}
    ]