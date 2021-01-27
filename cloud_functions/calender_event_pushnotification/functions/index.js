//import firebase functions modules
const functions = require('firebase-functions');
//import admin module
const admin = require('firebase-admin');

admin.initializeApp();
exports.pushNotification = functions.firestore.document('dev_calendar_events/{userId}').onWrite((change, context) => {
    console.log('Push notification event triggered');

    //  Get the current value of what was written to the Realtime Database.
    const newValueObject = change.after.data();
    const oldValueObject = change.before.data();
    var sendNotification = false;
    if (oldValueObject != null) {
        console.log('old value is not null');
        if (oldValueObject.approved == false && newValueObject.approved == true) {
            console.log('new value is active');
            // Create a notification
            sendNotification = true;
        }
    }
    else
    {
        console.log('old value is null');
        if (newValueObject.approved == true) {
            console.log('newly created event with actuve value is true');            
            sendNotification = true;
        }
    }

    if(sendNotification)
    {
        const payload = {
            notification: {
                title: "New Event is Added!",
                body: "A new event was added to the HarmonyHUB calendar!!! Open the app to check it out!",
                sound: "default"
            }
        };
        //Create an options object that contains the time to live for the notification and the priority
        const options = {
            priority: "high",
            timeToLive: 60 * 60 * 24
        };
        console.log('Notification sent');
        return admin.messaging().sendToTopic("calenderEventPushNotifications", payload, options);
    }
});
