import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class SettingsMenuDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item as MenuItem) {
        System.println(item.getId());
    }
}