//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, vJAXB 2.1.3 in JDK 1.6 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2009.03.23 at 11:25:22 AM MEZ 
//


package org.relaxng.ns.structure._1;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAnyAttribute;
import javax.xml.bind.annotation.XmlAnyElement;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlSchemaType;
import javax.xml.bind.annotation.XmlType;
import javax.xml.namespace.QName;
import org.w3c.dom.Element;


/**
 * <p>Java class for anonymous complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType>
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;group ref="{http://relaxng.org/ns/structure/1.0}other"/>
 *       &lt;attGroup ref="{http://relaxng.org/ns/structure/1.0}common-atts"/>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "anyOrAny"
})
@XmlRootElement(name = "text")
public class Text {

    @XmlAnyElement
    protected List<Element> anyOrAny;
    @XmlAttribute
    @XmlSchemaType(name = "anySimpleType")
    protected String ns;
    @XmlAttribute
    @XmlSchemaType(name = "anyURI")
    protected String datatypeLibrary;
    @XmlAnyAttribute
    private Map<QName, String> otherAttributes = new HashMap<QName, String>();

    /**
     * Gets the value of the anyOrAny property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the anyOrAny property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getAnyOrAny().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link Element }
     * 
     * 
     */
    public List<Element> getAnyOrAny() {
        if (anyOrAny == null) {
            anyOrAny = new ArrayList<Element>();
        }
        return this.anyOrAny;
    }

    /**
     * Gets the value of the ns property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNs() {
        return ns;
    }

    /**
     * Sets the value of the ns property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNs(String value) {
        this.ns = value;
    }

    /**
     * Gets the value of the datatypeLibrary property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDatatypeLibrary() {
        return datatypeLibrary;
    }

    /**
     * Sets the value of the datatypeLibrary property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDatatypeLibrary(String value) {
        this.datatypeLibrary = value;
    }

    /**
     * Gets a map that contains attributes that aren't bound to any typed property on this class.
     * 
     * <p>
     * the map is keyed by the name of the attribute and 
     * the value is the string value of the attribute.
     * 
     * the map returned by this method is live, and you can add new attribute
     * by updating the map directly. Because of this design, there's no setter.
     * 
     * 
     * @return
     *     always non-null
     */
    public Map<QName, String> getOtherAttributes() {
        return otherAttributes;
    }

}
