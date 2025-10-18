import Toybox.Timer;
import Toybox.WatchUi;
import Toybox.Graphics;


class LoadingView extends WatchUi.View {
    private var _gpsTimer as Timer.Timer?;
    private var _wifiTimer as Timer.Timer?;
    private var _statusMsg = "";
    private var _periods = "";
    private var _font = Graphics.FONT_SMALL;
    private var _just = Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER;
    private var _foreground = Graphics.COLOR_WHITE;
    private var _background = Graphics.COLOR_BLACK;
    
    function initialize() {
        View.initialize();
        _gpsTimer = new Timer.Timer();
        _wifiTimer = new Timer.Timer();
    }

    function onLayout(dc as Dc) as Void {
        
    }

    function onShow() as Void {

    }

    function onUpdate(dc as Dc) as Void {
        dc.clear();
        dc.clearClip();
        dc.setColor(_foreground, _background);
        loadingStatus(dc);
    }

    function onHide() as Void {
        stopGPSTimer();
        stopWifiTimer();
        _background = Graphics.COLOR_BLACK;
        _foreground = Graphics.COLOR_WHITE;
    }

    function loadingStatus(dc as Dc) as Void {
        // Draw centered text
        var text = _statusMsg + _periods;
        var textWidth = dc.getTextWidthInPixels(text, _font);
        var x = (dc.getWidth() - textWidth ) /2;
        var y = (dc.getHeight() / 2);
        dc.drawText(x, y, _font, text, _just);
    }

    function addPeriod() as Void {
        var size = _periods.toCharArray().size();
        if (size > 2) {
            _periods = "";
        } else {
            _periods = _periods +  ".";
        }
        requestUpdate();
    }

    function setMessage(text as Toybox.Lang.String) as Void {
        _statusMsg = text;
    }

    function clearPeriods() as Void {
        _periods = "";
    }

    function startGPSTimer() as Void {
        System.println(_gpsTimer instanceof Timer.Timer);
        _gpsTimer.start(method(:addPeriod), 1000, true);
    }

    function startWifiTimer() as Void {
        _wifiTimer.start(method(:addPeriod), 1000, true);
        _background = Graphics.COLOR_BLACK;
        _foreground = Graphics.COLOR_WHITE;
    }

    function stopGPSTimer() as Void {
        _gpsTimer.stop();
        clearPeriods();
    }

    function stopWifiTimer() as Void {
        _wifiTimer.stop();
        clearPeriods();
    }

    function startFailureTimer(failureMsg as Toybox.Lang.String) as Void {
        setMessage(failureMsg);
        _background = Graphics.COLOR_RED;
        _foreground = Graphics.COLOR_BLACK;

        var failureTimer = new Timer.Timer();
        failureTimer.start(method(:returnToMenu1), 1500, false);

        requestUpdate();
    }

    function successCallback(succMsg as Toybox.Lang.String, methodCallback as Toybox.Lang.Method) as Void {
        setMessage(succMsg);
        _background = Graphics.COLOR_DK_GREEN;
        _foreground = Graphics.COLOR_BLACK;

        var successTimer = new Timer.Timer();
        successTimer.start(methodCallback, 1500, false);
        requestUpdate();
    }

    function returnToMenu1() as Void {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
    }

    function resetColors() as Void {
        _background = Graphics.COLOR_BLACK;
        _foreground = Graphics.COLOR_WHITE;
        requestUpdate();
    }

    function startRequest() as Void {
        
    }

}