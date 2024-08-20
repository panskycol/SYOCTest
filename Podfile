

#source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!
source 'https://github.com/CocoaPods/Specs.git'

# private
source 'https://git.wahaha636.com:6699/component/specs.git'

platform :ios, '12.0'
target 'SYTest' do
  pod 'WCDB.objc'
  pod 'FMDB'
  pod 'ReactiveObjC'
#  pod 'Logan', '~> 1.2.8'
  pod 'AFNetworking'
#  pod 'YYText'
  pod 'YYKit'
  pod 'JZUIKit'
  pod 'SDWebImage'
  pod 'KVOController'
  pod 'Aspects'
  pod 'PLCrashReporter'
  pod 'FBRetainCycleDetector'
end


post_install do|installer|
   #解决问题一
   find_and_replace("Pods/FBRetainCycleDetector/FBRetainCycleDetector/Layout/Classes/FBClassStrongLayout.mm",
       "layoutCache[currentClass] = ivars;", "layoutCache[(id)currentClass] = ivars;")
   #解决问题二
   find_and_replace("Pods/FBRetainCycleDetector/fishhook/fishhook.c",
   "indirect_symbol_bindings[i] = cur->rebindings[j].replacement;", "if (i < (sizeof(indirect_symbol_bindings) /
        sizeof(indirect_symbol_bindings[0]))) { \n indirect_symbol_bindings[i]=cur->rebindings[j].replacement; \n }")
end

def find_and_replace(dir, findstr, replacestr)
  Dir[dir].each do |name|
    FileUtils.chmod("+w",name) #add
      text = File.read(name)
      replace = text.gsub(findstr,replacestr)
      if text != replace
         puts "Fix: " + name
         File.open(name, "w") { |file| file.puts replace }
         STDOUT.flush
      end
  end
  Dir[dir + '*/'].each(&method(:find_and_replace))
end
