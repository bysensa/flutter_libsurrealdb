#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint surrealdb.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'libsurrealdb'
  s.version          = '0.0.1'
  s.summary          = 'SurrealDB binding'
  s.description      = <<-DESC
SurrealDB binding
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

	# Rust related stuff
	s.public_header_files = 'Classes**/*.h'
  s.static_framework = true
  s.vendored_libraries = "**/*.a"
end
