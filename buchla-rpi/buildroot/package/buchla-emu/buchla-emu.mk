################################################################################
#
# buchla-emu
#
################################################################################

BUCHLA_EMU_SITE = $(BR2_EXTERNAL_BUCHLA_PATH)/../../buchla-emu
BUCHLA_EMU_SITE_METHOD = local
BUCHLA_EMU_DEPENDENCIES = sdl2 sdl2_net sdl2_ttf freetype harfbuzz alsa-lib rtmidi

define BUCHLA_EMU_CONFIGURE_CMDS
	rm -f $(@D)/build/*.o $(@D)/build/gen
endef

define BUCHLA_EMU_BUILD_CMDS
	$(MAKE) -C $(@D) RPI=1 \
		GCC="$(TARGET_CC)" GPP="$(TARGET_CXX)" \
		SDL2=$(STAGING_DIR)/usr RTMIDI=$(STAGING_DIR)/usr
endef

define BUCHLA_EMU_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/buchla $(TARGET_DIR)/usr/bin/buchla
	$(INSTALL) -d $(TARGET_DIR)/opt/buchla
	for f in bios.abs midas.abs vera.ttf buchla.disk; do \
		if [ -f $(@D)/$$f ]; then \
			$(INSTALL) -m 0644 $(@D)/$$f $(TARGET_DIR)/opt/buchla/; \
		fi; \
	done
endef

$(eval $(generic-package))
