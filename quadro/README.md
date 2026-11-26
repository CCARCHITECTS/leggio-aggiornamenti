# Quadro – aggiornamenti

Aggiornamenti automatici di **Quadro**, il foglio di calcolo dello studio CC architects.

- `manifest.json` e `manifest.sig`: l'ultima versione pubblicata, firmata con la chiave di Quadro (Ed25519).
- `pacchetti/`: le pagine e il codice del programma di ogni versione (mai un programma .exe).

Quadro controlla questo repository all'avvio e ogni 4 ore, scarica la versione nuova e chiede prima di installarla.
La installa solo se la firma è giusta e ogni file corrisponde. La chiave privata non è qui.
