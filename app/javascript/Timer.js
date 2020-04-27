import config from "./config";

export let timer = null;
const initializeTimer = (timeOutLimit, updateTimerCallback, whenDoneCallback) => {

    if(timer) {
        clearInterval(timer); //Clear if timer already has value
        timer = null;
    }

    let futureTime = new Date().getTime() + (timeOutLimit * 60 * 1000);
    timer = setInterval(function() {

        let nowTime = new Date().getTime();
        let difference = futureTime - nowTime;

        // Calculating minutes and seconds
        let minutes = Math.floor((difference % (1000 * 60 * 60)) / (1000 * 60));
        let seconds = Math.floor((difference % (1000 * 60)) / 1000);

        // Output the result in an element with id="demo"
        let counterTime = minutes + " : " + seconds;


        updateTimerCallback(counterTime);
        // doWhen timer limit is reached
        if (difference < 0) {
            clearInterval(timer);
            whenDoneCallback();
        }
    }, 1000); // 1 sec timer
}

export const resetTimer = () => {
    clearInterval(timer);
    timer = null;
}

export {initializeTimer}
