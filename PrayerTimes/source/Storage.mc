import Toybox.Application.Storage;
import Toybox.Lang;
import Toybox.WatchUi;

class StorageManager {

    private var _default_time = "--:--";

    function createKeys(keys as Array<String>) as Void {
        for (var i = 0; i < keys.size(); i++) {
            var key = keys[i];
            var value = getValue(key);
            if (value == null) {
                Storage.setValue(key, _default_time);
            }
        }
    }

    function keyExists(key as String) as Boolean {
        var value = Storage.getValue(key);
        return value != null;
    }

    function getValue(key as String) as String or Null {
        var value = Storage.getValue(key);
        if (value == null) {
            return null;
        }
        return value as String;
    }

    // Update a stored value
    function updateValue(key as String, value as String) as Void {
        if (keyExists(key)) {
            Storage.setValue(key, value);
        }
    }

    function clearTimes(keys as Array<String>) as Void {
        for (var i = 0; i < keys.size(); i++) {
            var key = keys[i];
            if (keyExists(key)) {
                Storage.setValue(key, _default_time);
            }
        }
    }

}
