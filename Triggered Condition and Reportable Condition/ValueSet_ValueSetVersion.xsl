<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:cda="urn:hl7-org:v3" xmlns:sdtc="urn:hl7-org:sdtc">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
    <rootroot>
		<DocInfo>
			<ReportID value="{/cda:ClinicalDocument/cda:id/@root}"/>
			<ReportDate value="{/cda:ClinicalDocument/cda:effectiveTime/@value}"/>
			<ReportDate2>
				<xsl:value-of select="substring(/cda:ClinicalDocument/cda:effectiveTime/@value,5,2)"/>
				<xsl:text>/</xsl:text>
				<xsl:value-of select="substring(/cda:ClinicalDocument/cda:effectiveTime/@value,7,2)"/>
				<xsl:text>/</xsl:text>
				<xsl:value-of select="substring(/cda:ClinicalDocument/cda:effectiveTime/@value,0,5)"/>
			</ReportDate2>
			<ProviderOrgName value="{/cda:ClinicalDocument/cda:recordTarget/cda:patientRole/cda:providerOrganization/cda:name}"/>
			<CustodianOrgName value="{/cda:ClinicalDocument/cda:custodian/cda:assignedCustodian/cda:representedCustodianOrganization/cda:name}"/>
		</DocInfo>
		
		<software>
			<softwareName value="{//cda:author/cda:assignedAuthor/cda:assignedAuthoringDevice/cda:softwareName}"/>
			<manufactureName value="{//cda:author/cda:assignedAuthor/cda:assignedAuthoringDevice/cda:manufacturerModelName}"/>
		</software>
		
		<CodeValueSet>
			<xsl:for-each select="//cda:code">
				<xsl:choose>
					<xsl:when test="@sdtc:valueSet">
						<code>
							<xsl:value-of select="@code"/>
						</code>
						<value>
							<xsl:value-of select="@value"/>
						</value>
						<valueSet>
							<xsl:value-of select="@sdtc:valueSet"/>
						</valueSet>
						<valueSetVersion>
							<xsl:value-of select="@sdtc:valueSetVersion"/>
						</valueSetVersion>
					</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:for-each>
		</CodeValueSet>
		
		<ValueValueSet>
			<xsl:for-each select="//cda:value">
				<xsl:choose>
					<xsl:when test="@sdtc:valueSet">
						<code>
							<xsl:value-of select="@code"/>
						</code>
						<value>
							<xsl:value-of select="@value"/>
						</value>
						<valueSet>
							<xsl:value-of select="@sdtc:valueSet"/>
						</valueSet>
						<valueSetVersion>
							<xsl:value-of select="@sdtc:valueSetVersion"/>
						</valueSetVersion>
					</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:for-each>		
		</ValueValueSet>
			
		
    </rootroot>
</xsl:template>

</xsl:stylesheet>