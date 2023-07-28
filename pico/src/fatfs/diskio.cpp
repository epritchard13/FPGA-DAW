/*-----------------------------------------------------------------------*/
/* Low level disk I/O module SKELETON for FatFs     (C)ChaN, 2019        */
/*-----------------------------------------------------------------------*/
/* If a working storage control module is available, it should be        */
/* attached to the FatFs via a glue function rather than modifying it.   */
/* This is an example of glue functions to attach various exsisting      */
/* storage control modules to the FatFs module with a defined API.       */
/*-----------------------------------------------------------------------*/

#include "ff.h"			/* Obtains integer types */
#include "diskio.h"		/* Declarations of disk functions */

#include "../mmc/mmc.h"
#include <stdio.h>

struct mmc * ocsdc_mmc_init(int clk_freq);

struct mmc* drv = NULL;

/* Definitions of physical drive number for each drive */
#define DEV_MMC		0	/* Example: Map MMC/SD card to physical drive 1 */

DWORD get_fattime(void) //TODO: actually write this
{
	return 0;
}

/*-----------------------------------------------------------------------*/
/* Get Drive Status                                                      */
/*-----------------------------------------------------------------------*/

DSTATUS disk_status (
	BYTE pdrv		/* Physical drive nmuber to identify the drive */
)
{
	switch (pdrv) {
	case DEV_MMC :
		if (drv)
			return 0;
		else
			return STA_NOINIT;
	}
	return STA_NOINIT;
}



/*-----------------------------------------------------------------------*/
/* Inidialize a Drive                                                    */
/*-----------------------------------------------------------------------*/

DSTATUS disk_initialize (
	BYTE pdrv				/* Physical drive nmuber to identify the drive */
)
{
	if (pdrv != DEV_MMC) return STA_NOINIT;

	//init ocsdc driver
	if (!drv) {
		drv = ocsdc_mmc_init(100000000);
	}
	if (!drv) {
		printf("ocsdc_mmc_init failed\n\r");
		return -1;
	}
	//printf("ocsdc_mmc_init success\n\r");

	drv->has_init = 0;
	int err = mmc_init(drv);
	if (err != 0 || drv->has_init == 0) {
		printf("mmc_init failed\n\r");
		return -1;
	}
	//printf("mmc_init success\n\r");

	//print_mmcinfo(drv);
	return 0;
}



/*-----------------------------------------------------------------------*/
/* Read Sector(s)                                                        */
/*-----------------------------------------------------------------------*/

DRESULT disk_read (
	BYTE pdrv,		/* Physical drive nmuber to identify the drive */
	BYTE *buff,		/* Data buffer to store read data */
	LBA_t sector,	/* Start sector in LBA */
	UINT count		/* Number of sectors to read */
)
{
	int result;

	switch (pdrv) {
	case DEV_MMC :
		// translate the arguments here
		//printf("disk_read from %llu\n\r", sector);
		result = mmc_bread(drv, sector, count, buff);
		//printf("disk_read: result = %d\n\r", result);
		if (result != count)
			return RES_ERROR;
		return RES_OK;
	}
	return RES_PARERR;
}



/*-----------------------------------------------------------------------*/
/* Write Sector(s)                                                       */
/*-----------------------------------------------------------------------*/

#if FF_FS_READONLY == 0

DRESULT disk_write (
	BYTE pdrv,			/* Physical drive nmuber to identify the drive */
	const BYTE *buff,	/* Data to be written */
	LBA_t sector,		/* Start sector in LBA */
	UINT count			/* Number of sectors to write */
)
{
	int result;

	switch (pdrv) {
	case DEV_MMC :
		// translate the arguments here
		//printf("disk_write: DEV_MMC\n\r");
		result = mmc_bwrite(drv, sector, count, buff);

		if (result != count)
			return RES_ERROR;
		return RES_OK;
	}

	return RES_PARERR;
}

#endif


/*-----------------------------------------------------------------------*/
/* Miscellaneous Functions                                               */
/*-----------------------------------------------------------------------*/

DRESULT disk_ioctl (
	BYTE pdrv,		/* Physical drive nmuber (0..) */
	BYTE cmd,		/* Control code */
	void *buff		/* Buffer to send/receive control data */
)
{
	int result;

	switch (pdrv) {
	case DEV_MMC :

		// Process of the command for the MMC/SD card
		//printf("disk_ioctl: DEV_MMC\n\r");
		return RES_OK;
	}

	return RES_PARERR;
}

