module guas.samp.welcometerm;

import raylib;

import guas.render;
import guas.math.point;
import guas.math.rect;
import guas.graphics.terminal;
import guas.graphics.frame;

class WelcomeTerminal : Terminal {
    this(Renderer renderer, Point dimens) {
        super(renderer, dimens);
    }

    override void update() {
        if (_renderer._frame == 0) {
            this.setColor(WHITE);
            this.setCursor(Point(0, 0));
            this.setColor(WHITE);
            this.print("guas ");
            this.setColor(GRAY);
            this.print("vterm ");
            this.setColor(GREEN);
            this.print("[engine]");
            Frame frame = new Frame(this, Rect(0, 10, 16, 8));
            frame.outline(GREEN);
            this._frames.insertBack(frame);
            this.setCursor(Point(0, 10));
            this.print("frames.");
        }
        if (_renderer._frame == Renderer.framerate * 3) {
            this.setCursor(Point(0, 2));
            this.setColor(RED);
            this.print("---- transmission ----\n");
            this.setColor(GRAY);
            // yay douglas adams
            this.print("Curiously enough, the only thing that went through the mind of the bowl of petunias as it fell was Oh no, not again. Many people have speculated that if we knew exactly why the bowl of petunias had thought that we would know a lot more about the nature of the universe than we do now.");
        }
    }
}
