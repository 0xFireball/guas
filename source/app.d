module guas.app;

import std.stdio;
import std.format;
import std.process;
import raylib;

import guas.meta;
import guas.render;
import guas.resources;
import guas.math.point;
import guas.graphics.terminal;

import guas.samp.demorog;

void main() {
	writefln("guas [engine] v%s", VERSION);

    auto renderer = new Renderer(Point(800, 600));

    // TODO: read an engine configuration file for resolution, etc.

    // resources
    Resources.setPath("res/");

    renderer.init();
    renderer.load();

    auto demo = new DemoRog(renderer);
    demo.init();

    while (!raylib.WindowShouldClose()) {
        demo.update();

        raylib.BeginDrawing();
        renderer.render();
        raylib.EndDrawing();
    }
}
