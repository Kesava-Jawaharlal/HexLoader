Pod::Spec.new do |s|
  s.name             = 'HexLoader'
  s.version          = '0.1.1'
  s.summary          = 'The library has a hexagon shaped loader with can customised in numerous ways as documented'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'This is a generic library to load a hexagon shaped loading indicator. Its highly customisable and used CAShapeLayer to draw the shapes directly on the UIView'
  

  s.homepage         = 'https://github.com/Kesava-Jawaharlal/HexLoader'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Kesavasankar Jawaharlal' => 'kesava.jawaharlal@gmail.com' }
  s.source           = { :git => 'https://github.com/Kesava-Jawaharlal/HexLoader.git', :tag => s.version }
  s.ios.deployment_target = '8.0'
  s.source_files = 'HexLoader/Classes/**/*.swift'
end
