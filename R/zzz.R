# Unloading the dynamic library when detaching the package

.onUnload <- function(libpath) {
  library.dynam.unload("retro", libpath)
}
