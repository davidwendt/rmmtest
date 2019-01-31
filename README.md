# rmmtest

Trying to figure out how to use rmm from https://github.com/rapidsai/rmm

Here are the steps.

In your repo create a `thirdparty` dir to hold submodules.
Execute following commands:
```
cd thirdparty
git submodule add -b branch-0.5 git@github.com:rapidsai/rmm.git
git submodule sync
git submodule update --init --recursive --remote rmm
```
This ensures you get rmm's submodules as well.

Create CMakeLists.txt with the following key elements.
```
add_subdirectory(thirdparty/rmm "${CMAKE_BINARY_DIR}/rmm")
include_directories("${CMAKE_SOURCE_DIR}/thirdparty/rmm/include")

target_link_libraries(xxxx rmm)
```
See the CMakeLists.txt here for latest details.

Example usage:
```
#include <rmm/rmm.h>

int test1()
{
   char* buffer = 0;

   RMM_ALLOC(&buffer,100,0);

   const char* data = "hello, world";
   int len = (int)strlen(data)+1;
   cudaMemcpy(buffer,data,len,cudaMemcpyHostToDevice);

   char* output = new char[len];
   cudaMemcpy(output,buffer,len,cudaMemcpyDeviceToHost);
   printf("%s\n",output);

   RMM_FREE(buffer,0);

   return 0;
}

```
Default uses cudaMalloc. Example initialization of memory pool:
```
   rmmOptions_t options;
   options.allocation_mode = PoolAllocation;
   options.initial_pool_size = 0;
   options.enable_logging = false;
   rmmInitialize(&options);
```
This is normally done at the beginning of the process.
See the https://github.com/rapidsai/rmm for more info.
