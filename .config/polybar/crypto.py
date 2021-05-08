#!/usr/bin/env python

import configparser
import sys
import requests
from os import path
from decimal import Decimal

config = configparser.ConfigParser()

# File must be opened with utf-8 explicitly
with open(path.join(path.dirname(__file__), "crypto-config.ini"), 'r', encoding='utf-8') as f:
    config.read_file(f)

# Everything except the general section
currencies = [x for x in config.sections() if x != 'general']
base_currency = config['general']['base_currency']
params = {'convert': base_currency}


for currency in currencies:
    icon = config[currency]['icon']
    json = requests.get(f'https://api.coingecko.com/api/v3/coins/{currency}',
                        ).json()["market_data"]
    local_price = Decimal(json["current_price"]
                          [f'{base_currency.lower()}']) / 1000
    change_24 = round(float(json['price_change_percentage_24h']), 1)

    display_opt = config['general']['display']
    if display_opt == 'both' or display_opt == None:
        sys.stdout.write(f'{icon} {local_price:.1f}k$/{change_24:+}%')
    elif display_opt == 'percentage':
        sys.stdout.write(f'{icon} {change_24:+}%')
    elif display_opt == 'price':
        sys.stdout.write(f'{icon} {local_price:.1f}k$')
