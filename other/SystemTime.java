package other;

import java.text.SimpleDateFormat;
import java.util.Date;

public class SystemTime {
    public static String systemTime1;
    public static String systemTime2;
    public SystemTime(){

    }
    public String systemInit1(){
        Date date = new Date(System.currentTimeMillis());
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
        systemTime1 = dateFormat.format(date);
        return systemTime1;
    }
    
    public String systemInit2(){
        Date date = new Date(System.currentTimeMillis());
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmm");
        systemTime2 = dateFormat.format(date);
        return systemTime2;
    }


}
