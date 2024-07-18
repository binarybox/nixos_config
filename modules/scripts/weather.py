#!/usr/bin/env python

import subprocess
# from pyquery import PyQuery  # install using `pip install pyquery`
import requests
import json

weather_icons_night = {
    # Sunny
    "113": "",
    # Partly Cloudy
    "116": "",
    # Cloudy
    "119": "摒",
    # Very Cloudy
    "122": "",
    # Fog
    "143": "",
    "248": "",
    "260": "",
    # Light Showers
    "176": "",
    "263": "",
    # Light Sleet Showers
    "179": "",
    "362": "",
    "365": "",
    "374": "",
    # Light Sleet
    "182": "",
    "185": "",
    "281": "",
    "284": "",
    "311": "",
    "314": "",
    "317": "",
    "350": "",
    "377": "",
    # Thundery Showers
    "200": "",
    # Light Snow
    "227": "",
    "320": "",
    # Heavy Snow
    "230": "",
    # Light rain
    "266": "",
    "293": "",
    "296": "",
    # Heavy Showers
    "299": "",
    "305": "",
    "356": "",
    # Heavy Rain
    "302": "",
    "308": "",
    "359": "",
    # Light Snow Showers
    "323": "ﭽ",
    "326": "ﭽ",
    "368": "ﭽ",
    # Heavy Snow Showers
    "335": "ﭽ",
    "395": "ﭽ",
    "371": "ﭽ",
    # Heavy Snow
    "329": "流",
    "332": "流",
    "338": "流",
    # Light showers
    "353": "",
    # Thundery Showers
    "386": "",
    "389": "",
    # Thundery Snow Showers
    "392": ""
}

weather_icons_day = {
    # Sunny
    "113": "",
    # Partly Cloudy
    "116": "杖",
    # Cloudy
    "119": "摒",
    # Very Cloudy
    "122": "",
    # Fog
    "143": "",
    "248": "",
    "260": "",
    # Light Showers
    "176": "",
    "263": "",
    # Light Sleet Showers
    "179": "",
    "362": "",
    "365": "",
    "374": "",
    # Light Sleet
    "182": " ",
    "185": " ",
    "281": " ",
    "284": " ",
    "311": " ",
    "314": " ",
    "317": " ",
    "350": " ",
    "377": " ",
    # Thundery Showers
    "200": "",
    # Light Snow
    "227": "",
    "320": "",
    # Heavy Snow
    "230": "",
    # Light rain
    "266": "",
    "293": "",
    "296": "",
    # Heavy Showers
    "299": "",
    "305": "",
    "356": "",
    # Heavy Rain
    "302": "",
    "308": "",
    "359": "",
    # Light Show Showers
    "323": "ﭽ",
    "326": "ﭽ",
    "368": "ﭽ",
    # Heavy Snow Showers
    "335": "ﭽ",
    "395": "ﭽ",
    "371": "ﭽ",
    # Heavy Snow
    "329": "流",
    "332": "流",
    "338": "流",
    # Light showers
    "353": "",
    # Thundery Showers
    "386": "",
    "389": "",
    # Thundery Snow Showers
    "392": "",
}

# get location_id
# to get your own location_id, go to https://weather.com & search your location.
# once you choose your location, you can see the location_id in the URL(64 chars long hex string)
# like this: https://weather.com/en-IN/weather/today/l/c3e96d6cc4965fc54f88296b54449571c4107c73b9638c16aafc83575b4ddf2e
location_id = ""  # TODO
# location_id = "8139363e05edb302e2d8be35101e400084eadcecdfce5507e77d832ac0fa57ae"

# priv_env_cmd = 'cat $PRIV_ENV_FILE | grep weather_location | cut -d "=" -f 2'
# location_id = subprocess.run(
#     priv_env_cmd, shell=True, capture_output=True).stdout.decode('utf8').strip()

# get html page
url = f"https://wttr.in/?format=j1"
data = requests.get(url).json()

current_condition = data['current_condition'][0]

weather = data['weather']

# current temperature
temp = current_condition['temp_C']
# print(temp)

# current status phrase
status = current_condition['weatherDesc'][0]['value']
status = f"{status[:16]}.." if len(status) > 17 else status
# print(status)

# status code
status_code = current_condition['weatherCode']
# print(status_code)

# status icon
def icon_from_code(code):
    if status_code in weather_icons_day:
        return weather_icons_day[code]
    return ""
icon = icon_from_code(status_code)

# print(icon)

# temperature feels like
temp_feel = current_condition['FeelsLikeC']
temp_feel_text = f"Feels like {temp_feel}°C"
# print(temp_feel_text)

# min-max temperature
temp_min = weather[0]['mintempC']
temp_max = weather[0]['maxtempC']

temp_min_max = f" {temp_min}°C\t {temp_max}°C"
# print(temp_min_max)

# wind speed
wind_speed = current_condition['windspeedKmph']
wind_text = f" {wind_speed}km/h"
# print(wind_text)

# humidity
humidity = current_condition['humidity']
humidity_text = f" {humidity}%"
# print(humidity_text)


# hourly prediction
def prediction_from_index(index):
    prediction = weather[index]['hourly']
    icons = [icon_from_code(x['weatherCode']) for x in prediction]
    temp_c = [x['tempC'] for x in prediction]
    chance_of_rain = [x['chanceofrain'] for x in prediction]

    return f"""\
       \t             
 0 -  3\t{icons[0]} {temp_c[0].rjust(3)}°C {chance_of_rain[0].rjust(3)}%
 3 -  6\t{icons[1]} {temp_c[1].rjust(3)}°C {chance_of_rain[1].rjust(3)}%
 6 -  9\t{icons[2]} {temp_c[2].rjust(3)}°C {chance_of_rain[2].rjust(3)}%
 9 - 12\t{icons[3]} {temp_c[3].rjust(3)}°C {chance_of_rain[3].rjust(3)}%
12 - 15\t{icons[4]} {temp_c[4].rjust(3)}°C {chance_of_rain[4].rjust(3)}%
15 - 18\t{icons[5]} {temp_c[5].rjust(3)}°C {chance_of_rain[5].rjust(3)}%
18 - 21\t{icons[6]} {temp_c[6].rjust(3)}°C {chance_of_rain[6].rjust(3)}%
21 - 24\t{icons[7]} {temp_c[7].rjust(3)}°C {chance_of_rain[7].rjust(3)}%\
"""

# prediction_tomorrow = " ".join([icon(x['weatherCode']) for x in weather[1]['hourly']])
# prediction_day_after_tomorrow = " ".join([icon(x['weatherCode']) for x in weather[2]['hourly']])
# prediction = prediction.replace("Chance of Rain", "")
# prediction = f"\n\n    (hourly) {prediction}" if len(prediction) > 0 else prediction
# print(prediction)

# tooltip text
tooltip_text = f"""\
{status}
<small>{temp_feel_text}</small>

{temp_min_max}
{wind_text}\t{humidity_text}

Prediction today:
{prediction_from_index(0)}

Prediction tomorrow:
{prediction_from_index(1)}
"""

# print waybar module data
out_data = {
    "text": f"{icon} {temp}°C",
    "alt": status,
    "tooltip": tooltip_text,
    "class": status_code,
}
print(json.dumps(out_data))
