/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package persistence;

import java.io.Serializable;
import javax.persistence.*;

/**
 *
 * @author shyrion
 */
@Entity

@NamedQueries(
    value={
        @NamedQuery(name="findGamerByLoginAndPassword", query="select object(c) from Gamer c where c.login = :login AND c.password = :password"),
        @NamedQuery(name="findAllGamers", query="SELECT object(c) FROM Gamer c")
    })

public class Gamer implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private String login;
    private String pwd;
    private int score;

    public Gamer() {
    }
    
    public Gamer(String login, String pwd){
        this.login = login;
        this.pwd = pwd;
        this.score = 0;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
    
    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }
    
    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }
    
    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }
    
    public void incScore(int inc){
        this.score += inc;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Gamer)) {
            return false;
        }
        Gamer other = (Gamer) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "persistence.Gamer[id=" + id + "]";
    }

}
