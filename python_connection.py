import mysql.connector
from mysql.connector import Error

def mostra_piante(classe = None, ordine = None, famiglia = None, sotto_famiglia = None, genere = None, specie = None):
    args = [classe, ordine, famiglia, sotto_famiglia, genere, specie]
    cursor = None
    conn = None
    try:
        # Stabilire la connessione al database
        conn = mysql.connector.connect(
            user='utente1',
            password='SecureP4ssword!',
            database='floraitaliana',
            host='localhost'
        )

        cursor = conn.cursor()
        
        cursor.callproc('MOSTRA_IMMAGINI_e_descrizione', args)
        results = []
        for result in cursor.stored_results():
            results.append(result.fetchall())
        return results

    except Error as e:
        print(e)
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

if __name__ == '__main__':
    risultati = mostra_piante()
    for risultato in risultati:
        print(risultato)
