import Toybox.Application.Storage;
import Toybox.Lang;
import Toybox.WatchUi;

public var default_time = "--:--";
public var formatAsHour12Key = "is12";
public var labelKeys as Array<String> = ["Fajr", "Dhuhr", "Asr", "Maghrib", "Isha"];


class StorageManager {


    function keyExists(key as String) as Boolean {
        var value = Storage.getValue(key);
        return value != null;
    }

    function createKeys(keys as Array<String>) as Void {
        // Create the storage for the boolean that determines the time formatting
        if (!keyExists(formatAsHour12Key)) {
            Storage.setValue(formatAsHour12Key, true);
        }
        // Create the storage for the prayer times
        for (var i = 0; i < keys.size(); i++) {
            var key = keys[i];
            if (!keyExists(key)) {
                Storage.setValue(key, default_time);
            }
        }
        
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
                Storage.setValue(key, default_time);
            }
        }
    }

}
