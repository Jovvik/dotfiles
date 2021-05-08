#!/usr/bin/env python

import pickle
from os import path
from googleapiclient.discovery import build
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request

SCOPES = ['https://www.googleapis.com/auth/spreadsheets.readonly']

SUBJS = [
    {
        "spreadsheet_id": "1WyW_48ZFJFKsRIyG4ngizGZT-5XRcBS9RBkc048OZC4",
        "range": "Весна21!F40",
        "icon": "∫"
    },
    {
        "spreadsheet_id": "1xcLfzpmsu5YKEwZce67SGalgQHqPDFoDUntV5vECPME",
        "range": "36-37!F37",
        "icon": "",
    },
    {
        "spreadsheet_id": "1LqrnjZB_QiUzyaCrl78Vn8S7-ouE0IKasBgY2tEfxL8",
        "range": "F66:G66",
        "action": lambda x: sum(x),
        "icon": "↔"
    },
    {
        "spreadsheet_id": "1TBhrGf9RYvsH3D6r773hrFvx457bBLnxpH9hQ12PJrw",
        "range": "Список!BD94",
        "icon": ""
    },
    {
        "spreadsheet_id": "1HIlXBjbNrMh7ug3gLUuFjHbL82fXJ0iq9Uv0Idhr0Ns",
        "range": "E98",
        "icon": ""
    },
    {
        "spreadsheet_id": "1E9a0zqeG_ASxVfc6vfkGdZNWVskKak41Sb-UqlH90Og",
        "range": "Баллы!F141",
        "action": lambda x: x[0] * 5,
        "icon": "pe"
    },
    {
        "icon": "en",
        "ignore": True
    }
]


def get_value(sheet, attrs):
    if "ignore" in attrs:
        return "?"
    result = sheet.values().get(spreadsheetId=attrs["spreadsheet_id"],
                                range=attrs["range"]).execute().get('values', [])
    result = [float(x.replace(',', '.').replace('%', ''))
              for x in result[0]]
    if "action" in attrs:
        return str(attrs["action"](result))
    return str(result[0])


# Magical pasted code that initializes google spreadsheets
def sheets_prepare():
    creds = None
    if path.exists('/home/jovvik/.config/polybar/token.pickle'):
        with open('/home/jovvik/.config/polybar/token.pickle', 'rb') as token:
            creds = pickle.load(token)
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            # if not path.exists('credentials.json'):
            #     print("Credentials missing, get them from google.")
            #     return
            flow = InstalledAppFlow.from_client_secrets_file(
                'credentials.json', SCOPES)
            creds = flow.run_local_server(port=0)
        with open('token.pickle', 'wb') as token:
            pickle.dump(creds, token)

    return build('sheets', 'v4', credentials=creds).spreadsheets()


def main():
    try:
        sheet = sheets_prepare()
        results = [(subj["icon"], get_value(sheet, subj)) for subj in SUBJS]
        print('  '.join(' '.join((icon, value.rstrip('0').rstrip('.')))
                        for icon, value in results))
    except Exception as e:
        with open("points.log", "a") as log:
            log.write(str(e))


if __name__ == '__main__':
    main()
