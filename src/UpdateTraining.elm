module UpdateTraining exposing (updateTraining)
import Model exposing (Model,TrainingSession,State(..))

updateTraining : Model -> Model

updateTraining model =
    let
        training = model.trainingSession
        me = model.myself
    in
        if training.step == 1 && training.hasMovedLeft then
            {model|trainingSession={training|step=2}}
        else if training.step == 2 && training.hasMovedUp then
            {model|trainingSession={training|step=3}}
        else if training.step == 3 && training.hasFired then
            {model|trainingSession={training|step=4}}
        else if training.step == 4 && training.hasB then
            {model|trainingSession={training|step=5}}
        else if training.step == 5 && training.hasR then
            {model|trainingSession={training|step=6}}
        else if training.step == 6 && training.hasG then
            {model|trainingSession={training|step=7}}
        else
            model



