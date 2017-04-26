
-- additional methods for Tensor


local TensorTypes = {
   float  = 'torch.FloatTensor',
   double = 'torch.DoubleTensor',
   long   = 'torch.LongTensor'

}

local TH2MKL = {
   float = 'mklFloat',
   double = 'mklDouble',
   long = 'mklLong'
}

local MKLTensorTypes = {
   mklFloat  = 'torch.MKLFloatTensor',
   mklDouble = 'torch.MKLDoubleTensor',
   mklLong   = 'torch.MKLLongTensor'
}

local MKL2TH = {
   mklFloat  = 'float' ,
   mklDouble = 'double' ,
   mklLong   = 'long'
}
print('outside')


local function Tensor__TH2MKL__converter(type)
   return function(self)
            local current = torch.typename(self)
            if not type then return current end
            if type ~= current then
              local new = torch.getmetatable(type).new()
              new:copyFromTH(self)
              --pStruct = Tensor_tt(self)[0]
              
              return new
            else
              return self
            end
           end
    end


local function Tensor__MKL2TH__converter(type)
    return function(self)
             local current = torch.typename(self)
             if not type then return current end
             if type ~= current then
               print("Tensor__MKL2TH__converter, type = ", type,", current = ",current)
               local new = torch.getmetatable(type).new()
               print(new:type())
               print(self:type())
               self:copyBacktoTH(new)
               return new
             else
               return self
             end
    end
end

local function getType(type)
   return function(self)
             return type
             end
end

for type, SrcType in pairs(TensorTypes) do
	local metatable = torch.getmetatable(SrcType)
	local MKLType = TH2MKL[type]
	--rawset(metatable, 'mkl', torch.tic())
    rawset(metatable, 'mkl', Tensor__TH2MKL__converter(MKLTensorTypes[MKLType]))
    rawset(metatable, MKLType, Tensor__TH2MKL__converter(MKLTensorTypes[MKLType]))
end

for type, SrcType in pairs(MKLTensorTypes) do
	local metatable = torch.getmetatable(SrcType)
	local THType = MKL2TH[type]
	print("SrcType = ", SrcType)
	print("type = ", type)
	print("THType = ", THType)
    rawset(metatable, 'th', Tensor__MKL2TH__converter(TensorTypes[THType]))
    rawset(metatable, THType, Tensor__MKL2TH__converter(TensorTypes[THType]))
    rawset(metatable, 'type', getType(SrcType))
end



