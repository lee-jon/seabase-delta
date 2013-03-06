room(:airlock) do
  self.desc = "I am in the AIRLOCK."
  self.short_desc = "Airlock."
  item(:wheel, 'wheel') do
    self.presence = "Wheel"
  end
  item(:sign, 'sign') do
    self.presence = "Sign"
  end
end