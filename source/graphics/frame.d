module guas.graphics.frame;

import raylib;

import std.stdio;

import guas.math.point;
import guas.math.rect;
import guas.graphics.terminal;
import guas.graphics.renderable;

class Frame : Renderable {
    Terminal _term;
    Rect bounds;
    Color _col;
    Color _fill;

    this(Terminal term, Rect bounds) {
        _term = term;
        this.bounds = bounds;
    }

    void outline(Color col) {
        _col = col;
    }

    void fill(Color col) {
        // fill buffer backgrounds with color
        for (int x = bounds.x; x < bounds.x + bounds.width; x++) {
            for (int y = bounds.y; y < bounds.y + bounds.height; y++) {
                _term.getBuffer()[_term.bufIndex(Point(x, y))].bg = col;
            }
        }
    }

    void render() {
        raylib.DrawRectangleLines(_term._bounds.x + bounds.x * _term.charSize().x, _term._bounds.y + bounds.y * _term.charSize().y,
           bounds.width * _term.charSize().x, bounds.height * _term.charSize().y, _col);
    }
}
