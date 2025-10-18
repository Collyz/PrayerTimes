import Toybox.Lang;
import Toybox.Time;
import Toybox.System;
import Toybox.Position;
import Toybox.WatchUi;
import Toybox.Communications;
class PrayerTimesDelegate extends WatchUi.BehaviorDelegate {
    
    var _view;

    function initialize(view as PrayerTimesView) {
        _view = view;
        BehaviorDelegate.initialize();
    }


    function onMenu() as Boolean {
        var settingsMenu = new WatchUi.Menu2(
            {:title => Rez.Strings.SettingsTitle}
            );
        settingsMenu.addItem(new WatchUi.MenuItem(Rez.Strings.GetTimes, null, "getTimes", null));
        settingsMenu.addItem(new WatchUi.MenuItem(Rez.Strings.Set24, null, "set24", null));
        settingsMenu.addItem(new WatchUi.MenuItem(Rez.Strings.Set12, null, "set12", null));
        settingsMenu.addItem(new WatchUi.MenuItem(Rez.Strings.ClearTimes, null, "clearTimes", null));
        WatchUi.pushView(settingsMenu, new $.SettingsMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}