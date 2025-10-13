import Toybox.Application;
import Toybox.Lang;
import Toybox.Position;
import Toybox.WatchUi;

var labelKeys as Array<String> = ["Fajr", "Dhuhr", "Asr", "Magrib", "Isha"];
var dataObject = new StorageManager();
// var calc = new PrayerTimesCalculator();

class PrayerTimesApp extends Application.AppBase {

    private var _view as PrayerTimesView;

    function initialize(){
        AppBase.initialize();
        _view = new PrayerTimesView();
        dataObject.createKeys(labelKeys);
    }

    function onStart(state as Dictionary or Null) as Void {
        Position.enableLocationEvents(Position.LOCATION_CONTINUOUS, method(:onPosition));
    }

    function onStop(state as Dictionary or Null) as Void {
        Position.enableLocationEvents(Position.LOCATION_DISABLE, method(:onPosition));
    }

    public function onPosition(info as Info) as Void {
        _view.setPosition(info);
    }

    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [_view, new PrayerTimesDelegate(_view)];
    }
}

function getApp() as PrayerTimesApp {
    return Application.getApp() as PrayerTimesApp;
}