import mysql.connector
from mysql.connector import Error

def mostra_piante(classe:str = None, ordine:str = None, famiglia:str = None, sotto_famiglia:str = None, genere:str = None, specie:str = None):
    args = [classe, ordine, famiglia, sotto_famiglia, genere, specie]
    for element in args:
        if item is not None:
            if not isinstance(item, str):
                print('input non valido')
                return
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
        try:
#se non riceve nessun inpunt mostra tutte le immagini di tutte le piante
            risultati = mostra_piante()
            if risultati is not None:
                for risultato in risultati:
                    print(risultato)
        except Error as e:
            print(e)
