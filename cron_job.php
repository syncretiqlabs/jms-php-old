<?php

// Set the default time zone to Pacific/Auckland
date_default_timezone_set('Pacific/Auckland');

// DB connection details
$servername = "localhost";
$username = "bgbishal_jms_app";
$password = "jm5@ppUs3r1";
$db = "bgbishal_jms_db";




// Defining relevant variables
$cron_log_filename = 'cron_logs/'.date("d-m-Y").'.log';
$current_datetime = date("Y-m-d h:i:s");
$close_jd_date = date("Y-m-d", strtotime("+1 day")); // 1 day is added to the date as the cron functino is set to execute on UTC 1200 (Equivalent to either 2400 or 0100 NZT depending on the daylight savings)




// Create a new log file or open for writing logs
if(!file_exists($cron_log_filename))
{
    $file = fopen($cron_log_filename, 'w');
    fwrite($file,"This log are recorded in ".date_default_timezone_get()."\n------------------------------------------------\n");
}
else{
    $file = fopen($cron_log_filename, 'a+');    
}

// Connecting to database
$conn = new mysqli($servername, $username, $password, $db);
if ($conn->connect_error) {
  fwrite($file, $current_datetime.' CRON FUNCTION DID NOT EXECUTED. Database connection error: ' . $conn->connect_error)."\n"; 
  die();
}


/****************************** CLOSING PAST JOB DISPATCHS **********************************************/

// Getting the job dispatched ready for closing
$sql = "select * from JobDispatch where DispatchedDate < '{$close_jd_date}' and DispatchOpen !='closed'";
$result = $conn->query($sql);

if($result && $result->num_rows>0)
{
    while($row = $result->fetch_array()) { $jds_to_close[] = $row; }
    
    foreach ($jds_to_close as $jd)
    {

        $update_sql = "Update JobDispatch set DispatchOpen ='closed' where Id = ".$jd[Id];
        
        $conn->query($update_sql);
        if($conn->affected_rows == 1)
        {
            $log_message = $current_datetime.' Job Dispatch Id '. $jd[Id] . ' is marked as closed successfully.' . "\n";
            fwrite($file, $log_message); 
        }
        else
        {
            $log_message = $current_datetime.' Job Dispatch Id '. $jd[Id] . ' COULD NOT BE marked as closed with query <i>' . $update_sql . "</i>\n";
            fwrite($file, $log_message); 
        }
        
    }
    
}
else{
    fwrite($file,$current_datetime."No Job dispatch found to be closed using query <b>".$sql."</b>\n");
}



/****************************** CREATING NEW RECURRING JOB DISPATCHS **************************************/


/****************************** JOB STATUS UPDATE **************************************/
// Inprogress - If the first job dispatch has past the current date
// Completed - If there is no open future job dispatch
?>