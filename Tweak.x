#import <mach-o/dyld.h>
#import <string.h>
#import <substrate.h>

static int64_t (*original_has_pro_feature)(void);
static int64_t hooked_has_pro_feature(void) {
    return 1;
}

%ctor {
    // 找到 Feem 的基地址
    uint64_t base = 0;
    for (uint32_t i = 0; i < _dyld_image_count(); i++) {
        const char *name = _dyld_get_image_name(i);
		if (name && strstr(name, "Feem") && !strstr(name, "dylib")) {
            base = (uint64_t)_dyld_get_image_header(i);
			MSHookFunction(
				(void *)(base + 0x1F4644),	
				(void *)hooked_has_pro_feature,
				(void **)&original_has_pro_feature
			);
            return;
        }
    }
}