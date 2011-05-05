/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package partie;

import javax.ejb.Stateful;

/**
 *
 * @author shyrion
 */
@Stateful
public class PartieSession implements PartieSessionRemote {
    
    public String getResult() {
        return "This is My Session Bean";
    }

}
