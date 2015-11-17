# TechD-Robin/TDResourceManager

The `TDResourceManager` is base resource manager library of Tech.D. <br>

The Resource Manager provide the same method to get resources :

* from resourcePath(normal file system).

* from assets bundle object

* from zipped file.



## Install

### Download

Click `Download ZIP` or here : [download][downloadLink]


### [CocoaPods][cocoaPodsLink]

add `Podfile` in project's root directory, content like below : 

```ruby
platform :ios, '8.0'
pod "TDResourceManager", "~> 0.0.3"

```

```ruby
platform :ios, '8.0'
pod 'TDResourceManager',   :git => 'https://github.com/TechD-Robin/TDResourceManager.git',    :branch => 'develop'
```

## Dependencies

* [TDforkZipArchive][dependenceTDforkZipArchive] fork from [ZipArchive][dependenceZipArchive]
* [TDFoundation][dependenceTDFoundation]




## License

`TDResourceManager` is released under the [MIT License][mitLink]. See `LICENSE` for details.


----
[downloadLink]:https://github.com/TechD-Robin/TDResourceManager/archive/master.zip
[cocoaPodsLink]:https://cocoapods.org/

[dependenceZipArchive]: https://github.com/mattconnolly/ZipArchive
[dependenceTDforkZipArchive]: https://github.com/TechD-Robin/TDforkZipArchive 
[dependenceTDFoundation]: https://github.com/TechD-Robin/TDFoundation

[mitLink]:http://opensource.org/licenses/MIT


