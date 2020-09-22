# mix run priv/repo/seeds.exs

alias SwsPhx.Repo
alias SwsPhx.Schemas.User
alias SwsPhx.Schemas.DeviceDataType
alias SwsPhx.Schemas.Device

# DEFAULT USER (admin1234)
%User{id: user_id} = Repo.insert!(%User{
  email: "admin@sws.net.au",
  password: "$2b$12$tKc264YlR4..It2hM.CtO.811RyuLTAd2TP9gy8toMZgsZEVtFgum"
})

# DEVICE DATA TYPES
Repo.insert!(%DeviceDataType{
  description: "temperature", unit: "°C"
})
Repo.insert!(%DeviceDataType{
  description: "pressure", unit: "kPa"
})
Repo.insert!(%DeviceDataType{
  description: "humidity", unit: "g.kg-1"
})
Repo.insert!(%DeviceDataType{
  description: "soil temp", unit: "°C"
})
Repo.insert!(%DeviceDataType{
  description: "soil moisture level"
})
Repo.insert!(%DeviceDataType{
  description: "rain sensing"
})
Repo.insert!(%DeviceDataType{
  description: "time"
})

# DEFAULT DEVICE
Repo.insert!(%Device{
  name: "Prototype #1",
  user_id: user_id
})
