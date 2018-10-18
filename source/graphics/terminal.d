module guas.graphics.terminal;

import std.string;
import std.format;
import raylib;
import raymath;

import guas.render;
import guas.math.point;
import guas.math.rect;

class Terminal {
    Renderer _renderer;
    Point _dimens;
    Rect _bounds;
    Point _cur;
    Color _col;
    TermChar[] _buf;

    struct TermChar {
        char ch;
        Color col;
    }

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
        _buf = new TermChar[_dimens.x * _dimens.y];
    }

    void render() {
        // TODO: do something useful
        enum int borderSize = 2;
        raylib.DrawRectangleLines(_bounds.x - borderSize, _bounds.y - borderSize,
            _bounds.width + borderSize, _bounds.height + borderSize,
            GetColor(0x158e15ff));

        // draw buffer
        for (int i = 0; i < _buf.length; i++) {
            auto cx = i % _dimens.y;
            auto cy = i / _dimens.x;
            _renderer.drawChar(_buf[i].ch,
                Vector2(_bounds.x + cx * _renderer._font.charSize, _bounds.y + cy * _renderer._font.charSize),
                _buf[i].col);
        }

        // draw cursor
        raylib.DrawRectangle(_bounds.x + _cur.x * _renderer._font.charSize, _bounds.y + _cur.y * _renderer._font.charSize,
           cast(int) ( _renderer._font.charSize * 0.7), _renderer._font.charSize, _col);

        setCursor(Point(0, 0));

        // _renderer.drawText("welcome to caustic", Vector2(_bounds.x, _bounds.y), _col);
        setColor(WHITE);
        print("guas ");
        setColor(GREEN);
        auto bips = ["/", "-", "\\", "|"];
        auto ch = bips[(_renderer._frame / 2) % 4];
        print(format("vterm engine: %s", ch));
    }

    void setCursor(Point pos) {
        _cur = pos;
    }

    void setColor(Color col) {
        _col = col;
    }

    void clear() {
        _cur = Point(0, 0);
        // TODO: clear buffer
    }

    void print(string text) {
        for (int i = 0; i < text.length; i++) {
            // auto cvpos = getCurVpos();
            // _renderer.drawChar(text[i],
            //     Vector2(_bounds.x + cvpos.x, _bounds.y + cvpos.y),
            //     _col);
            _buf[_cur.y * _dimens.x + _cur.x] = TermChar(text[i], _col);
            _cur.x += 1;
        }
    }

    pragma(inline):
    private Vector2 getCurVpos() {
        return Vector2(_cur.x * _renderer._font.charSize, _cur.y * _renderer._font.charSize);
    }
}