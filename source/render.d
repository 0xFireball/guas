module guas.render;

import std.stdio;
import std.string : fromStringz;
import raylib;

import guas.game.world;
import guas.resources;

class Renderer {
    World _world;
    Color _clearColor;
    Texture2D _font;

    this(World world) {
        _world = world;
        _clearColor = Color(240, 240, 240);
    }

    /// load resources
    void load() {
        // auto image = raylib.LoadImage(Resources.path(R_FONT));
        auto tex2 = raylib.LoadTexture(Resources.path(R_FONT));
    }

    void render() {
        raylib.ClearBackground(_clearColor);
    }
}
