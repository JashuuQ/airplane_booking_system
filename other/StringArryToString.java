package other;

public class StringArryToString {
    
    public String toString(String[] str){
        StringBuffer buffer= new StringBuffer();
        
        for(int i=0;i<str.length;i++){
            buffer.append(str[i]);
        }
        
        return buffer.toString();
    }
}
