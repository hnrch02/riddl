//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, vJAXB 2.1.3 in JDK 1.6 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2009.03.23 at 11:25:22 AM MEZ 
//


package org.riddl.ns.description._1;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlSeeAlso;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for riddl-resource complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="riddl-resource">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element ref="{http://riddl.org/ns/description/1.0}post" maxOccurs="unbounded" minOccurs="0"/>
 *         &lt;element ref="{http://riddl.org/ns/description/1.0}get" maxOccurs="unbounded" minOccurs="0"/>
 *         &lt;element ref="{http://riddl.org/ns/description/1.0}put" maxOccurs="unbounded" minOccurs="0"/>
 *         &lt;element ref="{http://riddl.org/ns/description/1.0}delete" maxOccurs="unbounded" minOccurs="0"/>
 *         &lt;element ref="{http://riddl.org/ns/description/1.0}resource" maxOccurs="unbounded" minOccurs="0"/>
 *       &lt;/sequence>
 *       &lt;attribute name="recursive" type="{http://www.w3.org/2001/XMLSchema}boolean" />
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "riddl-resource", propOrder = {
    "post",
    "get",
    "put",
    "delete",
    "resource"
})
@XmlSeeAlso({
    Resource.class
})
public class RiddlResource {

    protected List<Post> post;
    protected List<Get> get;
    protected List<Put> put;
    protected List<Delete> delete;
    protected List<Resource> resource;
    @XmlAttribute
    protected Boolean recursive;

    /**
     * Gets the value of the post property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the post property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getPost().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link Post }
     * 
     * 
     */
    public List<Post> getPost() {
        if (post == null) {
            post = new ArrayList<Post>();
        }
        return this.post;
    }

    /**
     * Gets the value of the get property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the get property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getGet().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link Get }
     * 
     * 
     */
    public List<Get> getGet() {
        if (get == null) {
            get = new ArrayList<Get>();
        }
        return this.get;
    }

    /**
     * Gets the value of the put property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the put property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getPut().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link Put }
     * 
     * 
     */
    public List<Put> getPut() {
        if (put == null) {
            put = new ArrayList<Put>();
        }
        return this.put;
    }

    /**
     * Gets the value of the delete property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the delete property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getDelete().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link Delete }
     * 
     * 
     */
    public List<Delete> getDelete() {
        if (delete == null) {
            delete = new ArrayList<Delete>();
        }
        return this.delete;
    }

    /**
     * Gets the value of the resource property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the resource property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getResource().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link Resource }
     * 
     * 
     */
    public List<Resource> getResource() {
        if (resource == null) {
            resource = new ArrayList<Resource>();
        }
        return this.resource;
    }

    /**
     * Gets the value of the recursive property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isRecursive() {
        return recursive;
    }

    /**
     * Sets the value of the recursive property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setRecursive(Boolean value) {
        this.recursive = value;
    }

}
