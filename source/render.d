module guas.render;

import std.stdio;
import std.string : fromStringz;
import raylib;
import raymath;

import guas.game.world;
import guas.graphics.termfont;
import guas.resources;

class Renderer {
    World _world;
    Color _clearColor;
    TermFont _font;

    this(World world) {
        _world = world;
        // _clearColor = Color(240, 240, 240);
        _clearColor = Color(20, 20, 20);
    }

    /// load resources
    void load() {
        _font = TermFont(
            raylib.LoadTexture(Resources.path(R_FONT)),
            16, 12
        );
    }

    void render() {
        raylib.ClearBackground(_clearColor);
        drawChar('e', Vector2(100, 100));
        drawText("hello, world!", Vector2(100, 120));
    }

    void drawChar(char charId, Vector2 pos) {
        auto fontX = charId % _font.gridSize;
        auto fontY = charId / _font.gridSize;
        raylib.DrawTextureRec(_font.texture,
            Rectangle(fontX * _font.charSize, fontY * _font.charSize, _font.charSize, _font.charSize),
            pos, WHITE);
    }

    void drawText(string text, Vector2 pos, float spacing = 1) {
        Vector2 offset = Vector2(0, 0);
        for (int i = 0; i < text.length; i++) {
            drawChar(text[i], Vector2Add(pos, offset));
            offset = Vector2Add(offset, Vector2(cast(int) (_font.charSize * spacing), 0));
        }
    }
}
