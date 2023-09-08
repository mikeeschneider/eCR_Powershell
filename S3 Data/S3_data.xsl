<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:cda="urn:hl7-org:v3">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
    <rootroot>
		<reportDate><xsl:value-of select="substring(/cda:ClinicalDocument/cda:effectiveTime/@value,5,2)"/>
		<xsl:text>/</xsl:text>
		<xsl:value-of select="substring(/cda:ClinicalDocument/cda:effectiveTime/@value,7,2)"/>
		<xsl:text>/</xsl:text>
		<xsl:value-of select="substring(/cda:ClinicalDocument/cda:effectiveTime/@value,0,5)"/></reportDate>
		<encounterDate><xsl:value-of select="substring(//cda:encompassingEncounter/cda:effectiveTime/cda:low/@value,5,2)"/>
		<xsl:text>/</xsl:text>
		<xsl:value-of select="substring(//cda:encompassingEncounter/cda:effectiveTime/cda:low/@value,7,2)"/>
		<xsl:text>/</xsl:text>
		<xsl:value-of select="substring(//cda:encompassingEncounter/cda:effectiveTime/cda:low/@value,0,5)"/></encounterDate>
		<ecrNum value="{/cda:ClinicalDocument/cda:id/@root}"/>
		<setIdRoot value="{/cda:ClinicalDocument/cda:setId/@root}"/>
		<versionNum value="{/cda:ClinicalDocument/cda:versionNumber/@value}"/>
		<author value="{/cda:ClinicalDocument/cda:author/cda:assignedAuthor/cda:representedOrganization/cda:name}"/>
		<authorIdRoot value="{/cda:ClinicalDocument/cda:author/cda:assignedAuthor/cda:representedOrganization/cda:id/@root}"/>
		<authorIdExtension value="{/cda:ClinicalDocument/cda:author/cda:assignedAuthor/cda:representedOrganization/cda:id/@extension}"/>
		<serviceProviderOrg value="{/cda:ClinicalDocument/cda:componentOf/cda:encompassingEncounter/cda:location/cda:healthCareFacility/cda:serviceProviderOrganization/cda:name}"/>
		<serviceProviderOrgIdRoot value="{/cda:ClinicalDocument/cda:componentOf/cda:encompassingEncounter/cda:location/cda:healthCareFacility/cda:serviceProviderOrganization/cda:id/@root}"/>
		<serviceProviderOrgIdExtension value="{/cda:ClinicalDocument/cda:componentOf/cda:encompassingEncounter/cda:location/cda:healthCareFacility/cda:serviceProviderOrganization/cda:id/@extension}"/>
		<facility value="{/cda:ClinicalDocument/cda:componentOf/cda:encompassingEncounter/cda:location/cda:healthCareFacility/cda:location/cda:name}"/>
		<facilityIdRoot value="{/cda:ClinicalDocument/cda:componentOf/cda:encompassingEncounter/cda:location/cda:healthCareFacility/cda:id/@root}"/>
		<facilityIdExtension value="{/cda:ClinicalDocument/cda:componentOf/cda:encompassingEncounter/cda:location/cda:healthCareFacility/cda:id/@extension}"/>
		<sender value="{/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:organizer/cda:informant/cda:assignedEntity/cda:representedOrganization/cda:name}"/>
		<senderIdRoot value="{/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:organizer/cda:informant/cda:assignedEntity/cda:id/@root}"/>
		<senderIdExtension value="{/cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section/cda:entry/cda:organizer/cda:informant/cda:assignedEntity/cda:id/@extension}"/>
		<custodian value="{/cda:ClinicalDocument/cda:custodian/cda:assignedCustodian/cda:representedCustodianOrganization/cda:name}"/>
		<custodianIdRoot value="{/cda:ClinicalDocument/cda:custodian/cda:assignedCustodian/cda:representedCustodianOrganization/cda:id/@root}"/>
		<custodianIdExtension value="{/cda:ClinicalDocument/cda:custodian/cda:assignedCustodian/cda:representedCustodianOrganization/cda:id/@extension}"/>
    </rootroot>
</xsl:template>

</xsl:stylesheet>