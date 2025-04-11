import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# Load datasets
azimuth = pd.read_csv("solar_azimuth_hourly_avg_delft.csv", index_col=0)
elevation = pd.read_csv("solar_elevation_hourly_avg_delft.csv", index_col=0)
irradiation = pd.read_csv("solar_irradiation_hourly_avg_delft.csv", index_col=0)
usage = pd.read_csv("household_electricity_usage.csv", index_col=0)
usage = usage.transpose()*0.4
usage.columns = usage.columns.astype(str)


# Function to fit a high-order polynomial and return a continuous function
def fit_polynomial(month):
    """
    Fits a polynomial of specified degree to the hourly solar data for a given month.
    Returns continuous polynomial functions for azimuth, elevation, and irradiation.
    """
    hours = np.linspace(0, 23, 24)  # Original hourly points

    # Check if month exists in dataset
    if str(month) not in azimuth.columns:
        raise ValueError(f"Month {month} not found in dataset.")

    # Fit high-order polynomials
    azimuth_poly = np.poly1d(np.polyfit(hours, azimuth[str(month)], 1))
    elevation_poly = np.poly1d(np.polyfit(hours, elevation[str(month)], 6))
    irradiation_poly = np.poly1d(np.polyfit(hours, irradiation[str(month)], 6))
    usage_poly = np.poly1d(np.polyfit(hours, usage[str(month)], 8))

    return azimuth_poly, elevation_poly, irradiation_poly, usage_poly


# Loop through each month and print the polynomial equations
for month in range(1, 13):  # Months from 1 to 12
    azimuth_poly, elevation_poly, irradiation_poly, usage_poly = fit_polynomial(month)
    
    print(f"Month {month}:")
    print(f"  Azimuth Polynomial: {azimuth_poly}")
    print(f"  Elevation Polynomial: {elevation_poly}")
    print(f"  Irradiation Polynomial: {irradiation_poly}")
    print(f"  Usage Polynomial: {usage_poly}")
    print("-" * 50)  # Separator for readability

# Example usage: Evaluate at any time (continuous function)
time_example = 10.5
print(f"Azimuth at 10:30 AM in June: {azimuth_poly(time_example):.2f}°")
print(f"Elevation at 10:30 AM in June: {elevation_poly(time_example):.2f}°")
print(f"Irradiation at 10:30 AM in June: {irradiation_poly(time_example):.2f} Wh/m²")
print(f"usage at 10:30 AM in June: {usage_poly(time_example):.2f} Wh/m²")

# Generate smooth curves for visualization
time_values = np.linspace(0, 23, 1000)
plt.figure(figsize=(10, 5))

# Choose which month to plot
month = 6;
azimuth_poly, elevation_poly, irradiation_poly, usage_poly = fit_polynomial(month)

plt.subplot(4, 1, 1)
#plt.plot(time_values, azimuth_poly(time_values), label="Azimuth", color="b")
plt.plot(np.linspace(0, 23, 24), azimuth[str(month)], color="b")
plt.scatter(np.linspace(0, 23, 24), azimuth[str(month)], color="r",s=10)
plt.title(f"Solar Azimuth Approximation (Month {month})")
plt.xlabel("Hour of the Day")
plt.ylabel("Azimuth (°)")


plt.subplot(4, 1, 2)
#plt.plot(time_values, elevation_poly(time_values), label="Elevation", color="g")
plt.plot(np.linspace(0, 23, 24), elevation[str(month)], color="c")
plt.scatter(np.linspace(0, 23, 24), elevation[str(month)], color="r",s=10)
plt.title(f"Solar Elevation Approximation (Month {month})")
plt.xlabel("Hour of the Day")
plt.ylabel("Elevation (°)")


plt.subplot(4, 1, 3)
#plt.plot(time_values, irradiation_poly(time_values), label="Irradiation", color="orange")
plt.plot(np.linspace(0, 23, 24), irradiation[str(month)], color="k")
plt.scatter(np.linspace(0, 23, 24), irradiation[str(month)], color="r",s=10)
plt.title(f"Solar Irradiation Approximation (Month {month})")
plt.xlabel("Hour of the Day")
plt.ylabel("Irradiation (Wh/m²)")


plt.subplot(4, 1, 4)
#plt.plot(time_values, usage_poly(time_values), label="Usage", color="c")
plt.plot(np.linspace(0, 23, 24), usage[str(month)], color="y")
plt.scatter(np.linspace(0, 23, 24), usage[str(month)], color="r",s=10)
plt.title(f"Energy usage Approximation (Month {month})")
plt.xlabel("Hour of the Day")
plt.ylabel("Energy Usage (kW)")


plt.tight_layout()
plt.show()
