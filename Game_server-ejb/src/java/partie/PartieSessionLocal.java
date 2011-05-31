/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package partie;

import java.util.List;
import javax.ejb.Local;
import persistence.Gamer;

/**
 *
 * @author: Alexandre Bourdin & Jeremy Gabriele
 */

@Local
public interface PartieSessionLocal {
    
    public Gamer searchForGamer(String id);
    
    public void remove(Object obj);
    
    public void persist(Object obj);
    
    public List findAllGamers();
    
    public List findAllConnectedGamers();
    
    public Gamer findGamerByLoginAndPassword(String log, String pass);
}
