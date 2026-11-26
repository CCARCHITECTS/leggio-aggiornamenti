# Impagina – aggiornamenti

Aggiornamenti automatici di **Impagina**, il programma di impaginazione dello studio CC architects.

- `manifest.json` e `manifest.sig`: l'ultima versione pubblicata, firmata con la chiave dello studio (Ed25519).
- `pacchetti/`: le pagine e il codice dell'app di ogni versione (mai un programma .exe).

Impagina controlla questa cartella all'avvio e installa un aggiornamento solo se la firma è giusta e ogni file corrisponde. La chiave privata non è qui.
