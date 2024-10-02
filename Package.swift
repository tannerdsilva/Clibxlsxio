// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Clibxlsxio",
    platforms: [
    	.macOS(.v12)
    ],
    products: [
        .library(
            name: "Clibxlsxio",
            targets: ["Clibxlsxio"]),
    ],
    dependencies: [],
    targets: [
    	.target(
            name:"Clibxlsxio",
            dependencies:["Cexpat", "Clibzip"],
            path:"./xlsxio",
            exclude:[],
            sources:["lib"],
            publicHeadersPath:"include",
            cSettings:[]
        ),
        .systemLibrary(
			name: "Clibzip",
			pkgConfig: "libzip",
			providers: [
				.brew(["libzip"]),
				.apt(["libzip-dev"])
			]
		),
        .systemLibrary(
			name: "Cexpat",
			pkgConfig: "expat",
			providers: [
				.brew(["expat"]),
				.apt(["libexpat1-dev"])
			]
		)
    ],
    cxxLanguageStandard: .cxx20
)
