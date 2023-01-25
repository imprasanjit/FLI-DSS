package com.sparc.flidss.utility;
/**
 * Calculation from Coordinates
 * @author Thakur
 * CDate 07 Jan 2021
 */
public class CalculateAllFromCoordinates
    {
        public Double distance(Double lat1, Double lon1, Double lat2, Double lon2, Character unit)
        {
            if ((lat1 == lat2) && (lon1 == lon2))
            {
                return 0d;
            }
            else
            {
                Double theta = lon1 - lon2;
                Double dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2)) + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta));
                dist = Math.acos(dist);
                dist = rad2deg(dist);
                dist = dist * 60 * 1.1515;
                if (unit == 'K') //kilometers
                    dist = dist * 1.609344;
                else if (unit == 'N') //nautical miles
                    dist = dist * 0.8684;
                return (dist);
            }
        }
        
        private Double deg2rad(Double deg)
        {
            return (deg * Math.PI / 180.0);
        }
        private Double rad2deg(Double rad)
        {
            return (rad / Math.PI * 180.0);
        }
    }