import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Position;
import Toybox.Lang;
import Rez.Styles;

class PrayerTimesView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }


    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc)); // Necesary for bitmap loading ... for now
    }

    function onShow() as Void {
        
    }

    function onUpdate(dc as Dc) as Void {
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
        dc.drawText(x, y , Graphics.FONT_SMALL, text ,Graphics.TEXT_JUSTIFY_LEFT);
    }

    function drawTitleGraphic(dc as Dc) as Void{
        var graphic = WatchUi.loadResource(Rez.Drawables.title_underline);
        var x = (dc.getWidth() - graphic.getWidth()) / 2;
        var y = dc.getHeight() * .25;
        dc.drawBitmap(x, y , graphic);
    }

    // Draw all labels 
    function drawLabels(dc as Dc) as Void {
        var width = dc.getWidth()/5;
        var height = dc.getHeight() * .32;
        var hInc = dc.getHeight() * .12;
        for (var i = 0; i < labelKeys.size(); i++) {
            // var label = labels[i];
            var prayerText = labelKeys[i];
            var timeText = storageManager.getValue(labelKeys[i]);
            var setText = prayerText + ": " + timeText;
            dc.drawText(width, height + (hInc * i), Graphics.FONT_SMALL, setText ,Graphics.TEXT_JUSTIFY_LEFT);
            // label.setText(prayerText + ": " + timeText);
        }
        WatchUi.requestUpdate();
    }

    function drawCircle(dc as Dc, color as Graphics.ColorType) {
        dc.setColor(color, Graphics.COLOR_BLACK);
        dc.fillCircle(305, 70, 5);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
    }

}
