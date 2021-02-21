#!/usr/bin/env python

import requests
import json
import os

with open(os.path.join(os.path.dirname(__file__), 'hashrate_creds.json')) as f:
    creds = json.load(f)

r = requests.get('https://pool.api.btc.com/v1/realtime/hashrate', params=creds)
if (r.status_code == requests.codes.ok):
    print(f" {int(r.json()['data']['shares_15m_pure']) / 1e12:.2f} TH/s")
