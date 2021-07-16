# SynoAPI

Fully modeled Synology API client in dart.

## Usage

E.g. Get and create tasks on Download Station.

```dart
import 'package:synoapi/synoapi.dart';

main() async {
  var context = api.APIContext('myds.com', port: 5000);
  var dsApi = api.DownloadStationAPI(context);

  var authOk = await context.authApp(api.Syno.DownloadStation.name, 'user', 'password');

  // list tasks from Download Station
  dsApi.task.list().then((response) {
    var tasks = response.data?.tasks ?? [];
    tasks.forEach((task) {
      print('Task: ${task.title}');
    });
  });
  
  // create task from magnet uri
  dsApi.task.create(uris: ['magnet://abcdefg']).then((response) {
    print('Task creation ${response.success ? 'success' : 'failed'}');
  });
}
```

## Limitations

- Only Download Station API provided currently.

## References

 - [Synology_Download Station Official API_20140326](https://global.download.synology.com/download/Document/Software/DeveloperGuide/Package/DownloadStation/All/enu/Synology_Download_Station_Web_API.pdf)
