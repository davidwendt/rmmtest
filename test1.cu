
#include <rmm/rmm.h>
#include <memory.h>

int base()
{
   char* buffer = 0;

   cudaMalloc(&buffer,100);

   const char* data = "hello, world";
   int len = (int)strlen(data)+1;
   cudaMemcpy(buffer,data,len,cudaMemcpyHostToDevice);

   char* output = new char[len];
   cudaMemcpy(output,buffer,len,cudaMemcpyDeviceToHost);
   printf("%s\n",output);

   cudaFree(buffer);

   return 0;
}

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

int main( int argc, char** argv )
{
   base();
   test1();
   return 0;
}
