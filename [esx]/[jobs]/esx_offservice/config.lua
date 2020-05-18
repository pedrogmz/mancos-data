Config                            = {}
Config.DrawDistance               = 100.0
--language currently available EN and SV
Config.Locale                     = 'en'
Config.AvailableJobs = {'police', 'ambulance', 'taxi', 'mechanic', 'bar', 'cardealer', 'tender'}

Config.Zones = {

  PoliceDuty = {
    Pos   = { x = 456.29, y = -989.07, z = 29.71 },
    Size  = { x = 1.5, y = 1.5, z = 1.5 },
    Color = { r = 0, g = 255, b = 0 },  
    Type  = 25,
  },

  AmbulanceDuty = {
    Pos = { x = 306.11, y = -597.76, z = 42.31 },
    Size = { x = 1.5, y = 1.5, z = 1.5 },
    Color = { r = 0, g = 255, b = 0 },
    Type = 25,
  },
  TaxistaDuty = {
    Pos = { x = 895.43, y = -179.53, z = 73.7 },
    Size = { x = 1.5, y = 1.5, z = 1.5 },
    Color = { r = 0, g = 255, b = 0 },
    Type = 25,
  },
  MecanicoDuty = {
    Pos = { x = -343.82, y = -123.5, z = 38.04 },
    Size = { x = 1.5, y = 1.5, z = 1.5 },
    Color = { r = 0, g = 255, b = 0 },
    Type = 25,
  },
  TenderoDuty = {
    Pos = { x = -708.05, y = -904.12, z = 18.22 },
    Size = { x = 1.5, y = 1.5, z = 1.5 },
    Color = { r = 0, g = 255, b = 0 },
    Type = 25,
  },
  BarmanDuty = {
    Pos = { x = 951.13, y = 33.95, z = 73.88 },
    Size = { x = 1.5, y = 1.5, z = 1.5 },
    Color = { r = 0, g = 255, b = 0 },
    Type = 25,
  },
  CardealerDuty = {
    Pos = { x = -31.57, y = -1112.09, z = 25.42 },
    Size = { x = 1.5, y = 1.5, z = 1.5 },
    Color = { r = 0, g = 255, b = 0 },
    Type = 25,
  }
}