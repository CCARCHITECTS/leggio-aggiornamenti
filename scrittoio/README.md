# Scrittoio – aggiornamenti

Aggiornamenti automatici di **Scrittoio**, il programma di videoscrittura dello studio CC architects.

- `manifest.json` e `manifest.sig`: l'ultima versione pubblicata, firmata con la chiave dello studio (Ed25519).
- `file/`: le pagine e le librerie del programma, una per impronta SHA-256 (mai un programma .exe).

Scrittoio controlla qui all'avvio e ogni 4 ore e installa un aggiornamento solo se la firma è giusta e ogni file corrisponde. La chiave privata non è qui.
