import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Position;
import Toybox.Lang;

public var hasGPS = false as Boolean;

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
        // updateLabels();
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        dc.clear();
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        drawTitle(dc);
        drawTitleGraphic(dc);
        updateLabels(dc);
        if (hasGPS) {
            drawCircle(dc, Graphics.COLOR_GREEN);
        } else {
            drawCircle(dc, Graphics.COLOR_RED);
        }
        
        
        // Call the parent onUpdate function to redraw the layout
        // View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    function drawTitle(dc as Dc) {
        var x = dc.getWidth() * .2;
        var y = dc.getHeight() * .15;
        var text = WatchUi.loadResource(Rez.Strings.title);
        dc.drawText(x, y , Graphics.FONT_SMALL, text ,Graphics.TEXT_JUSTIFY_LEFT);
    }

    function drawTitleGraphic(dc as Dc) {
        var graphic = WatchUi.loadResource(Rez.Drawables.title_underline);
        var x = (dc.getWidth() - graphic.getWidth()) / 2;
        var y = dc.getHeight() * .25;
        
        System.println(graphic.getWidth());
        System.println(dc.getWidth());
        dc.drawBitmap(x, y , graphic);
    }

    //! Update all labels
    function updateLabels(dc as Dc) as Void {
        var width = dc.getWidth()/5;
        var height = dc.getHeight() * .32;
        var hInc = dc.getHeight() * .12;
        for (var i = 0; i < labelKeys.size(); i++) {
            // var label = labels[i];
            var prayerText = labelKeys[i];
            var timeText = dataObject.getValue(labelKeys[i]);
            var setText = prayerText + ": " + timeText;
            dc.drawText(width, height + (hInc * i), Graphics.FONT_SMALL, setText ,Graphics.TEXT_JUSTIFY_LEFT);
            // label.setText(prayerText + ": " + timeText);
        }
        WatchUi.requestUpdate();
    }

    //! Update a single label
    function updateLabel(key as Lang.String, updateValue) as Void {
        if (updateValue != null) {
            dataObject.updateValue(key, updateValue);
            WatchUi.requestUpdate();
        }
    }

    function drawCircle(dc as Dc, color as Graphics.ColorType) {
        dc.setColor(color, Graphics.COLOR_BLACK);
        dc.fillCircle(305, 70, 5);
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

        var position = info.position;
        if (position != null){
            hasGPS = true;
        } else {
            hasGPS = false;
        }
    }

}
