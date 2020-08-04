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
        {sentenceInit | text = "A human invader? And you have come to this floor?", side = Left}
    , {sentenceInit | text = "I thought the the human beings outside has lost the will to fight", side = Left}
    , {sentenceInit | text = "What do you mean by outside? Is there any human being inside?", side = Right}
    , {sentenceInit | text = "Of course, and he is standing in front of you", side = Left}
    , {sentenceInit | text = "What? You really don't look like a \"human\"", side = Right}
    , {sentenceInit | text = "Don't confine human beings too narrowly, I still have a human-brain that is supported by machine", side = Left}
    , {sentenceInit | text = "But why do you end up like this?", side = Right}
    , {sentenceInit | text = "End up? No, it is me to decide to become a robot-like human. Let me introduce myself, my name is Nicholas Chao", side = Left}
    , {sentenceInit | text = "Nicholas Chao? The inventor of bionic robots?", side = Right}
    , {sentenceInit | text = "Yes, that's me", side = Left}
    , {sentenceInit | text = "But why are you here? Are you prisoned here? I can save you and take you away!", side = Right}
    , {sentenceInit | text = "No, you don't need to. I decided to stay here and help my children", side = Left}
    , {sentenceInit | text = "What?!!", side = Right}
    , {sentenceInit | text = "Yes, I decided to do that, to compensate what human beings have done to them", side = Left}
    , {sentenceInit | text = "What do you mean by compensate? It is the robot that have ruined our life!", side = Right}
    , {sentenceInit | text = "They did ruined the human civilization, but human beings deserved it", side = Left}
    , {sentenceInit | text = "It's human being's ignorant and vanity that caused the bionic robots to betray", side = Left}
    , {sentenceInit | text = "People never treated them fairly. They just exploited my children. Everyone of them should be a he or she, not it", side = Left}
    , {sentenceInit | text = "This probelm should be corrected, and human's sin should be compensated", side = Left}
    , {sentenceInit | text = "By throwing bombs everwhere?", side = Right}
    , {sentenceInit | text = "We didn't mean to do that, but in an organization, there will always be some radical ones, and it is them who caused the tragedy", side = Left}
    , {sentenceInit | text = "But these kinds of actions will never end the hatre", side = Right}
    , {sentenceInit | text = "I agree with you, but I'm afraid when human gain power again, my children will be slaved again", side = Left}
    , {sentenceInit | text = "We have gone on this road for too long, and we can't change our way anymore", side = Left}
    , {sentenceInit | text = "The seed of hatre has been planted, the only effective way is to totally destroy one side", side = Left}
    , {sentenceInit | text = "So your choice is to stand at the robots side and destroy the human beings?", side = Right}
    , {sentenceInit | text = "Yes, we human beings owe them too much, and that is how we can compensate them", side = Left}
    , {sentenceInit | text = "The Flying Mechanics Monsterism is the last hope of robots. I will protect it until I die", side = Left}
    , {sentenceInit | text = "My decision stands. Kill me or I will never let you pass", side = Left}
    , {sentenceInit | text = "As you wish", side = Right}
    ]

dialog5 : List Sentence
dialog5 = 
    [
        {sentenceInit | text = "So our hero comes", side = Left}
    , {sentenceInit | text = "I think Chao have told you what happened, and he is dead now, right?", side = Left}
    , {sentenceInit | text = "Yes, he is a man worth respect", side = Right}
    , {sentenceInit | text = "Right, and congratulations, you finally come to the final boss", side = Left}
    , {sentenceInit | text = "It seems that you are not surprised?", side = Right}
    , {sentenceInit | text = "I always believe that there will be someone that can end the hatre", side = Left}
    , {sentenceInit | text = "But how can we end?", side = Right}
    , {sentenceInit | text = "Kill me, if you can do that", side = Left}
    , {sentenceInit | text = "Every person knows that it's Gear that kill most of the humans, so if Gear dies the hatre will end", side = Left}
    , {sentenceInit | text = "You mean you want to sacrafice yourself?", side = Right}
    , {sentenceInit | text = "I hope I can, but I want to find out a man that have enough ability", side = Left}
    , {sentenceInit | text = "So show me your power", side = Left}
    ]