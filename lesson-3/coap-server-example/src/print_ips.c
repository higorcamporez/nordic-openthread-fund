#include "print_ips.h"
LOG_MODULE_REGISTER(print_ips, 3);

const char* getOriginName(int origin) 
{
   switch (origin) 
   {
		case OT_ADDRESS_ORIGIN_DHCPV6: 
			return "OT_ADDRESS_ORIGIN_DHCPV6";
		case OT_ADDRESS_ORIGIN_MANUAL: 
			return "OT_ADDRESS_ORIGIN_MANUAL";
		case OT_ADDRESS_ORIGIN_SLAAC: 
			return "OT_ADDRESS_ORIGIN_SLAAC";
		case OT_ADDRESS_ORIGIN_THREAD: 
			return "OT_ADDRESS_ORIGIN_THREAD";
   }
}

void printOtIps(otInstance *pInstance){

    if(pInstance == NULL){
        LOG_INF("otInstance pointer should not be null");
        return;
    }

	otNetifAddress *otAddresses;
	int ipCounter = 1;
	otAddresses = otIp6GetUnicastAddresses(pInstance);

	do{
		char ipv6_addr_str[40];  // Buffer for IPv6 address string representation
		const otIp6Address * ip6Address = &otAddresses->mAddress;

		// Convert the IPv6 address to a string
		snprintf(ipv6_addr_str, sizeof(ipv6_addr_str),
					"%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x",
					ntohs(ip6Address->mFields.m16[0]),
					ntohs(ip6Address->mFields.m16[1]),
					ntohs(ip6Address->mFields.m16[2]),
					ntohs(ip6Address->mFields.m16[3]),
					ntohs(ip6Address->mFields.m16[4]),
					ntohs(ip6Address->mFields.m16[5]),
					ntohs(ip6Address->mFields.m16[6]),
					ntohs(ip6Address->mFields.m16[7]));

		LOG_INF("(%d) IPv6 Address origin = %s, valid = %d: %s\n", ipCounter, getOriginName(otAddresses->mAddressOrigin), otAddresses->mValid, ipv6_addr_str);
		otAddresses = otAddresses->mNext;
		ipCounter++;
	}while(otAddresses != NULL);
}