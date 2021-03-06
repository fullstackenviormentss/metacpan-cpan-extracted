/*
 * Generated by asn1c-0.9.23 (http://lionet.info/asn1c)
 * From ASN.1 module "RRLP-Components"
 * 	found in "../asn1src/RRLP-Components.asn"
 * 	`asn1c -gen-PER -fskeletons-copy -fnative-types`
 */

#ifndef	_GANSSGenericAssistDataElement_H_
#define	_GANSSGenericAssistDataElement_H_


#include <asn_application.h>

/* Including external dependencies */
#include <NativeInteger.h>
#include <constr_SEQUENCE.h>

#ifdef __cplusplus
extern "C" {
#endif

/* Forward declarations */
struct SeqOfGANSSTimeModel;
struct GANSSDiffCorrections;
struct GANSSNavModel;
struct GANSSRealTimeIntegrity;
struct GANSSDataBitAssist;
struct GANSSRefMeasurementAssist;
struct GANSSAlmanacModel;
struct GANSSUTCModel;
struct GANSSEphemerisExtension;
struct GANSSEphemerisExtensionCheck;
struct GANSSAddUTCModel;
struct GANSSAuxiliaryInformation;
struct GANSSDiffCorrectionsValidityPeriod;
struct SeqOfGANSSTimeModel_R10_Ext;
struct GANSSRefMeasurementAssist_R10_Ext;
struct GANSSAlmanacModel_R10_Ext;

/* GANSSGenericAssistDataElement */
typedef struct GANSSGenericAssistDataElement {
	long	*ganssID	/* OPTIONAL */;
	struct SeqOfGANSSTimeModel	*ganssTimeModel	/* OPTIONAL */;
	struct GANSSDiffCorrections	*ganssDiffCorrections	/* OPTIONAL */;
	struct GANSSNavModel	*ganssNavigationModel	/* OPTIONAL */;
	struct GANSSRealTimeIntegrity	*ganssRealTimeIntegrity	/* OPTIONAL */;
	struct GANSSDataBitAssist	*ganssDataBitAssist	/* OPTIONAL */;
	struct GANSSRefMeasurementAssist	*ganssRefMeasurementAssist	/* OPTIONAL */;
	struct GANSSAlmanacModel	*ganssAlmanacModel	/* OPTIONAL */;
	struct GANSSUTCModel	*ganssUTCModel	/* OPTIONAL */;
	struct GANSSEphemerisExtension	*ganssEphemerisExtension	/* OPTIONAL */;
	struct GANSSEphemerisExtensionCheck	*ganssEphemerisExtCheck	/* OPTIONAL */;
	/*
	 * This type is extensible,
	 * possible extensions are below.
	 */
	long	*sbasID	/* OPTIONAL */;
	struct GANSSAddUTCModel	*ganssAddUTCModel	/* OPTIONAL */;
	struct GANSSAuxiliaryInformation	*ganssAuxiliaryInfo	/* OPTIONAL */;
	struct GANSSDiffCorrectionsValidityPeriod	*ganssDiffCorrectionsValidityPeriod	/* OPTIONAL */;
	struct SeqOfGANSSTimeModel_R10_Ext	*ganssTimeModel_R10_Ext	/* OPTIONAL */;
	struct GANSSRefMeasurementAssist_R10_Ext	*ganssRefMeasurementAssist_R10_Ext	/* OPTIONAL */;
	struct GANSSAlmanacModel_R10_Ext	*ganssAlmanacModel_R10_Ext	/* OPTIONAL */;
	
	/* Context for parsing across buffer boundaries */
	asn_struct_ctx_t _asn_ctx;
} GANSSGenericAssistDataElement_t;

/* Implementation */
extern asn_TYPE_descriptor_t asn_DEF_GANSSGenericAssistDataElement;

#ifdef __cplusplus
}
#endif

/* Referred external types */
#include "SeqOfGANSSTimeModel.h"
#include "GANSSDiffCorrections.h"
#include "GANSSNavModel.h"
#include "GANSSRealTimeIntegrity.h"
#include "GANSSDataBitAssist.h"
#include "GANSSRefMeasurementAssist.h"
#include "GANSSAlmanacModel.h"
#include "GANSSUTCModel.h"
#include "GANSSEphemerisExtension.h"
#include "GANSSEphemerisExtensionCheck.h"
#include "GANSSAddUTCModel.h"
#include "GANSSAuxiliaryInformation.h"
#include "GANSSDiffCorrectionsValidityPeriod.h"
#include "SeqOfGANSSTimeModel-R10-Ext.h"
#include "GANSSRefMeasurementAssist-R10-Ext.h"
#include "GANSSAlmanacModel-R10-Ext.h"

#endif	/* _GANSSGenericAssistDataElement_H_ */
#include <asn_internal.h>
