module guas.render;

import std.stdio;
import std.string : fromStringz;
import raylib;
import raymath;

import guas.graphics.termfont;
import guas.graphics.terminal;
import guas.resources;
import guas.math.point;

class Renderer {
    Color _clearColor;
    Point _size;
    TermFont _font;
    Terminal _term;
    enum int framerate = 30;
    int _frame = 0;

    this(Point size) {
        // _clearColor = Color(240, 240, 240);
        _clearColor = Color(20, 20, 20);
        _size = size;
    }

    /// initialize graphics context
    void init() {
        raylib.InitWindow(_size.x, _size.y, "guas");
        raylib.SetTargetFPS(framerate);
    }

    /// load resources
    void load() {
        _font = TermFont(
            raylib.LoadTexture(Resources.path(R_FONT)),
            16, 12, 12
        );
    }

    void render() {
        raylib.ClearBackground(_clearColor);
        _frame++;

        if (_term !is null) {
            _term.render();
        }
    }

    void setTerminal(Terminal term) {
        _term = term;
    }

    void drawChar(char charId, Vector2 pos, Color color = WHITE) {
        auto fontX = charId % _font.gridSize;
        auto fontY = charId / _font.gridSize;
        raylib.DrawTextureRec(_font.texture,
            Rectangle(fontX * _font.charWidth, fontY * _font.charHeight, _font.charWidth, _font.charHeight),
            pos, color);
    }

    void drawText(string text, Vector2 pos, Color color = WHITE, float spacing = 1) {
        Vector2 offset = Vector2(0, 0);
        for (int i = 0; i < text.length; i++) {
            drawChar(text[i], Vector2Add(pos, offset), color);
            offset = Vector2Add(offset, Vector2(cast(int) (_font.charWidth * spacing), 0));
        }
    }
}
