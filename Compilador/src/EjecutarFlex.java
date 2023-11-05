



import java.util.logging.Level;
import java.util.logging.Logger;

import jflex.exceptions.SilentExit;

/**
 *
 * @author danilsa
 */
public class EjecutarFlex {
    public static void main(String[] args) {
        String lexFile = System.getProperty("user.dir") + "/src/Lex.flex";
        String lexColor = System.getProperty("user.dir") + "/src/Colors.flex";
        
        try {
            jflex.Main.generate(new String[]{lexFile, lexColor});
        } catch (SilentExit ex) {
            Logger.getLogger(EjecutarFlex.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
}
