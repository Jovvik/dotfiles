#!/usr/bin/python

import pickle
import os.path
from googleapiclient.discovery import build
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request

SCOPES = ['https://www.googleapis.com/auth/spreadsheets.readonly']

SPREADSHEET_ID = '1GdlMd27JDscttvn7y8CNsYK5hSpU7GwebbD6khpE4os'
RANGE = 'Лист1!B2:I3'

def main():
    creds = None
    if os.path.exists('/home/jovvik/.config/polybar/token.pickle'):
        with open('/home/jovvik/.config/polybar/token.pickle', 'rb') as token:
            creds = pickle.load(token)
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(
                'credentials.json', SCOPES)
            creds = flow.run_local_server(port=0)
        with open('token.pickle', 'wb') as token:
            pickle.dump(creds, token)

    service = build('sheets', 'v4', credentials=creds)
    sheet = service.spreadsheets()
    result = sheet.values().get(spreadsheetId=SPREADSHEET_ID, range=RANGE).execute()
    values, icons = result.get('values', [])

    if not values:
        print('!')
    else:
        print('  '.join(f'{icon} {value}' for value, icon in zip(values, icons)))

if __name__ == '__main__':
    try:
        main()
    except Exception as e:
        print(e)