import Toybox.Position;
import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Time;

class PrayerTimesDelegate extends WatchUi.BehaviorDelegate {
    
    var _view;
    var count = 0;

    var responseKeys = ["fajr", "dhuhr", "asr", "maghrib", "isha"];

    function initialize(view as PrayerTimesView) {
        _view = view;
        BehaviorDelegate.initialize();
    }

    // function onMenu() as Boolean {
    //     // WatchUi.pushView(new Rez.Menus.MainMenu(), new PrayerTimesMenuDelegate(), WatchUi.SLIDE_UP);
    //     return true;
    // }

    function onKeyPressed(keyEvent as KeyEvent) as Boolean {
        // If the key pressed is the ENTER key
        if (keyEvent.getKey() == KEY_ENTER) {
            // self.getUTCOffset();
            if (hasGPS) {
                self.makeRequest();
            }
            // count += 1;
            // _view.updateLabel(labelKeys[0], count);
            // _view.requestUpdate();
            
        }

        // Always return true (event handled)
        return true;
    }

    function onMenu() as Boolean {
        _view.circleColor = Graphics.COLOR_YELLOW;
        Position.enableLocationEvents(Position.LOCATION_ONE_SHOT, method(:onPosition));
        return true;
    }

    public function onPosition(info as Info) as Void {
       
        _view.setPosition(info);
    }

    public function getUTCOffset() as Number {
        return System.getClockTime().timeZoneOffset / 60 / 60;
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
                _view.updateLabel(labelKeys[0], data["fajr"]);
                _view.updateLabel(labelKeys[1], data["dhuhr"]);
                _view.updateLabel(labelKeys[2], data["asr"]);
                _view.updateLabel(labelKeys[3], data["maghrib"]);
                _view.updateLabel(labelKeys[4], data["isha"]);
            }
            
            // Update view
        } else {
            // Update view
        }
    }

}