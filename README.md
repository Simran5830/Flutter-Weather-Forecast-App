Flutter Weather Forecast App

Description:
A simple and elegant Flutter application that fetches and displays real-time weather information for any city using the OpenWeather API. The app allows users to search cities dynamically with autocomplete suggestions, view detailed weather metrics like temperature, humidity, and wind speed, and refresh data instantly.

Key Features

City Autocomplete: Suggests city names from a local JSON file as you type.

Live Weather Data: Fetches current weather details (temperature, humidity, wind speed, etc.) using a REST API.

Dynamic UI: Background card color changes automatically based on weather conditions (e.g., sunny, rainy, cloudy).

Pull to Refresh: Users can refresh data easily using a swipe-down gesture.

Error Handling: Displays user-friendly messages for invalid cities or network errors.

Responsive UI: Works smoothly across various screen sizes.

Tech Stack

Framework: Flutter

Language: Dart

API: OpenWeatherMap API

State Management: Stateful Widgets (setState)

Data Source: Local JSON (cities.json) for autocomplete suggestions

Packages Used:

http for API calls (in weather_api.dart)

flutter/services.dart for loading local assets

jsonDecode for JSON parsing

How It Works

City Selection:

Users type or select a city from autocomplete suggestions.

Weather Fetching:

The app calls WeatherApi.fetchData(cityName) to retrieve live data.

Display Results:

Shows weather info inside a styled card, with icon and condition-specific background.

Error Handling:

If the city is invalid or network fails, a red snackbar displays a clear message.
