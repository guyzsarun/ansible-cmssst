from WMCore.Configuration import Configuration
from CRABClient.UserUtilities import config, getUsernameFromCRIC

config = Configuration()

config.section_('General')

config.section_('JobType')
config.JobType.psetName = 'pset.py'
config.JobType.pluginName = 'Analysis'
config.JobType.maxJobRuntimeMin = 60


config.section_('Data')
config.Data.inputDataset = '/GenericTTbar/HC-CMSSW_9_2_6_91X_mcRun1_realistic_v2-v2/AODSIM'
config.Data.totalUnits = 100
config.Data.splitting = 'LumiBased'
config.Data.outLFNDirBase = '/store/user/rucio/%s/autotest-rucio' % (getUsernameFromCRIC())
config.Data.outputDatasetTag = 'autotest'
config.Data.unitsPerJob = 10

config.section_('User')

config.section_('Site')
config.Site.storageSite = 'T2_CH_CERN'
config.Site.whitelist = ['SITE_NAME']

config.section_('Debug')
config.Debug.extraJDL = ['+CMS_ALLOW_OVERFLOW=False']