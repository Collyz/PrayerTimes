import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;

class PrayerTimesDelegate extends WatchUi.BehaviorDelegate {    

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        var settingsMenu = new $.SettingsCustomMenu(60, Graphics.COLOR_BLACK,{
                :focusItemHeight => 45,
                :title => new $.DrawableMenuTitle(Rez.Strings.SettingsTitle),
                :setTitleItemHeight => 80
            });
        settingsMenu.addItem(new $.SettingsCustomMenuItem(:getTimes, Rez.Strings.GetTimes, Graphics.COLOR_WHITE));
        settingsMenu.addItem(new $.SettingsCustomMenuItem(:set24, Rez.Strings.Set24,  Graphics.COLOR_WHITE));
        settingsMenu.addItem(new $.SettingsCustomMenuItem(:set12, Rez.Strings.Set12,  Graphics.COLOR_WHITE));
        settingsMenu.addItem(new $.SettingsCustomMenuItem(:clearTimes, Rez.Strings.ClearTimes, Graphics.COLOR_WHITE));
        WatchUi.pushView(settingsMenu, new $.SettingsMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}

class SettingsCustomMenu extends WatchUi.CustomMenu {
    public function initialize(itemHeight as Number, backgroundColor as ColorType, options as Dictionary) {
        CustomMenu.initialize(itemHeight, backgroundColor, options);
    }
}


class SettingsCustomMenuItem extends WatchUi.CustomMenuItem {
    private var _text as String;
    private var _textColor as ColorValue;

    public function initialize(id as Symbol, label as ResourceId, textColor as ColorValue) {
        CustomMenuItem.initialize(id, {});
        self._text = WatchUi.loadResource(label);
        self._textColor = textColor;
    }

    public function draw(dc as Dc) as Void {
        var font = Graphics.FONT_TINY;
        var textX = dc.getWidth() / 2;
        var textY = dc.getHeight() / 2;

        if (isFocused()) {
            font = Graphics.FONT_MEDIUM;
        }
        if (isSelected()) {
            dc.setColor(Graphics.COLOR_DK_BLUE, Graphics.COLOR_DK_BLUE);
            dc.clear();
        }
        
        dc.setColor(_textColor, Graphics.COLOR_TRANSPARENT);
        dc.drawText(textX, textY, font, _text, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }
    
}

class DrawableMenuTitle extends WatchUi.Drawable {
    private var _text = "";
    
    public function initialize(textResource as ResourceId) {
        Drawable.initialize({});
        self._text = WatchUi.loadResource(textResource);
    }

    public function draw(dc as Dc) as Void {
        var titleText = _text;
        var fontSize = Graphics.FONT_LARGE;
        var titleWidth = dc.getTextWidthInPixels(titleText, fontSize);
        var titleX = (dc.getWidth() - titleWidth) / 2;
        var titleY = dc.getHeight() / 2;

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(titleX, titleY, fontSize, titleText, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
    }
}