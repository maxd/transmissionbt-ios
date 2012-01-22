typedef enum
{
    TR_STATUS_STOPPED        = 0, /* Torrent is stopped */
    TR_STATUS_CHECK_WAIT     = 1, /* Queued to check files */
    TR_STATUS_CHECK          = 2, /* Checking files */
    TR_STATUS_DOWNLOAD_WAIT  = 3, /* Queued to download */
    TR_STATUS_DOWNLOAD       = 4, /* Downloading */
    TR_STATUS_SEED_WAIT      = 5, /* Queued to seed */
    TR_STATUS_SEED           = 6  /* Seeding */
}
tr_torrent_activity;

typedef enum
{
    /* everything's fine */
    TR_STAT_OK               = 0,

    /* when we anounced to the tracker, we got a warning in the response */
    TR_STAT_TRACKER_WARNING  = 1,

    /* when we anounced to the tracker, we got an error in the response */
    TR_STAT_TRACKER_ERROR    = 2,

    /* local trouble, such as disk full or permissions error */
    TR_STAT_LOCAL_ERROR      = 3
}
tr_stat_errtype;

#define TR_ETA_NOT_AVAIL -1
#define TR_ETA_UNKNOWN -2