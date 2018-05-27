import gtk.Main;
import view.AppMainWindow;

void main(string[] args)
{
    Main.init(args);
    AppMainWindow win = new AppMainWindow("Tic Tac Toe");
    Main.run();
}