import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Position;
import Toybox.Lang;
import Rez.Styles;

class PrayerTimesView extends WatchUi.View {

    private var _font = Graphics.FONT_SYSTEM_TINY;
    private var _just = Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER;
    private var _addSpace = 40;
    private var _timesSpacer = "·";

    function initialize() {
        View.initialize();
    }


    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc)); // Necesary for bitmap loading ... for now
    }

    function onShow() as Void {
        
    }

    function onUpdate(dc as Dc) as Void {
        // System.println(dc.getTextWidthInPixels(" ", _font));
        // System.println((dc.getTextWidthInPixels("Maghrib", _font) - dc.getTextWidthInPixels("Fajr", _font)) % 8);
        // System.println((dc.getTextWidthInPixels("Maghrib", _font) - dc.getTextWidthInPixels("Dhuhr", _font)) % 8);
        // System.println((dc.getTextWidthInPixels("Maghrib", _font) - dc.getTextWidthInPixels("Asr", _font)) % 8);
        // System.println((dc.getTextWidthInPixels("Maghrib", _font) - dc.getTextWidthInPixels("Isha", _font)) % 8);
        
        dc.clear();
        dc.clearClip();
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        drawMenuHint(dc);
        drawTitle(dc);
        drawTitleGraphic(dc);
        drawLabels(dc);
        
        
        // View.onUpdate(dc);  CALL IF USING layout.xml
    }

    function onHide() as Void {

    }

    function drawMenuHint(dc as Dc) as Void {
        var hint = WatchUi.loadResource(Rez.Drawables.menuHint);
        var x = Rez.Styles.system_loc__hint_button_left_middle.x;
        var y = Rez.Styles.system_loc__hint_button_left_middle.y;
        dc.drawBitmap(x, y, hint);

    }

    function drawTitle(dc as Dc) as Void {
        var x = dc.getWidth() * .2;
        var y = dc.getHeight() * .15;
        var text = WatchUi.loadResource(Rez.Strings.AppName);
        dc.drawText(x, y , Graphics.FONT_SYSTEM_SMALL, text ,Graphics.TEXT_JUSTIFY_LEFT);
    }

    function drawTitleGraphic(dc as Dc) as Void{
        var graphic = WatchUi.loadResource(Rez.Drawables.title_underline);
        var x = (dc.getWidth() - graphic.getWidth()) / 2;
        var y = dc.getHeight() * .25;
        dc.drawBitmap(x, y , graphic);
    }

    // Draw all labels 
    function drawLabels(dc as Dc) as Void {
        var prayerNameX = dc.getWidth() / 5.4;
        var prayerNameY = dc.getHeight() * .37;
        var hInc = dc.getHeight() * .11;
        var timeX = prayerNameX + dc.getTextWidthInPixels("Maghrib", _font) + _addSpace;

        for (var i = 0; i < labelKeys.size(); i++) {
            var prayerText = labelKeys[i];
            var calcY = prayerNameY + (hInc * i);
            var timeText = storageManager.getValue(labelKeys[i]);
            // For time formatting
            var dashes = "";
            var dashesNum = (dc.getTextWidthInPixels("Maghrib", _font) + _addSpace - dc.getTextWidthInPixels(prayerText, _font)) / dc.getTextWidthInPixels(_timesSpacer, _font);
            for (var j = 0; j < dashesNum; j++) {
                dashes += _timesSpacer;
            }
            if (timeText.compareTo(default_time) != 0 && storageManager.getValue(formatAsHour12Key)) {
                timeText = self.to12Hour(timeText);
            }
            var setText = prayerText + dashes;
            dc.drawText(prayerNameX, calcY, _font, setText, _just);
            dc.drawText(timeX, calcY, _font, timeText, _just);
        }
    }
    
    function to12Hour(timeStr as String) as String {
        var result = "";
        var am = " AM";
        var pm = " PM";
        var charArr = timeStr.toCharArray();
        var hour = (charArr[0] + charArr[1]).toNumber();
        var minutes = (charArr[3] + charArr[4]);
        if (hour < 12) {
            result = ":" + minutes + am;
        } else if (hour >= 12){
            result = ":" + minutes + pm;
        }
        hour = 1 + (hour + 11) % 12;
        var hourStr = hour.toString();
        if (hour < 10) {
            hourStr = "0" + hourStr;
        }
        result = hourStr + result;

        return result;
    }
    // function drawCircle(dc as Dc, color as Graphics.ColorType) {
    //     dc.setColor(color, Graphics.COLOR_BLACK);
    //     dc.fillCircle(305, 70, 5);
    //     dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
    // }

}
