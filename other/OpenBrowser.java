package other;

import java.io.IOException;
public class OpenBrowser implements Runnable {
    public OpenBrowser(){
        run();
    }
    
    public void run() {
 
        String cmd = "cmd.exe /c start ";

        String file = "http://www.google.com";
        
        try {
            Runtime.getRuntime().exec(cmd + file);
        } catch (IOException ignore) {
            ignore.printStackTrace();
        }
    }
}

