# config/initializers/high_voltage.rb
HighVoltage.configure do |config|
  config.layout = 'blacklight'
  config.route_drawer = HighVoltage::RouteDrawers::Root
end
