function File-Sort {
    Param(
      [string]$src,
      [string]$dst1,
      [string]$dst2
    )

    $array1 = @("A","B","C","D","E","F","G","H","I","J","K","L")
    $array2 = @("M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z")

    $fileList = Get-ChildItem -Path $src -File -Force -Recurse

    #Checks if the folder is empty
    if ($fileList.count -eq 0)
    {
        $empty = "No files were found for processing"
        return $empty
    }

    #Loops through all the files
    foreach ($file in $fileList)
    {
        $key = $file.BaseName[0]
        #Loops through all the letters from array1 and array2 in each if statement.
        #Counter set to 14 because that is the max size between both arrays
        #Single forloop helps save time
        for ($i=0; $i -lt 14; $i++)
        {
            #Checks if first letter preset in array1 and moves file to dest1 if true
            if($array1[$i] -ceq $key) 
            {
                Move-Item -Path $($file.FullName) -Destination $dst1
            }
            #Checks if first letter preset in array2 and moves file to dest2 if true
            if($array2[$i] -ceq $key)
            {
                Move-Item -Path $($file.FullName) -Destination $dst2
            }
        }
    }

    $fileList = Get-ChildItem -Path $src -File -Force -Recurse

    foreach ($file in $fileList) {
        Remove-Item -Path $($file.FullName) -Force
    }
}
