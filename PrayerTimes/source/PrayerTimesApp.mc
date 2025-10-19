import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Position;
import Toybox.WatchUi;

public var lat = 39.353007;
public var lon = -74.463422;
public var storageManager = new StorageManager();

class PrayerTimesApp extends Application.AppBase {

    private var _view as PrayerTimesView;

    function initialize(){
        AppBase.initialize();
        _view = new PrayerTimesView();
        storageManager.createKeys(labelKeys);
    }

    function onStart(state as Dictionary or Null) as Void {

    }

    function onStop(state as Dictionary or Null) as Void {
        Position.enableLocationEvents(Position.LOCATION_DISABLE, method(:cleanUp));
    }
    
    public function cleanUp(info as Info) as Void {
        
    }
    

    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [_view, new PrayerTimesDelegate()];
    }
}

function getApp() as PrayerTimesApp {
    return Application.getApp() as PrayerTimesApp;
}