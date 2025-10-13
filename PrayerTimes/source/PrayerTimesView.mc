import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Position;
import Toybox.Lang;

class PrayerTimesView extends WatchUi.View {

    public var labelFajr;
    public var labelDhujr;
    public var labelAsr;
    public var labelMagrib;
    public var labelIsha;
    public var counter = 0;
    public var labels as Lang.Array<WatchUi.Text>;

    function initialize() {
        View.initialize();

        labels = new Lang.Array<WatchUi.Text>[5];
        labels[0] = labelFajr;
        labels[1] = labelDhujr;
        labels[2] = labelAsr;
        labels[3] = labelMagrib;
        labels[4] = labelIsha;
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));

        for (var i = 0; i < labelKeys.size(); i++) {
            labels[i] = findDrawableById(labelKeys[i]) as WatchUi.Text;
        }
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        updateLabels();
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        updateLabels();
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    //! Update all labels
    function updateLabels() as Void {
        for (var i = 0; i < labelKeys.size(); i++) {
            var label = labels[i];
            var prayerText = labelKeys[i];
            var timeText = dataObject.getValue(labelKeys[i]);
            System.println(prayerText);
            System.println(timeText);
            label.setText(prayerText + ": " + timeText);
        }
    }

    //! Update a single label
    function updateLabel(key as Lang.String, updateValue) as Void {
        if (updateValue != null) {
            dataObject.updateValue(key, updateValue);
            WatchUi.requestUpdate();
        }
    }

        //! Update position and compute prayer times
    public function setPosition(info as Info) as Void {
        // var now = Time.now();

        // calc.setPosition(info);

        // System.println(calc.posInfo);

        // var times = calc.computePrayerTimes(now);

        // if (times != null && times instanceof Dictionary) {
        //     updateLabel(labelKeys[0], times[:fajr]);
        //     updateLabel(labelKeys[1], times[:dhuhr]);
        //     updateLabel(labelKeys[2], times[:asr]);
        //     updateLabel(labelKeys[3], times[:maghrib]);
        //     updateLabel(labelKeys[4], times[:isha]);
        // }
    }

}
