// Quadro sul telefono: con internet prende sempre l'ultima versione pubblicata, senza internet usa la copia salvata.
const CACHE = 'quadro-1.7.0';
const FILES = ['./', './index.html', './boot.js', './app.js', './app.css', './sql-wasm.wasm', './manifest.webmanifest', './icona-192.png', './icona-512.png'];
self.addEventListener('install', (e) => { e.waitUntil(caches.open(CACHE).then((c) => c.addAll(FILES)).then(() => self.skipWaiting())); });
self.addEventListener('activate', (e) => { e.waitUntil(self.clients.claim()); });
self.addEventListener('fetch', (e) => {
  const u = new URL(e.request.url);
  if (e.request.method !== 'GET' || u.origin !== location.origin) return;
  e.respondWith(fetch(e.request).then((r) => { if (r.ok) { const copy = r.clone(); caches.open(CACHE).then((c) => c.put(e.request, copy)); } return r; })
    .catch(() => caches.match(e.request, { ignoreSearch: true }).then((r) => r || caches.match('./index.html'))));
});
