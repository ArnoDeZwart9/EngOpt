import pandas as pd
import numpy as np
from scipy.interpolate import interp1d

# Load datasets
azimuth = pd.read_csv("solar_azimuth_hourly_avg_delft.csv", index_col=0)
elevation = pd.read_csv("solar_elevation_hourly_avg_delft.csv", index_col=0)
irradiation = pd.read_csv("solar_irradiation_hourly_avg_delft.csv", index_col=0)
usage = pd.read_csv("solar_irradiation_hourly_avg_delft", index_col=0)
usage = usage.transpose()
# Function to create interpolation functions for a given month
def create_interpolators(month):
    hours = np.arange(0, 24)  # Original hourly points
    
    # Check if month exists in dataset
    if str(month) not in azimuth.columns:
        raise ValueError(f"Month {month} not found in dataset.")

    # Create interpolation functions
    azimuth_interp = interp1d(hours, azimuth[str(month)], kind="cubic", fill_value="extrapolate")
    elevation_interp = interp1d(hours, elevation[str(month)], kind="cubic", fill_value="extrapolate")
    irradiation_interp = interp1d(hours, irradiation[str(month)], kind="cubic", fill_value="extrapolate")

    return azimuth_interp, elevation_interp, irradiation_interp

# Example: Get interpolated values for June at any time
month = 6  # June
azimuth_interp, elevation_interp, irradiation_interp = create_interpolators(month)

# Example usage: Interpolate values at 10.5 AM (10:30 AM)
time_example = 10.5
print(f"Interpolated values for June at {time_example} hours:")
print(f"Azimuth: {azimuth_interp(time_example):.2f}°")
print(f"Elevation: {elevation_interp(time_example):.2f}°")
print(f"Irradiation: {irradiation_interp(time_example):.2f} Wh/m²")
