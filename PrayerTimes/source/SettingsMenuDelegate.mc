import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class SettingsMenuDelegate extends WatchUi.Menu2InputDelegate {

    var commsController = new CommunicationsController();

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item as MenuItem) {
        var id = item.getId() as String;
        if (id == :getTimes) {
            var loadingView = new LoadingView();
            WatchUi.pushView(loadingView, null, SLIDE_UP);
            commsController.checkGPS(loadingView);
        } else if (id == :set24) {
            storageManager.updateValue(formatAsHour12Key, false);
        } else if (id == :set12) {
            storageManager.updateValue(formatAsHour12Key, true);
        } else if (id == :clearTimes) {
            var loadingView = new LoadingView();
            storageManager.clearTimes(labelKeys);
            WatchUi.pushView(loadingView, null, SLIDE_UP);
            loadingView.successCallback("Times Cleared", new Method(loadingView, :returnToMenu));
            
        }
    }

    function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
    }
}