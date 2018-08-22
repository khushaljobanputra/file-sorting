Describe "Empty src folder test" {
    It "Should output error message" {
        mkdir $TestDrive/src
        mkdir $TestDrive/dest1
        mkdir $TestDrive/dest2
        $expected = "No files were found for processing"
        File-Sort $TestDrive/src $TestDrive/dest1 $TestDrive/dest2 | Should Be $expected
    }
}

Describe "Src folder with filenames starting with lowercase and number" {
    It "Should delete all files in source folder" {
        mkdir $TestDrive/src
        mkdir $TestDrive/dest1
        mkdir $TestDrive/dest2
        New-Item -path $TestDrive/src -Name "apple.txt" -Value 'Sample' -ItemType file -force
        New-Item -path $TestDrive/src -Name "pear.txt" -Value 'Sample' -ItemType file -force
        New-Item -path $TestDrive/src -Name "1234.txt" -Value 'Sample' -ItemType file -force
        File-Sort $TestDrive/src $TestDrive/dest1 $TestDrive/dest2
        Get-ChildItem -Path $TestDrive/src -File -Force -Recurse | Should Be $null
        Get-ChildItem -Path $TestDrive/dest1 -File -Force -Recurse | Should Be $null
        Get-ChildItem -Path $TestDrive/dest2 -File -Force -Recurse | Should Be $null
    }
}

Describe "Src folder with filenames starting with lowercase" {
    It "Should delete all files in source folder" {
        mkdir $TestDrive/src
        mkdir $TestDrive/dest1
        mkdir $TestDrive/dest2
        New-Item -path $TestDrive/src -Name "apple.txt" -Value 'Sample' -ItemType file -force
        New-Item -path $TestDrive/src -Name "bobcat.txt" -Value 'Sample' -ItemType file -force
        File-Sort $TestDrive/src $TestDrive/dest1 $TestDrive/dest2
        Get-ChildItem -Path $TestDrive/src -File -Force -Recurse | Should Be $null
        Get-ChildItem -Path $TestDrive/dest1 -File -Force -Recurse | Should Be $null
        Get-ChildItem -Path $TestDrive/dest2 -File -Force -Recurse | Should Be $null
    }
}

Describe "Src folder with filenames starting with uppercase A and P" {
    It "Should move file starting with A to dest1 and P to dest2" {
        mkdir $TestDrive/src
        mkdir $TestDrive/dest1
        mkdir $TestDrive/dest2
        New-Item -path $TestDrive/src -Name "Apple.txt" -Value 'Sample' -ItemType file -force
        New-Item -path $TestDrive/src -Name "Pear.txt" -Value 'Sample' -ItemType file -force
        File-Sort $TestDrive/src $TestDrive/dest1 $TestDrive/dest2
        Get-ChildItem -Path $TestDrive/src -File -Force -Recurse | Should Be $null
        Get-ChildItem -Path $TestDrive/dest1 -File -Force -Recurse | Should Not Be $null
        Get-ChildItem -Path $TestDrive/dest2 -File -Force -Recurse | Should Not Be $null
    }
}