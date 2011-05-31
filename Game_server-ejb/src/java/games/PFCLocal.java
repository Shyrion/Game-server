/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package games;

import javax.ejb.Local;

/**
 *
 * @author: Alexandre Bourdin & Jeremy Gabriele
 */
@Local
public interface PFCLocal {

    boolean fight(int userChoice);
    
    boolean finished();
    
    int getNbVictories();
    
    int getNbGames();
    
    boolean winner();
    
    int stringToValue(String choice);

    int nbRemainingGames();

    void restart();
    
}
