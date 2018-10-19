module guas.render;

import std.stdio;
import std.container.array;
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
    Terminal[] _terms;
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

    void render() {
        raylib.ClearBackground(_clearColor);
        _frame++;

        foreach (Terminal term; _terms) {
            term.render();
        }
    }

    void addTerminal(Terminal term, Vector2 pos = Vector2(0, 0)) {
        _terms ~= term;
        term._offset = pos;
        term.updateBounds();
    }

    void drawChar(TermFont font, ubyte charId, Vector2 pos, Color color = WHITE) {
        auto fontX = charId % font.gridSize;
        auto fontY = charId / font.gridSize;
        raylib.DrawTextureRec(font.texture,
            Rectangle(fontX * font.charWidth, fontY * font.charHeight, font.charWidth, font.charHeight),
            pos, color);
    }

    void drawText(TermFont font, string text, Vector2 pos, Color color = WHITE, float spacing = 1) {
        Vector2 offset = Vector2(0, 0);
        for (int i = 0; i < text.length; i++) {
            drawChar(font, text[i], Vector2Add(pos, offset), color);
            offset = Vector2Add(offset, Vector2(cast(int) (font.charWidth * spacing), 0));
        }
    }
}
