import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class SettingsMenuDelegate extends WatchUi.Menu2InputDelegate {

    var commsController = new CommunicationsController();
    var setTo24HoursMsg = "Set to 24 Hour Format";
    var setTo12HoursMsg = "Set to 12 Hour Format";
    var clearTimesMsg = "Times Cleared";

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item as MenuItem) {
        var id = item.getId() as String;
        var loadingView = new LoadingView();
        if (id == :getTimes) {
            WatchUi.pushView(loadingView, null, SLIDE_UP);
            commsController.checkGPS(loadingView);
        } else if (id == :set24) {
            storageManager.updateValue(formatAsHour12Key, false);
            WatchUi.pushView(loadingView, null, SLIDE_UP);
            loadingView.successCallback(setTo24HoursMsg, new Method(loadingView, :returnToMenu));
        } else if (id == :set12) {
            storageManager.updateValue(formatAsHour12Key, true);
            WatchUi.pushView(loadingView, null, SLIDE_UP);
            loadingView.successCallback(setTo12HoursMsg, new Method(loadingView, :returnToMenu));
        } else if (id == :clearTimes) {
            storageManager.clearTimes(labelKeys);
            WatchUi.pushView(loadingView, null, SLIDE_UP);
            loadingView.successCallback(clearTimesMsg, new Method(loadingView, :returnToMenu));
        }
    }

    function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
    }
}