module guas.samp.demorogterm;

import std.stdio;
import raylib;

import guas.render;
import guas.math.point;
import guas.math.rect;
import guas.graphics.terminal;
import guas.graphics.frame;

class DemoRogTerm : Terminal {
    int _counter = 0;
    Point mapSize;
    int[] map;
    Point playerPos;

    this(Renderer renderer) {
        super(renderer, Point(90, 46));
        mapSize = Point(20, 20);
        map = new int[mapSize.x * mapSize.y];
        map = [
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
            0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1,
            0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1,
            0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 1,
            0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1,
            0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 1,
            0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 1,
            0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 1,
            0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1,
            0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 1,
            0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1,
            0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
        ];
        playerPos = Point(7, 8);
    }

    override void update() {
        if (_renderer._frame == 0) {
            drawSidebar();
            drawField();
        }

        // print field
        this.setCursor(Point(0, 0));

        // draw the field
        for (int y = 0; y < mapSize.y; y++) {
            for (int x = 0; x < mapSize.x; x++) {
                this.setColor(GREEN);
                this.setBg(BLACK);
                int dch = map[y * mapSize.x + x];
                switch (dch) {
                    case 0:
                        this.print(".");
                        break;
                    case 1:
                        this.print("\xDB");
                        break;
                    default:
                        this.print("?");
                        break;
                }
            }
            print("\n");
        }

        // draw the player
        this.setCursor(playerPos);
        this.print("@");
    }

    private void drawSidebar() {
        Frame sidebar = new Frame(this, Rect(74, 0, 16, this._dimens.y));
        sidebar.outline(GRAY);
        sidebar.fill(GRAY);
        this.addFrame(sidebar);

        this.setCursor(Point(sidebar.bounds.x, sidebar.bounds.y));
        this.setColor(GREEN);
        this.setBg(BLUE);
        this.print("fake rogue.\xDB\n");
        this.setBg(GRAY);
        this._cur.x = 74;
        this.print("HP: [14 / 15]\n");
        this._cur.x = 74;
        this.print("STR: 8\n");
        this._cur.x = 74;
        this.print("INT: 12\n");
        this._cur.x = 74;
        this.print("PER: 10\n");
        this._cur.x = 74;
        this.print("DEX: 9\n");
    }

    private void drawField() {
        // draw screen
        Frame field = new Frame(this, Rect(0, 0, 74, this._dimens.y));
        field.outline(GREEN);
        field.fill(BLACK);
        this.addFrame(field);
    }
}
