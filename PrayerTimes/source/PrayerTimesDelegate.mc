import Toybox.Lang;
import Toybox.WatchUi;
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
            // self.makeRequest();
            _view.requestUpdate();
            System.println("reuested update");
        }

        // Always return true (event handled)
        return true;
    }

    public function getUTCOffset() as Number {
        return System.getClockTime().timeZoneOffset / 60 / 60;
    }

    //! Make the web request
    private function makeRequest() as Void {
        var url = "https://prayer-api-kappa.vercel.app/praytime";
        var params = {
            "lat" => 39.353007,
            "lon" => -74.463422,
            "utcOffset" => -4
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
            System.println(data);
            // Update view
        } else {
            // Update view
        }
    }

}