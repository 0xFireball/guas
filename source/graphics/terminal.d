module guas.graphics.terminal;

import std.string;
import std.math;
import std.container.array;
import raylib;
import raymath;

import guas.render;
import guas.graphics.frame;
import guas.math.point;
import guas.math.rect;

class Terminal {
    Renderer _renderer;
    Point _dimens;
    Rect _bounds;
    Point _cur;
    Color _col;
    Color _bg;
    TermChar[] _buf;
    Array!Frame _frames;

    struct TermChar {
        char ch;
        Color col;
        Color bg;
    }

    this(Renderer renderer, Point dimens) {
        _renderer = renderer;
        _dimens = dimens;
    }

    pragma(inline):
    Point charSize() { return Point(_renderer._font.charWidth, _renderer._font.charHeight); }

    /// initializes graphics for the terminal
    void init() {
        // draw centered terminal outline
        Point size = Point(_dimens.x * _renderer._font.charWidth, _dimens.y * _renderer._font.charHeight);
        _bounds = Rect(
            cast(int) (_renderer._size.x / 2f - size.x / 2f),
            cast(int) (_renderer._size.y / 2f - size.y / 2f),
            size.x,
            size.y
        );
        _buf = new TermChar[_dimens.x * _dimens.y];
        _frames = Array!Frame();
    }

    void render() {
        // TODO: do something useful
        enum int borderSize = 2;
        raylib.DrawRectangleLines(_bounds.x - borderSize, _bounds.y - borderSize,
            _bounds.width + borderSize, _bounds.height + borderSize,
            GetColor(0x158e15ff));

        // draw buffer
        for (int i = 0; i < _buf.length; i++) {
            auto cx = i % _dimens.x;
            auto cy = i / _dimens.x;
            raylib.DrawRectangle(_bounds.x + cx * _renderer._font.charWidth, _bounds.y + cy * _renderer._font.charHeight,
                _renderer._font.charWidth, _renderer._font.charHeight, _buf[i].bg);
            _renderer.drawChar(_buf[i].ch,
                Vector2(_bounds.x + cx * _renderer._font.charWidth, _bounds.y + cy * _renderer._font.charHeight),
                _buf[i].col);
        }

        // draw cursor
        auto cursorCol = _col;
        cursorCol.a = cast(ubyte) (128 + 127 * sin(_renderer._frame / 5f));
        raylib.DrawRectangle(_bounds.x + _cur.x * _renderer._font.charWidth, _bounds.y + _cur.y * _renderer._font.charHeight,
           cast(int) (_renderer._font.charWidth * 0.9), _renderer._font.charHeight, cursorCol);

        // draw frames
        foreach (Frame f; _frames) {
            f.render();
        }
    }

    void update() { /* TODO */ }

    void setCursor(Point pos) {
        _cur = pos;
    }

    void setColor(Color col) {
        _col = col;
    }

    void setBg(Color col) {
        _bg = col;
    }

    void clear() {
        _cur = Point(0, 0);
        // clear buffer
        for (int i = 0; i < _buf.length; i++) {
            _buf[i] = TermChar(0, _col, _bg);
        }
    }

    void print(string text) {
        for (int i = 0; i < text.length; i++) {
            // auto cvpos = getCurVpos();
            // _renderer.drawChar(text[i],
            //     Vector2(_bounds.x + cvpos.x, _bounds.y + cvpos.y),
            //     _col);
            _buf[_cur.y * _dimens.x + _cur.x] = TermChar(text[i], _col, _bg);
            // special characters
            switch (text[i]) {
                default:
                    _cur.x += 1;
                    break;
                case '\n':
                    _cur.x = 0;
                    _cur.y += 1;
                    break;
            }
            // wrap
            if (_cur.x > _dimens.x) {
                _cur.y += 1;
                _cur.x -= _dimens.x;
            }
        }
    }

    pragma(inline):
    private Vector2 getCurVpos() {
        return Vector2(_cur.x * _renderer._font.charWidth, _cur.y * _renderer._font.charHeight);
    }
}
