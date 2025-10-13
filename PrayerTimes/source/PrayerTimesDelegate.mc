import Toybox.Lang;
import Toybox.WatchUi;

class PrayerTimesDelegate extends WatchUi.BehaviorDelegate {

    var _view;
    var count = 0;

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

            // Increment the counter
            count += 1;

            // Update the label in the view with the current count
            // labelKeys[0] seems to be the label being updated
            _view.updateLabel(labelKeys[0], count);
        }

        // Always return true (event handled)
        return true;
    }

}