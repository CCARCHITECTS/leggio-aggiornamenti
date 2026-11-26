# Leggio PDF – aggiornamenti

Aggiornamenti automatici di **Leggio PDF**, il lettore ed editor di PDF dello studio CC architects.

- `manifest.json` e `manifest.sig`: l'ultima versione pubblicata, firmata con la chiave dello studio (Ed25519).
- `pacchetti/`: le pagine e il codice dell'app di ogni versione (mai un programma .exe).

Leggio controlla questo repository all'avvio e ogni 4 ore e installa un aggiornamento solo se la firma è giusta
e ogni file corrisponde. La chiave privata non è qui.
