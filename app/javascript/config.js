let config = {};

config.timerLimit = new Date().getTime() + (0.5*60*1000); // Set for 3 minutes
config.baseApi = "http://localhost:3000";

module.exports = config;

