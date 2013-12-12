MIX_DIR   ?= mix
MIXER_DIR ?= .

REV        = $(shell sh -c 'git rev-parse --short @{0}')
CNCMIX     = $(MIXER_DIR)/cncmix$(EXT)
MAIN       = allies conquer edhi edlo general interior movies1 russian scores snow sounds temperat
RED_ALERT  = editor hires local lores nchires speech

TO_MIX = $(foreach mix_name,$(1),$(MIX_DIR)/$(mix_name).mix)
define BUILD_MIX
$(MIX_DIR)/$(1).mix: $(CNCMIX)
	$(CNCMIX) mod -o $(1).mix -a $(MIX_DIR)/$(2)/$(1) -t 1
endef

mixes: $(CNCMIX) $(call TO_MIX,$(MAIN)) $(call TO_MIX,$(RED_ALERT))

$(MAIN):
	$(echo a)

$(RED_ALERT):
	$(echo a)

$(foreach target_mix,$(MAIN),$(eval $(call BUILD_MIX,$(target_mix),main)))
$(foreach target_mix,$(RED_ALERT),$(eval $(call BUILD_MIX,$(target_mix),redalert)))

clean_mixes:
	rm -rf $(MIX_DIR)/linker$(EXT) $(MIX_DIR)/extpe$(EXT)

.PHONY: mixes clean_mixes
