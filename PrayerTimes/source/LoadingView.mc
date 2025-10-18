import Toybox.Timer;
import Toybox.WatchUi;
import Toybox.Graphics;


class LoadingView extends WatchUi.View {
    private var _gpsTimer as Timer.Timer?;
    private var _wifiTimer as Timer.Timer?;
    private var _requestTimer as Timer.Timer?;
    private var _statusMsg = "";
    private var _periods = "";
    private var _font = Graphics.FONT_SMALL;
    private var _just = Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER;
    private var _foreground = Graphics.COLOR_WHITE;
    private var _background = Graphics.COLOR_YELLOW;
    
    function initialize() {
        View.initialize();
        _gpsTimer = new Timer.Timer();
        _wifiTimer = new Timer.Timer();
        _requestTimer = new Timer.Timer();
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
        stopRequestTimer();
        resetColors();
    }

    function loadingStatus(dc as Dc) as Void {
        // Draw centered text
        dc.clear();
        var statusDimensions = dc.getTextDimensions(_statusMsg, _font);
        var statusX = (dc.getWidth() - statusDimensions[0] ) /2;
        var statusY = (dc.getHeight() / 2);
        dc.drawText(statusX, statusY, _font, _statusMsg, _just);

        var period_width = dc.getTextWidthInPixels(_periods, _font);
        var periodX = (dc.getWidth()- period_width) / 2;
        var periodY = (dc.getWidth() / 2) + statusDimensions[1] ;
        dc.drawText(periodX, periodY, _font, _periods, _just);
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
        resetColors();
        _gpsTimer.start(method(:addPeriod), 1000, true);
        requestUpdate();
    }

    function startWifiTimer() as Void {
        resetColors();
        _wifiTimer.start(method(:addPeriod), 1000, true);
        requestUpdate();
    }

    function startRequestTimer() as Void {
        resetColors();
        _requestTimer.start(method(:addPeriod), 1000, true);
        requestUpdate();
    }

    function stopGPSTimer() as Void {
        _gpsTimer.stop();
        clearPeriods();
        requestUpdate();
    }

    function stopWifiTimer() as Void {
        _wifiTimer.stop();
        clearPeriods();
        requestUpdate();
    }

    function stopRequestTimer() as Void {
        _requestTimer.stop();
        clearPeriods();
        requestUpdate();
    }

    function startFailureTimer(failureMsg as Toybox.Lang.String) as Void {
        setMessage(failureMsg);
        _background = Graphics.COLOR_RED;
        _foreground = Graphics.COLOR_BLACK;
        requestUpdate();

        var failureTimer = new Timer.Timer();
        failureTimer.start(method(:returnToMenu1), 1500, false);
        
    }

    function successCallback(succMsg as Toybox.Lang.String, methodCallback as Toybox.Lang.Method) as Void {
        setMessage(succMsg);
        successColors();
        requestUpdate();

        var successTimer = new Timer.Timer();
        successTimer.start(methodCallback, 1500, false);
        
    }

    function returnToMenu1() as Void {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
    }

    function successColors() as Void {
        _background = Graphics.COLOR_GREEN;
        _foreground = Graphics.COLOR_BLACK;
    }

    function resetColors() as Void {
        _foreground = Graphics.COLOR_WHITE;
        _background = Graphics.COLOR_YELLOW;
        requestUpdate();
    }
}