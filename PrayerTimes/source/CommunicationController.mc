import Toybox.Lang;
import Toybox.Time;
import Toybox.System;
import Toybox.Position;
import Toybox.WatchUi;
import Toybox.Communications;

class CommunicationsController {
    private var _view as LoadingView?;
    private var _gpsMsg = "Getting GPS Info";
    private var _wifiMsg = "Finding Wifi";
    private var _wifiSuccessMsg = "Found Wifi,\nMaking Request";

    public function checkWifiStatus() as Void {
        // System.println("Started wifi check");
        _view.setMessage(_wifiMsg);
        _view.startWifiTimer();
        _view.resetColors();

        Communications.checkWifiConnection(method(:onWifiCallback));
    }

    public function checkGPS(view as LoadingView) as Void {
        _view = view;
        _view.setMessage(_gpsMsg);
        _view.startGPSTimer();

        Position.enableLocationEvents(Position.LOCATION_ONE_SHOT, method(:onPosition));
        // _view.stopGPSTimer();
        // _view.successCallback("GPS Success", method(:checkWifiStatus));
    }

    public function onPosition(info as Info) as Void {  
        _view.stopGPSTimer();
        var position = info.position;
        if (position != null){
            var data = position.toDegrees();
            lat = data[0];
            lon = data[1];
            _view.successCallback("GPS Success", method(:checkWifiStatus));
        } else {
            _view.startFailureTimer("Failed at GPS");
        }
    }

    public function onWifiCallback(result as {:wifiAvailable as Boolean, :errorCode as Communications.WifiConnectionStatus}) as Void{
        if (result[:wifiAvailable]) {
            // Success callback
            _view.stopWifiTimer();
            _view.successCallback(_wifiSuccessMsg, method(:makeRequest));
        } else {
            _view.startFailureTimer("Failed at Wifi");
        }
    }

    public function getUTCOffset() as Float {
        // Gets the UTC offset in seconds and converts it to hours offset
        return System.getClockTime().timeZoneOffset / 60.0 / 60.0;
    }

     //! Make the web request
    public function makeRequest() as Void {
        _view.setMessage("Making Request");
        _view.startRequestTimer();
        _view.resetColors();

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
        _view.stopRequestTimer();
        if (responseCode == 200) {
            // System.println(data);
            if (data instanceof Dictionary) {
                self.updateLabel(labelKeys[0], data["fajr"]);
                self.updateLabel(labelKeys[1], data["dhuhr"]);
                self.updateLabel(labelKeys[2], data["asr"]);
                self.updateLabel(labelKeys[3], data["maghrib"]);
                self.updateLabel(labelKeys[4], data["isha"]);
            }
            _view.successCallback("Times Updated", method(:returnToMenu));
            
            // Update view
        } else {
            // Update view
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

    function returnToMenu() as Void {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
    }

}