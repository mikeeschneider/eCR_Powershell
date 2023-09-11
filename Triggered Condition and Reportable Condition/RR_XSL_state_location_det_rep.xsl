<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:cda="urn:hl7-org:v3">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
	<RRxml>
		<documentInfo>
			<eCRNum value="{//cda:externalDocument[cda:templateId/@root='2.16.840.1.113883.10.20.22.4.115']/cda:id/@root}"/>
			<setId value="{//cda:externalDocument[cda:templateId/@root='2.16.840.1.113883.10.20.22.4.115']/cda:setId/@extension}"/>
			<versionNumber value="{//cda:externalDocument[cda:templateId/@root='2.16.840.1.113883.10.20.22.4.115']/cda:versionNumber/@value}"/>
			<ecrReceiptTime value="{//cda:act[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.9']/cda:effectiveTime/@value}"/>
			<ecrReceiptTime2><xsl:value-of select="substring(//cda:act[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.9']/cda:effectiveTime/@value,0,9)"/></ecrReceiptTime2>
			
			<rrTime value="{/cda:ClinicalDocument/cda:effectiveTime/@value}"/>
			
			<rrTime2><xsl:value-of select="substring(/cda:ClinicalDocument/cda:effectiveTime/@value,0,9)"/></rrTime2>
			
			<encompassingEncounterDate value="{/cda:ClinicalDocument/cda:componentOf/cda:encompassingEncounter/cda:effectiveTime/cda:low/@value}"/>
			
			<encompassingEncounterDate2><xsl:value-of select="substring(/cda:ClinicalDocument/cda:componentOf/cda:encompassingEncounter/cda:effectiveTime/cda:low/@value,0,9)"/></encompassingEncounterDate2>
			<FirstName value="{/cda:ClinicalDocument/cda:recordTarget/cda:patientRole/cda:patient/cda:name[@use='L']/cda:given}"/>
			<LastName value="{/cda:ClinicalDocument/cda:recordTarget/cda:patientRole/cda:patient/cda:name[@use='L']/cda:family}"/>
			<DOB value="{/cda:ClinicalDocument/cda:recordTarget/cda:patientRole/cda:patient/cda:birthTime/@value}"/>
			
			<encompassingEncounterCode value="{/cda:ClinicalDocument/cda:componentOf/cda:encompassingEncounter/cda:code/@code}"/>
			<receivedOrgName value="{/cda:ClinicalDocument/cda:informationRecipient/cda:intendedRecipient/cda:receivedOrganization/cda:name}"/>
			<receivedOrgState value="{/cda:ClinicalDocument/cda:informationRecipient/cda:intendedRecipient/cda:receivedOrganization/cda:addr/cda:state}"/>
			<providerOrgName value="{/cda:ClinicalDocument/cda:recordTarget/cda:patientRole/cda:providerOrganization/cda:name}"/>
			<providerOrgState value="{/cda:ClinicalDocument/cda:recordTarget/cda:patientRole/cda:providerOrganization/cda:addr/cda:state}"/>
			<serviceProviderOrgName value="{//cda:encompassingEncounter/cda:location/cda:healthCareFacility/cda:serviceProviderOrganization/cda:name}"/>
			<serviceProviderOrgState value="{//cda:encompassingEncounter/cda:location/cda:healthCareFacility/cda:serviceProviderOrganization/cda:addr/cda:state}"/>
			<healthCareFacilityName value="{//cda:encompassingEncounter/cda:location/cda:healthCareFacility/cda:location/cda:name}"/>  
			<healthCareFacilityState value="{//cda:encompassingEncounter/cda:location/cda:healthCareFacility/cda:location/cda:addr/cda:state}"/>
		</documentInfo>
		<conditionCode>
			<condition1state value="{//cda:organizer[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.34']/cda:component[1]/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.12'][cda:code/@code='64572001'][cda:entryRelationship/cda:organizer/cda:participant[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.4.3']/cda:participantRole/cda:id/@extension='ct'][cda:entryRelationship/cda:organizer/cda:component/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.19']/cda:value/@code='RRVS1']/cda:value/@code}"/>
			
			<condition2state value="{//cda:organizer[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.34']/cda:component[2]/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.12'][cda:code/@code='64572001'][cda:entryRelationship/cda:organizer/cda:participant[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.4.3']/cda:participantRole/cda:id/@extension='ct'][cda:entryRelationship/cda:organizer/cda:component/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.19']/cda:value/@code='RRVS1']/cda:value/@code}"/>
			<condition3state value="{//cda:organizer[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.34']/cda:component[3]/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.12'][cda:code/@code='64572001'][cda:entryRelationship/cda:organizer/cda:participant[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.4.3']/cda:participantRole/cda:id/@extension='ct'][cda:entryRelationship/cda:organizer/cda:component/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.19']/cda:value/@code='RRVS1']/cda:value/@code}"/>
			<condition4state value="{//cda:organizer[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.34']/cda:component[4]/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.12'][cda:code/@code='64572001'][cda:entryRelationship/cda:organizer/cda:participant[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.4.3']/cda:participantRole/cda:id/@extension='ct'][cda:entryRelationship/cda:organizer/cda:component/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.19']/cda:value/@code='RRVS1']/cda:value/@code}"/>
			<condition5state value="{//cda:organizer[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.34']/cda:component[5]/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.12'][cda:code/@code='64572001'][cda:entryRelationship/cda:organizer/cda:participant[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.4.3']/cda:participantRole/cda:id/@extension='ct'][cda:entryRelationship/cda:organizer/cda:component/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.19']/cda:value/@code='RRVS1']/cda:value/@code}"/>
			<condition6state value="{//cda:organizer[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.34']/cda:component[6]/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.12'][cda:code/@code='64572001'][cda:entryRelationship/cda:organizer/cda:participant[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.4.3']/cda:participantRole/cda:id/@extension='ct'][cda:entryRelationship/cda:organizer/cda:component/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.19']/cda:value/@code='RRVS1']/cda:value/@code}"/>
			<condition7state value="{//cda:organizer[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.34']/cda:component[7]/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.12'][cda:code/@code='64572001'][cda:entryRelationship/cda:organizer/cda:participant[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.4.3']/cda:participantRole/cda:id/@extension='ct'][cda:entryRelationship/cda:organizer/cda:component/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.19']/cda:value/@code='RRVS1']/cda:value/@code}"/>
			
			
			
			
			
			<displayName1 value="{//cda:organizer[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.34']/cda:component[1]/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.12'][cda:code/@code='64572001'][cda:entryRelationship/cda:organizer/cda:participant[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.4.3']/cda:participantRole/cda:id/@extension='ct'][cda:entryRelationship/cda:organizer/cda:component/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.19']/cda:value/@code='RRVS1']/cda:value/@displayName}"/>
			<displayName2 value="{//cda:organizer[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.34']/cda:component[2]/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.12'][cda:code/@code='64572001'][cda:entryRelationship/cda:organizer/cda:participant[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.4.3']/cda:participantRole/cda:id/@extension='ct'][cda:entryRelationship/cda:organizer/cda:component/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.19']/cda:value/@code='RRVS1']/cda:value/@displayName}"/>
			<displayName3 value="{//cda:organizer[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.34']/cda:component[3]/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.12'][cda:code/@code='64572001'][cda:entryRelationship/cda:organizer/cda:participant[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.4.3']/cda:participantRole/cda:id/@extension='ct'][cda:entryRelationship/cda:organizer/cda:component/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.19']/cda:value/@code='RRVS1']/cda:value/@displayName}"/>
			<displayName4 value="{//cda:organizer[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.34']/cda:component[4]/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.12'][cda:code/@code='64572001'][cda:entryRelationship/cda:organizer/cda:participant[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.4.3']/cda:participantRole/cda:id/@extension='ct'][cda:entryRelationship/cda:organizer/cda:component/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.19']/cda:value/@code='RRVS1']/cda:value/@displayName}"/>
			<displayName5 value="{//cda:organizer[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.34']/cda:component[5]/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.12'][cda:code/@code='64572001'][cda:entryRelationship/cda:organizer/cda:participant[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.4.3']/cda:participantRole/cda:id/@extension='ct'][cda:entryRelationship/cda:organizer/cda:component/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.19']/cda:value/@code='RRVS1']/cda:value/@displayName}"/>
			<displayName6 value="{//cda:organizer[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.34']/cda:component[6]/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.12'][cda:code/@code='64572001'][cda:entryRelationship/cda:organizer/cda:participant[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.4.3']/cda:participantRole/cda:id/@extension='ct'][cda:entryRelationship/cda:organizer/cda:component/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.19']/cda:value/@code='RRVS1']/cda:value/@displayName}"/>
			<displayName7 value="{//cda:organizer[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.34']/cda:component[7]/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.12'][cda:code/@code='64572001'][cda:entryRelationship/cda:organizer/cda:participant[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.4.3']/cda:participantRole/cda:id/@extension='ct'][cda:entryRelationship/cda:organizer/cda:component/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.15.2.3.19']/cda:value/@code='RRVS1']/cda:value/@displayName}"/>
		</conditionCode>
		
	</RRxml>
</xsl:template>
</xsl:stylesheet>


