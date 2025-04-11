import pvlib
import pandas as pd

# Define Delft's location
latitude = 51.99  # degrees (N)
longitude = 4.36   # degrees (E)
timezone = "Europe/Amsterdam"

# Generate a full year of hourly timestamps
times = pd.date_range(start="2024-01-01", end="2024-12-31 23:00:00", freq="H", tz=timezone)

# Calculate solar positions (azimuth & elevation angles)
solar_position = pvlib.solarposition.get_solarposition(times, latitude, longitude)

# Extract azimuth and elevation
solar_position["Hour"] = solar_position.index.hour  # Extract hour of the day
solar_position["Month"] = solar_position.index.month  # Extract month

# Group by month and hour to compute average values
monthly_hourly_avg = solar_position.groupby(["Month", "Hour"])[["azimuth", "elevation"]].mean()

# Reshape the data to match your dataset format
azimuth_pivot = monthly_hourly_avg["azimuth"].unstack(level=0)  # Columns as months
elevation_pivot = monthly_hourly_avg["elevation"].unstack(level=0)  # Columns as months

# Save to CSV
azimuth_pivot.to_csv("solar_azimuth_hourly_avg_delft2.csv")
elevation_pivot.to_csv("solar_elevation_hourly_avg_delft2.csv")

# Display first few rows
print("Azimuth Averages:")
print(azimuth_pivot.head())
print("\nElevation Averages:")
print(elevation_pivot.head())
