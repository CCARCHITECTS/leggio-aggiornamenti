# Tavolozza Studio – aggiornamenti

Aggiornamenti automatici di **Tavolozza Studio**, l'editor di immagini dello studio CC architects.

- `manifest.json` e `manifest.sig`: l'ultima versione pubblicata, firmata con la chiave di Tavolozza (Ed25519).
- `file/`: la pagina del programma (Tavolozza.html), con il nome uguale alla sua impronta SHA-256 (mai un programma .exe).

Tavolozza controlla qui all'avvio e ogni 4 ore, scarica la versione nuova, verifica firma e impronta e chiede conferma prima di usarla. La chiave privata non è qui.
