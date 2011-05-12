/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package partie;

import java.util.List;
import javax.ejb.Remote;
import persistence.Gamer;

/**
 *
 * @author shyrion
 */

@Remote
public interface PartieSessionRemote {
    
    public Gamer searchForGamer(String id);
    
    public void remove(Object obj);
    
    public void persist(Object obj);
    
    public List findAllGamers();
}
