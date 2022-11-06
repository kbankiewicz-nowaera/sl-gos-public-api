<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:datetime="http://exslt.org/dates-and-times"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:data="http://com.sanomalearning/webshop/order/services/v1/data">
	<xsl:template match="/">
		<WebshopOrderRequest
			xmlns="http://com.sanomalearning/webshop/order/services/v1/data">
			<WebshopOrder>
				<OrderHeader>
					<OrderNumber>
						<xsl:value-of select="/clientOrderNumber" />
					</OrderNumber>
					<OrderDate>
						<xsl:value-of
							select="format-date(current-date(),'[Y0001]-[M01]-[D01]')" />
					</OrderDate>
					<OrderCustomer>
						<CustomerOrganization>
							<xsl:if test="contains(/clientId,'laromedia.se')">
								<Name2>7365564162759</Name2>
							</xsl:if>
						</CustomerOrganization>
					</OrderCustomer>
					<OrderDocumentType>ZTOX</OrderDocumentType>
					<xsl:if test="contains(/clientId,'sanomautbildning.se')">
						<SalesOrganization>5000</SalesOrganization>
					</xsl:if>
					<InvoiceReference>
						<xsl:value-of select="/clientOrderNumber" />
					</InvoiceReference>
				</OrderHeader>
				<xsl:for-each select="//orderRows">
					<OrderLine>
						<OrderProductOffer>
							<Product>
								<CommercialProductIdentifier>
									<xsl:value-of select="./articleNumber" />
								</CommercialProductIdentifier>
							</Product>
							<ProductOfferCondition>
								<SpecialOrderDiscountPercentageNegative>
									<xsl:value-of select="fn:concat(./discount,'.00')" />
								</SpecialOrderDiscountPercentageNegative>
							</ProductOfferCondition>
						</OrderProductOffer>
						<OrderLicense>
							<LicenseUnit>
								<xsl:value-of
									select="fn:concat(./duration,' ',fn:upper-case(./durationUnit))" />
							</LicenseUnit>
							<LicenseStartDate>
								<xsl:value-of select="./fromDate" />
							</LicenseStartDate>
						</OrderLicense>
						<OrderQuantity>
							<xsl:value-of select="./quantity" />
						</OrderQuantity>
						<OrderLineCustomer>
							<CustomerOrganization>
								<Id>
									<xsl:value-of select="/account/id" />
								</Id>
								<Name>
									<xsl:value-of select="/account/name" />
								</Name>
								<Name2>
									<xsl:value-of select="/reference/name" />
								</Name2>
								<Address>
									<StreetName>
										<xsl:value-of select="/account/address" />
									</StreetName>
									<ZipCode>
										<xsl:value-of select="/account/postalcode" />
									</ZipCode>
									<City>
										<xsl:value-of select="/account/city" />
									</City>
									<Country>
										<xsl:value-of select="/account/country" />
									</Country>
								</Address>
								<Contact>
									<CommunicationChannel>
										<CommuncationType>EmailAddress</CommuncationType>
										<CommunicationCode>
											<xsl:value-of select="/reference/email" />
										</CommunicationCode>
									</CommunicationChannel>
								</Contact>
							</CustomerOrganization>
						</OrderLineCustomer>
						<OrderLineInvoiceReference>
							<xsl:value-of select="/clientOrderNumber" />
						</OrderLineInvoiceReference>
					</OrderLine>
				</xsl:for-each>
			</WebshopOrder>
		</WebshopOrderRequest>
	</xsl:template>
</xsl:stylesheet>
