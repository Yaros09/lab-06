#lab-06
```
name: cpack
on:
  push:
    branches: main

  workflow_dispatch:


jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: ARC
        shell: bash
        run: |
          mkdir _build
          cd _build
          cmake -DGenerator=ARC ..
          cmake --build .
          cpack -G ZIP
      - name: Release
        id: create_release
        uses: actions/create-release@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }} 
        with:
          tag_name: v1.0.0
          release_name: Release v1.0.0
          
      - name: Upload Release Asset
        id: upload-release-asset
        uses: actions/upload-release-asset@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          upload_url: ${{ steps.create_release.outputs.upload_url }}
          asset_path: _build/cpack-1.0.0-Linux.zip
          asset_name: Solver.zip
          asset_content_type: application/zip
          
  Package_files_TGZ:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      
      - name: Build Tar file
        shell: bash
        run: |
          mkdir _build 
          cd _build
          cmake -DGenerator=ARC ..
          cmake --build .
          cpack -G TGZ
           
      - name: Release
        id: create_release
        uses: actions/create-release@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }} 
        with:
          tag_name: v1.1.0
          release_name: Release v1.1.0
          
      - name: Upload Release Asset
        id: upload-release-asset
        uses: actions/upload-release-asset@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          upload_url: ${{ steps.create_release.outputs.upload_url }}
          asset_path: _build/cpack-1.0.0-Linux.tar.gz
          asset_name: Solver.tar.gz
          asset_content_type: application/tgz
```
```
name: Binnary

on:
  push:
    branches: 
    - main

  workflow_dispatch:

jobs:
  DEB:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v2
      
      - name: Build DEB
        shell: bash
        run: |
          mkdir _build 
          cd _build
          cmake -DGenerator=DEB ..
          cmake --build .
          cpack  
          
      - name: Release
        id: create_release
        uses: actions/create-release@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }} 
        with:
          tag_name: v2.0.0
          release_name: Release v2.0.0
          
      - name: Upload Release Asset
        id: upload-release-asset
        uses: actions/upload-release-asset@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          upload_url: ${{ steps.create_release.outputs.upload_url }}
          asset_path: _build/cpack-1.0.0-Linux.deb
          asset_name: BinaryFiles.deb
          asset_content_type: application/deb
          
  RPM:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v2
      
      - name: prepare environment
        run: |
          sudo apt install git
          sudo apt-get install rpm
      
      - name: Build RPM
        shell: bash
        run: |
          mkdir _build
          cd _build
          cmake -DGenerator=RPM ..
          cmake --build .
          cpack 
          
      - name: Release
        id: create_release
        uses: actions/create-release@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }} 
        with:
          tag_name: v2.1.0
          release_name: Release v2.1.0
          
      - name: Upload Release Asset
        id: upload-release-asset
        uses: actions/upload-release-asset@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          upload_url: ${{ steps.create_release.outputs.upload_url }}
          asset_path: _build/cpack-1.0.0-Linux.rpm
          asset_name: Solver.rpm
          asset_content_type: application/rpm
          
          
  MSI:
    runs-on: windows-latest
    
    steps:
      - uses: actions/checkout@v2
      
      - name: Build MSI
        shell: bash
        run: |
          mkdir _build
          cd _build
          cmake -DGenerator=MSI ..
          cmake --build .
          cpack -C CPackConfig.cmake
          
      - name: Release
        id: create_release
        uses: actions/create-release@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }} 
        with:
          tag_name: v2.2.0
          release_name: Release v2.2.0
          
      - name: Upload Release Asset
        id: upload-release-asset
        uses: actions/upload-release-asset@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          upload_url: ${{ steps.create_release.outputs.upload_url }}
          asset_path: _build/cpack-1.0.0-win64.msi
          asset_name: Solver.msi
          asset_content_type: application/msi
          
          
  DMG:
    runs-on: macos-latest
    
    steps:
      - uses: actions/checkout@v2
      
      - name: Build DMG
        shell: bash
        run: |
          mkdir _build
          cd _build
          cmake -DGenerator=DMG ..
          cmake --build .
          cpack 
          
      - name: Release
        id: create_release
        uses: actions/create-release@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }} 
        with:
          tag_name: v2.3.0
          release_name: Release v2.3.0
          
      - name: Upload Release Asset
        id: upload-release-asset
        uses: actions/upload-release-asset@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          upload_url: ${{ steps.create_release.outputs.upload_url }}
          asset_path: _build/cpack-1.0.0-Darwin.dmg
          asset_name: Solver.dmg
          asset_content_type: application/dmg
```
