//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, vJAXB 2.1.3 in JDK 1.6 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2009.03.23 at 11:25:22 AM MEZ 
//


package org.riddl.description;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;



@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "")
@XmlRootElement(name = "resource")
public class Resource
    extends RiddlResource
{

    @XmlAttribute
    protected String relative;

    /**
     * Gets the value of the relative property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRelative() {
        return relative;
    }

    /**
     * Sets the value of the relative property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRelative(String value) {
        this.relative = value;
    }

}
