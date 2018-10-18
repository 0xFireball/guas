module guas.graphics.frame;

import raylib;

import guas.math.point;
import guas.math.rect;
import guas.graphics.terminal;
import guas.graphics.renderable;

class Frame : Renderable {
    Terminal _term;
    Rect bounds;
    Color _col;

    this(Terminal term, Rect bounds) {
        _term = term;
        this.bounds = bounds;
    }

    void outline(Color col) {
        _col = col;
    }

    void render() {
        // TODO
        raylib.DrawRectangleLines(_term._bounds.x + bounds.x * _term.fontSize(), _term._bounds.y + bounds.y * _term.fontSize(),
           bounds.width * _term.fontSize(), bounds.height * _term.fontSize(), _col);
    }
}
