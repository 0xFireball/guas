module guas.graphics.terminal;

import raylib;

import guas.render;
import guas.math.point;
import guas.math.rect;

class Terminal {
    Renderer _renderer;
    Point _dimens;
    Rect _bounds;

    this(Renderer renderer, Point dimens) {
        _renderer = renderer;
        _dimens = dimens;
    }

    /// initializes graphics for the terminal
    void init() {
        // draw centered terminal outline
        Point size = Point(_dimens.x * _renderer._font.charSize, _dimens.y * _renderer._font.charSize);
        _bounds = Rect(
            cast(int) (_renderer._size.x / 2f - size.x / 2f),
            cast(int) (_renderer._size.y / 2f - size.y / 2f),
            size.x,
            size.y
        );
    }

    void render() {
        // TODO: do something useful
        enum int borderSize = 2;
        raylib.DrawRectangle(_bounds.x - borderSize, _bounds.y - borderSize,
            _bounds.width + borderSize, _bounds.height + borderSize,
            Color(20, 160, 20));
    }
}
