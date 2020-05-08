Config                            = {}
Config.DrawDistance               = 100.0
--language currently available EN and SV
Config.Locale                     = 'en'
Config.AvailableJobs = {'police', 'ambulance', 'taxi', 'mechanic', 'bar', 'cardealer', 'tender'}

Config.Zones = {

  PoliceDuty = {
    Pos   = { x = 456.29, y = -989.07, z = 29.5 },
    Size  = { x = 1.5, y = 1.5, z = 1.5 },
    Color = { r = 0, g = 255, b = 0 },  
    Type  = 1,
  },

  AmbulanceDuty = {
    Pos = { x = 322.16, y = -568.92, z = 27.79 },
    Size = { x = 1.5, y = 1.5, z = 1.5 },
    Color = { r = 0, g = 255, b = 0 },
    Type = 1,
  },
  TaxistaDuty = {
    Pos = { x = 895.44, y = -179.41, z = 73.6 },
    Size = { x = 1.5, y = 1.5, z = 1.5 },
    Color = { r = 0, g = 255, b = 0 },
    Type = 1,
  },
  MecanicoDuty = {
    Pos = { x = -343.82, y = -123.5, z = 38.01 },
    Size = { x = 1.5, y = 1.5, z = 1.5 },
    Color = { r = 0, g = 255, b = 0 },
    Type = 1,
  },
  TenderoDuty = {
    Pos = { x = -708.05, y = -904.12, z = 18.22 },
    Size = { x = 1.5, y = 1.5, z = 1.5 },
    Color = { r = 0, g = 255, b = 0 },
    Type = 1,
  },
  BarmanDuty = {
    Pos = { x = 951.13, y = 33.95, z = 73.88 },
    Size = { x = 1.5, y = 1.5, z = 1.5 },
    Color = { r = 0, g = 255, b = 0 },
    Type = 1,
  },
  CardealerDuty = {
    Pos = { x = -31.57, y = -1112.09, z = 25.42 },
    Size = { x = 1.5, y = 1.5, z = 1.5 },
    Color = { r = 0, g = 255, b = 0 },
    Type = 1,
  }
}