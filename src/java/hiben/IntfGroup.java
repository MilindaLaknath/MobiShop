package hiben;
// Generated Dec 20, 2015 7:01:48 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * IntfGroup generated by hbm2java
 */
public class IntfGroup  implements java.io.Serializable {


     private Integer idintfGroup;
     private String groupName;
     private Set<Interfaces> interfaceses = new HashSet<Interfaces>(0);
     private Set<Privilage> privilages = new HashSet<Privilage>(0);

    public IntfGroup() {
    }

    public IntfGroup(String groupName, Set<Interfaces> interfaceses, Set<Privilage> privilages) {
       this.groupName = groupName;
       this.interfaceses = interfaceses;
       this.privilages = privilages;
    }
   
    public Integer getIdintfGroup() {
        return this.idintfGroup;
    }
    
    public void setIdintfGroup(Integer idintfGroup) {
        this.idintfGroup = idintfGroup;
    }
    public String getGroupName() {
        return this.groupName;
    }
    
    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }
    public Set<Interfaces> getInterfaceses() {
        return this.interfaceses;
    }
    
    public void setInterfaceses(Set<Interfaces> interfaceses) {
        this.interfaceses = interfaceses;
    }
    public Set<Privilage> getPrivilages() {
        return this.privilages;
    }
    
    public void setPrivilages(Set<Privilage> privilages) {
        this.privilages = privilages;
    }




}

