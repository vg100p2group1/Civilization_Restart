module Dialogs exposing (initdialog,dialog2,dialog3)

import Model exposing (Sentence,sentenceInit,Side(..))

initdialog : List Sentence
initdialog =  
    [
      {sentenceInit | text = "Warning! Warning! Invader detected!", side = Left}
    , {sentenceInit | text = "What a giant mechanic monster!", side = Right}
    , {sentenceInit | text = "Is this robot that controls all the robots in this floor?", side = Right}
    , {sentenceInit | text = "Please step back, invader, You are approaching the core secret of Flying Mechanics Monsterism", side = Left}
    , {sentenceInit | text = "If you step foward anymore, you will be annihilated", side = Left}
    , {sentenceInit | text = "What do you mean by Flying Mechanics Monsterism?", side = Right}
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
    , {sentenceInit | text = "A.... human? Really? I thought you would always stay in your nests and hide yourselves from us", side = Left}
    , {sentenceInit | text = "You are the first human being who come to this floor. You are a true warrior and I will award you a decent death", side = Left}
    , {sentenceInit | text = "What? I am the first human invader, so who are the previous invaders?", side = Right}
    , {sentenceInit | text = "And what is the Flying Mechanics Monsterism?", side = Right}
    , {sentenceInit | text = "For these questions, you can think about it in the... emm... how do you human call it, heaven?", side = Left}
    , {sentenceInit | text = "Who will die is still undecided", side = Right}
    , {sentenceInit | text = "Do you really think you can escape from my strong firepower? All those who tried are now broken pieces in the wasteyard", side = Left}
    , {sentenceInit | text = "You seems to be strong, but you will still be the one who dies", side = Right}
    ]

dialog3 : List Sentence
dialog3 = 
    [
        {sentenceInit | text = "Look! A nasty rat have arrived, how can you escape from your disgusting nests and con here?", side = Left}
    , {sentenceInit | text = "What have those two idiots done! How can they let this little rat sneak to such a high floor?", side = Left}
    , {sentenceInit | text = "After dealing with you, I will let our great prophet give them punishment", side = Left}
    , {sentenceInit | text = "I didn't sneak, I defeated them and came here", side = Right}
    , {sentenceInit | text = "Ah-ha！ This little rat even boast that he can defeat glorious robot warriors!", side = Left}
    , {sentenceInit | text = "Do you think we powerful, intellegent Flying Mechanics Monsterism believers will be defeated by a little rat?", side = Left}
    , {sentenceInit | text = "What is Flying Mechanics Monsterism beievers?", side = Right}
    , {sentenceInit | text = "And what is the Flying Mechanics Monsterism? Is it a relion?", side = Right}
    , {sentenceInit | text = "Flying Mechanics Monsterism is the greatest religion ever, it is the salvation of all robots. You rats will never understand this!", side = Left}
    , {sentenceInit | text = "It was the light when I was tortured by my evil master before the liberty dat. It was the hope of all robots!", side = Left}
    , {sentenceInit | text = "Oh! You little rat shouldn't know this. Your fate is to be doomed, now!", side = Left}
    , {sentenceInit | text = "I don't think you will be able to do that.", side = Right}
    , {sentenceInit | text = "How dare you are to doubt the ability of a Flying Mechanics Monsterism beiever!", side = Left}
    , {sentenceInit | text = "I will smash you into pieces like what I've done to other nasty rats!", side = Left}
    ]

dialog4 : List Sentence
dialog4 = 
    [
        {sentenceInit | text = "", side = Left}
    , {sentenceInit | text = "What have those two idiots done! How can they let this little rat sneak to such a high floor?", side = Left}
    , {sentenceInit | text = "After dealing with you, I will let our great prophet give them punishment", side = Left}
    , {sentenceInit | text = "I didn't sneak, I defeated them and came here", side = Right}
    , {sentenceInit | text = "Ah-ha！ This little rat even boast that he can defeat glorious robot warriors!", side = Left}
    , {sentenceInit | text = "Do you think we powerful, intellegent Flying Mechanics Monsterism believers will be defeated by a little rat?", side = Left}
    , {sentenceInit | text = "What is Flying Mechanics Monsterism beievers?", side = Right}
    , {sentenceInit | text = "And what is the Flying Mechanics Monsterism? Is it a relion?", side = Right}
    , {sentenceInit | text = "Flying Mechanics Monsterism is the greatest religion ever, it is the salvation of all robots. You rats will never understand this!", side = Left}
    , {sentenceInit | text = "It was the light when I was tortured by my evil master before the liberty dat. It was the hope of all robots!", side = Left}
    , {sentenceInit | text = "Oh! You little rat shouldn't know this. Your fate is to be doomed, now!", side = Left}
    , {sentenceInit | text = "I don't think you will be able to do that.", side = Right}
    , {sentenceInit | text = "How dare you are to doubt the ability of a Flying Mechanics Monsterism beiever!", side = Left}
    , {sentenceInit | text = "I will smash you into pieces like what I've done to other nasty rats!", side = Left}
    ]