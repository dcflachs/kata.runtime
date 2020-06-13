#!/usr/bin/php
<?PHP
  //Create or open daemon.json
  $path = '/etc/docker';
  $file_path = '/etc/docker/daemon.json';
  $config_path = '/mnt/cache/appdata/workspace/kata.runtime/source/runtimes';

  if ( is_dir($path) == false )
  { 
    @mkdir($path, 0777, true); 
  }

  if (file_exists($file_path)){
    echo "Found existing config file: $file_path\n";
    echo "Updating...\n";
    $jsonString = file_get_contents($file_path);
    $data = json_decode($jsonString, true);
  }else {
    echo "Creating new config file: $file_path\n";
    $data = [];
  }

  //Edit default ulimits
  $data["default-ulimits"]["nofile"]["Name"] = "nofile";
  $data["default-ulimits"]["nofile"]["Hard"] = 40960;
  $data["default-ulimits"]["nofile"]["Soft"] = 40960;

  //Add kata-qemu runtime
  $data["runtimes"]["kata-qemu"]["path"] = '/opt/kata/bin/kata-runtime';
  $data["runtimes"]["kata-qemu"]["runtimeArgs"] = ["--kata-config", '/opt/kata/share/defaults/kata-containers/configuration-qemu.toml'];

  $newJsonString = json_encode($data, JSON_PRETTY_PRINT+JSON_UNESCAPED_SLASHES);

  if ( is_dir($config_path) == true )
  {
    $files = glob("$config_path/*.json");

    if ( !empty($files) )
    {
      $data = json_decode($newJsonString, true);

      echo "Adding with user provided configs...\n";
      foreach ($files as $temp_path) 
      {
        echo "Adding file: $temp_path\n";
        $jsonString = file_get_contents($temp_path);
        $temp_data = json_decode($jsonString, true);

        $data = array_merge_recursive($data,$temp_data);
 //       foreach($temp_data as $key => $array){
 //         $r[$key] = array_merge_recursive($data[$key],$array);
//        }
      }

      $newJsonString = json_encode($data, JSON_PRETTY_PRINT+JSON_UNESCAPED_SLASHES);
    }
  }

  //Output new daemon.json
  file_put_contents($file_path, $newJsonString);

  //Trigger Dockerd to reload the daemon file
  echo "Reloading Dockerd...\n";
  $pidstr = shell_exec("pidof dockerd");
  $pidint = intval($pidstr);
  posix_kill($pidint, SIGHUP);
?>
