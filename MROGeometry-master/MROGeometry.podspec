#
# Be sure to run `pod lib lint MROGeometry.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name              = "MROGeometry"
  s.version           = File.read('VERSION')
  s.summary           = "C and Objective C math and geometry helpers"
  s.description       = <<-DESC
Some C / Objective-C helpers related to

- [CGPoint](http://developer.apple.com/library/mac/#documentation/GraphicsImaging/Reference/CGGeometry/Reference/reference.html%23//apple_ref/doc/uid/TP30000955-CH2g-C016211),
- [CGAffineTransform](http://developer.apple.com/library/ios/#documentation/GraphicsImaging/Reference/CGAffineTransform/Reference/reference.html%23//apple_ref/doc/c_ref/CGAffineTransform),
- [CGPath](http://developer.apple.com/library/ios/#documentation/GraphicsImaging/Reference/CGPath/Reference/reference.html) and
- [SVG path](http://www.w3.org/TR/SVG/paths.html).
                      DESC
  s.homepage          = "http://purl.mro.name/ios/MROGeometry"
  s.license           = 'Human Rights License'
  s.author            = { "Marcus Rohrmoser" => "mrohrmoser@acm.org" }
  s.source            = { :git => "https://github.com/mro/MROGeometry.git", :tag => s.version.to_s }

  s.platform          = :ios, '5.0'
  s.ios.deployment_target = '5.0'
  s.requires_arc      = true

  s.source_files      = 'MROGeometry/*.{h,m,c}'
  s.prefix_header_file = 'MROGeometry/MROGeometry-Prefix.pch'

  s.public_header_files = 'MROGeometry/*CG*.h'
  s.frameworks      = 'CoreGraphics'
end
