#!/usr/bin/python

import pickle
from os import path
from googleapiclient.discovery import build
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request

SCOPES = ['https://www.googleapis.com/auth/spreadsheets.readonly']

SPREADSHEET_ID = '1GdlMd27JDscttvn7y8CNsYK5hSpU7GwebbD6khpE4os'
RANGE = 'Лист1!B2:I3'

SUBJS = [
    {
        "SPREADSHEET_ID": "1WyW_48ZFJFKsRIyG4ngizGZT-5XRcBS9RBkc048OZC4",
        "RANGE": "Осень20!D48",
        "ICON": "∫"
    },
    {
        "SPREADSHEET_ID": "1XTorcnLrDwSc_Uq6WmjEvR6ncS8b-sG52rtAiKUcSRc",
        "RANGE": "36-37!F45",
        "ICON": ""
    },
    {
        "SPREADSHEET_ID": "1AwMIB9hiiAB-0m6JSPdeTwYUga_nfynFcWWiD8lfAg8",
        "RANGE": "F69:G69",
        "ACTION": lambda x: sum(x),
        "ICON": "↔"
    },
    {
        "SPREADSHEET_ID": "1B52D85mRRVqPN5yymM0RyaxXLvgiy1xNeFfW-5OVdIM",
        "RANGE": "B118",
        "ICON": "dx"
    },
    {
        "SPREADSHEET_ID": "1tlYlcoCE_yxRskQHu91t27V3S-vnsLkRUi9WAf1bAvs",
        "RANGE": "BARS!D11:S11",
        "ACTION": lambda x: sum(x),
        "ICON": "en"
    },
    {
        "SPREADSHEET_ID": "1xqnBXsoVrEV4NHiOo4JGlCZfgoy8yVPF8CIuzWM-w68",
        "RANGE": "D120",
        "ICON": "os"
    },
    {
        "SPREADSHEET_ID": "1sBKYN5MJ5NyPRYsGaSUNRsxcAwsUJyZ-UxD4nbSnqGY",
        "RANGE": "Баллы!F58",
        "ACTION": lambda x: x[0] * 5,
        "ICON": "pe"
    }
]


def get_value(sheet, attrs):
    result = sheet.values().get(spreadsheetId=attrs["SPREADSHEET_ID"],
                                range=attrs["RANGE"]).execute().get('values', [])
    result = [float(x.replace(',', '.')) for x in result[0]]
    if "ACTION" in attrs:
        return attrs["ACTION"](result)
    return result[0]


# Magical code that initializes google spreadsheets
def sheets_prepare():
    creds = None
    if path.exists('/home/jovvik/.config/polybar/token.pickle'):
        with open('/home/jovvik/.config/polybar/token.pickle', 'rb') as token:
            creds = pickle.load(token)
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            if not path.exists('credentials.json'):
                print("Credentials missing, get them from google.")
                return
            flow = InstalledAppFlow.from_client_secrets_file(
                'credentials.json', SCOPES)
            creds = flow.run_local_server(port=0)
        with open('token.pickle', 'wb') as token:
            pickle.dump(creds, token)

    return build('sheets', 'v4', credentials=creds).spreadsheets()


def main():
    try:
        sheet = sheets_prepare()
        results = [(subj["ICON"], get_value(sheet, subj)) for subj in SUBJS]
        print('  '.join(' '.join((icon, str(value).rstrip('0').rstrip('.')))
                        for icon, value in results))
    except Exception as e:
        with open("points.log", "a") as log:
            log.write(str(e))


if __name__ == '__main__':
    main()
