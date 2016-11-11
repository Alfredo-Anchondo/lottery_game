function onInstall() {
  console.log('[Serviceworker]', "Installing!");
}

function onActivate() {
  console.log('[Serviceworker]', "Activating!");
}

function onFetch() {
}

self.addEventListener('install', onInstall);
self.addEventListener('activate', onActivate);
self.addEventListener('fetch', onFetch);


function onPush(event) {
  var title = (event.data && event.data.text()) || "Yay a message" ;

  event.waitUntil(
    self.registration.showNotification(title, {
      body: "We have received a push message",
      icon: "/assets/nombre.png",
      tag:  "push-simple-demo-notification-tag",
    });
  )
}

self.addEventListener("push", onPush);
