#ifndef _CONFIG_CPU_H
#define _CONFIG_CPU_H

/*
 *Configure PLL 
 */
#define CONFIG_CLKIN_HZ		10000000
#define CONFIG_CLKIN_HALF	0
#define CONFIG_PLL_BYPASS		0
#define CONFIG_VCO_MULT		40
#define CONFIG_CCLK_DIV		1
#define CONFIG_SCLK_DIV		3
#if (CONFIG_CLKIN_HALF==0)
	#define CONFIG_VCO_HZ		(CONFIG_CLKIN_HZ * CONFIG_VCO_MULT)
#else
	#define CONFIG_VCO_HZ		((CONFIG_CLKIN_HZ * CONFIG_VCO_MULT) / 2)
#endif

#if (CONFIG_PLL_BYPASS==0)
	#define CONFIG_CCLK_HZ		(CONFIG_VCO_HZ / CONFIG_CCLK_DIV)
	#define CONFIG_SCLK_HZ		(CONFIG_VCO_HZ / CONFIG_SCLK_DIV)
#else
	#define CONFIG_CCLK_HZ		CONFIG_CLKIN_HZ
	#define CONFIG_SCLK_HZ		CONFIG_CLKIN_HZ
#endif
	
/*
 *Configure SDRAM
 */
#define CONFIG_MEM_SIZE		16
#define CONFIG_MEM_ADD_WDTH	9

#define SDRAM_tRP	TRP_3	/*tRP precharge delay*/
#define SDRAM_tRP_num	3
#define SDRAM_tRAS	TRAS_6	/*tRAS Bank Activate Command Delay */
#define SDRAM_tRAS_num	6
#define SDRAM_tRCD	TRCD_3	/*required delay between a Bank Activate 		command and the start of the first Read or Write command*/
#define SDRAM_tWR	TWR_2	/*required delay between a Write command 		(driving write data) and a Precharge command.*/

/*SDRAM INFORMATION: */
#define SDRAM_Tref	64       /* Refresh period in milliseconds   */
#define SDRAM_NRA	4096     /* Number of row addresses in SDRAM */
#define SDRAM_CL	CL_3

#if ( CONFIG_MEM_SIZE == 128 )	
	#define SDRAM_SIZE	EBSZ_128 
#endif
#if ( CONFIG_MEM_SIZE == 64 )
	#define SDRAM_SIZE	EBSZ_64
#endif
#if (  CONFIG_MEM_SIZE == 32 )
	#define SDRAM_SIZE	EBSZ_32
#endif
#if ( CONFIG_MEM_SIZE == 16 )	
	#define SDRAM_SIZE	EBSZ_16	
#endif

#if ( CONFIG_MEM_ADD_WDTH == 11 )
	#define SDRAM_WIDTH	EBCAW_11 
#endif
#if ( CONFIG_MEM_ADD_WDTH == 10 )
	#define SDRAM_WIDTH	EBCAW_10
#endif
#if ( CONFIG_MEM_ADD_WDTH == 9 )
	#define SDRAM_WIDTH	EBCAW_9
#endif
#if ( CONFIG_MEM_ADD_WDTH == 8 )
	#define SDRAM_WIDTH	EBCAW_8
#endif

#define mem_SDBCTL	SDRAM_WIDTH | SDRAM_SIZE | EBE

/*RDIV Refresh Rate Control register */
#define mem_SDRRC	(((CONFIG_SCLK_HZ / 1000) * SDRAM_Tref)  / SDRAM_NRA) - (SDRAM_tRAS_num + SDRAM_tRP_num)

/* Enable SCLK Out */
#define mem_SDGCTL	( SCTLE | SDRAM_CL | SDRAM_tRAS | SDRAM_tRP | SDRAM_tRCD | SDRAM_tWR | PSS )


/*
 *Configure FLASH
 */
#define AMGCTLVAL			0x1FF
#define AMBCTL0VAL			0x3356ffc2//0xffc2ffc2//0xFFFCFFFC//0x3356aac3
#define AMBCTL1VAL			0xffc248a6//0x34a6ffc2////0x34a634a6//0x48a648a6//0x33563356//0x22b622b6//0xFFB2ffc0//0x11A611A6//0x33B233c0//0xFFB2f7c0 

#endif

