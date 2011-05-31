/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package games;

import java.util.Random;
import javax.ejb.Stateful;

/**
 *
 * @author: Alexandre Bourdin & Jeremy Gabriele
 */
@Stateful
public class PFC implements PFCLocal {
    

    public static final int MAX_GAMES = 3;
    private int nbVictories;
    private int nbGames;
    
    // O : Pierre, 1: Feuille, 2: Ciseaux
    
    @Override
    public boolean fight(int userChoice) {
        
        Random rand = new Random();
        int aiChoice = rand.nextInt(3);
        if((userChoice) == (aiChoice+1)%3){
            this.nbVictories++;
            this.nbGames++;
            return true;
        }
        this.nbGames++;
        return false;
    }
    
    @Override
    public boolean finished(){
        return (nbGames>=MAX_GAMES);
    }

    @Override
    public int getNbVictories(){
        return nbVictories;
    }

    @Override
    public int getNbGames(){
        return nbGames;
    }

    public int nbRemainingGames() {
        return MAX_GAMES - nbGames;
    }
    
    public void restart() {
        nbVictories = 0;
        nbGames = 0;
    }

    @Override
    public boolean winner() {
        return (nbVictories >= (MAX_GAMES+1)/2);
    }
    
    @Override
    public int stringToValue(String choice){
        
        if(choice.equals("rock"))
            return 0;
        if(choice.equals("paper"))
            return 1;
        if(choice.equals("scissors"))
            return 2;
        
        return -1;
    }

    
    
}
