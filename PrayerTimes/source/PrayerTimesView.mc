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
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        drawTitle(dc);
        drawTitleGraphic(dc);
        drawLabels(dc);
        drawCircle(dc, circleColor);
        var hint = WatchUi.loadResource(Rez.Drawables.menuHint);
        dc.drawBitmap(0, dc.getHeight() / 2, hint);
        
        // View.onUpdate(dc); CALL IF USING layout.xml
    }

    function onHide() as Void {

    }

    function drawTitle(dc as Dc) {
        var x = dc.getWidth() * .2;
        var y = dc.getHeight() * .15;
        var text = WatchUi.loadResource(Rez.Strings.AppName);
        dc.drawText(x, y , Graphics.FONT_SMALL, text ,Graphics.TEXT_JUSTIFY_LEFT);
    }

    function drawTitleGraphic(dc as Dc) {
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
