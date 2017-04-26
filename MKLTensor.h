
#include <stdlib.h>
#include <string.h>

#include "luaT.h"
#include "THStorage.h"
#include "THTensor.h"

#define TH_MKL_FREE_PERMISSION 1
#define TH_MKL_REFCOUNTED 1
#define TH_STORAGE_UNREFCOUNTED 0

#define THTensor            TH_CONCAT_3(TH,Real,Tensor)          
#define torch_mkl_(NAME)        TH_CONCAT_4(torch_MKL, Real, Tensor_, NAME)             
#define TH_MKL_(NAME)       TH_CONCAT_4(THMKL, Real, Tensor, NAME)                                      
#define torch_mkl_tensor        TH_CONCAT_STRING_4(torch., MKL, Real, Tensor)
#define THMKLTensor                     TH_CONCAT_3(THMKL, Real, Tensor)



#include "generic/tensor.h"
#include "generateAllTypes.h"

