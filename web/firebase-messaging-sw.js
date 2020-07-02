importScripts("https://www.gstatic.com/firebasejs/7.5.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.5.0/firebase-messaging.js");

firebase.initializeApp({
    apiKey: "AIzaSyA12VXabcVyyfO8pNAZHUoZHZ1Lg2zB7QY",
    authDomain: "clanz-c3899.firebaseapp.com",
    databaseURL: "https://clanz-c3899.firebaseio.com",
    projectId: "clanz-c3899",
    storageBucket: "clanz-c3899.appspot.com",
    messagingSenderId: "488864453699",
    appId: "1:488864453699:web:0530a4c2ecc39915ebb0f6",
    measurementId: "G-K5GHM72G48"
});
const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            return registration.showNotification("New Message");
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});