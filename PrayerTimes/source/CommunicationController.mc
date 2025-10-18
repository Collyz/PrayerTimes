import Toybox.Lang;
import Toybox.Time;
import Toybox.System;
import Toybox.Position;
import Toybox.WatchUi;
import Toybox.Communications;

class CommunicationsController {
    
    public function checkWifiStatus() as Void {
        Communications.checkWifiConnection(method(:onWifiCallback));
    }

    public function checkGPS() as Void {
        Position.enableLocationEvents(Position.LOCATION_ONE_SHOT, method(:onPosition));
    }

    
    public function onPosition(info as Info) as Void {  
        var position = info.position;
        if (position != null){
            circleColor = Graphics.COLOR_GREEN;
            var data = position.toDegrees();
            lat = data[0];
            lon = data[1];
        } else {
            circleColor = Graphics.COLOR_RED;
        }
    }

    public function onWifiCallback(result as {:wifiAvailable as Boolean, :errorCode as Communications.WifiConnectionStatus}) as Void{
        if (result[:wifiAvailable]) {
            self.makeRequest();
        }
    }

    public function getUTCOffset() as Float {
        // Gets the UTC offset in seconds and converts it to hours offset
        return System.getClockTime().timeZoneOffset / 60.0 / 60.0;
    }

     //! Make the web request
    private function makeRequest() as Void {
        var url = "https://prayer-api-kappa.vercel.app/praytime";
        var params = {
            "lat" => lat,
            "lon" => lon,
            "utcOffset" => getUTCOffset()
        };
        var options = {
            :method => Communications.HTTP_REQUEST_METHOD_POST,
            :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
            :headers => {
                "Content-Type" => Communications.REQUEST_CONTENT_TYPE_JSON
            }
        };

        var settings = System.getDeviceSettings();
        var cinfo = settings.connectionInfo;
        if (cinfo instanceof Dictionary) {
            var keys = cinfo.keys();
            for (var i = 0 ; i < keys.size(); i++) {
                System.println(keys[i].toString() + ": " + cinfo[keys[i]].state);
            }
        }
        Communications.makeWebRequest(
            url,
            params,
            options,
            method(:onReceive)
        );
    }

    public function onReceive(responseCode as Number, data as Dictionary or String or Null) as Void {
        if (responseCode == 200) {
            // System.println(data);
            if (data instanceof Dictionary) {
                self.updateLabel(labelKeys[0], data["fajr"]);
                self.updateLabel(labelKeys[1], data["dhuhr"]);
                self.updateLabel(labelKeys[2], data["asr"]);
                self.updateLabel(labelKeys[3], data["maghrib"]);
                self.updateLabel(labelKeys[4], data["isha"]);
            }
            
            // Update view
        } else {
            // Update view
            circleColor = Graphics.COLOR_DK_RED;
            System.println("failure: " + responseCode);
        }
    }

    // Update a single label
    function updateLabel(key as Lang.String, updateValue) as Void {
        if (updateValue != null) {
            storageManager.updateValue(key, updateValue);
            WatchUi.requestUpdate();
        }
    }

}