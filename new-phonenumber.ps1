Function new-phoneNumber {    
       param([int]$NumberToDo = 1)

for ($genindex = 1; $genindex -le $NumberToDo; $genindex++) {

    $area = get-random -Minimum 200 -Maximum 999
    $sufF = get-random -Minimum 1000 -Maximum 9999

    $phone = "($area)555-$suff"
    }
    $phone
    }
