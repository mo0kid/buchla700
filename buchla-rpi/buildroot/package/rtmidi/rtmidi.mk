################################################################################
#
# rtmidi
#
################################################################################

RTMIDI_VERSION = 6.0.0
RTMIDI_SOURCE = $(RTMIDI_VERSION).tar.gz
RTMIDI_SITE = https://github.com/thestk/rtmidi/archive/refs/tags
RTMIDI_INSTALL_STAGING = YES
RTMIDI_DEPENDENCIES = alsa-lib
RTMIDI_CONF_OPTS = -DRTMIDI_API_ALSA=ON -DRTMIDI_API_JACK=OFF

$(eval $(cmake-package))
