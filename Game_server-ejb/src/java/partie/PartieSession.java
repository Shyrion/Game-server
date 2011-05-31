/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package partie;

import java.util.List;
import javax.ejb.Stateful;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.persistence.*;
import persistence.Gamer;

/**
 *
 * @author: Alexandre Bourdin & Jeremy Gabriele
 */

@Stateful()
@TransactionManagement(value=TransactionManagementType.CONTAINER)
public class PartieSession implements PartieSessionLocal {
    
    @javax.persistence.PersistenceContext(type=PersistenceContextType.TRANSACTION, unitName="GS_persistence")
    private EntityManager em ;
    
    
    public PartieSession(){
        
    }

    @Override
    public Gamer searchForGamer(String id){
        
        Gamer gamer = (Gamer)em.find(Gamer.class, id);
        return gamer;
    }
    
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    @Override
    public void remove(Object obj){
        Object mergedObj = em.merge(obj);
        em.remove(mergedObj);
    }
    
    @Override
    public void persist(Object obj){
        em.persist(obj);
    }
    
    @Override
    public Gamer findGamerByLoginAndPassword(String login, String password){
        Gamer gamer=null;
        List res = em.createNamedQuery("findGamerByLogin").setParameter("login", login).setParameter("password", password).getResultList();
        gamer = (Gamer) res.get(0);
        return gamer;
    }
    
    @Override
    public List findAllConnectedGamers(){
        List res = em.createNamedQuery("findAllConnectedGamers").getResultList();
        return res;
    }
    
    @Override
    public List findAllGamers(){
    
        List gamers = em.createNamedQuery("findAllGamers").getResultList();
        return gamers;
        
    }
    
    /*
    public List findCustomerByFirstName(String firstName){
        List customers = em.createNamedQuery("findCustomerByFirstName").setParameter("firstName", firstName).getResultList();
        return customers;
    }
    
    public List findCustomerByLastName(String lastName){
        List customers = em.createNamedQuery("findCustomerByLastName").setParameter("lastName", lastName).getResultList();
        return customers;
    }

    public List findAllCustomer(){
        List customers = em.createNamedQuery("findAllCustomer").getResultList();
        return customers;
    }
     */

}
