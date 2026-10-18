package com.road.yishi.proto.pet
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PetContractInfoMsg extends Message implements IExternalizable
   {
      
      private var petSonType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var contractTempId$field:int;
      
      public function PetContractInfoMsg()
      {
         super();
      }
      
      public function removePetSonType() : void
      {
         hasField$0 &= 4294967294;
         petSonType$field = new int();
      }
      
      public function get hasPetSonType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set petSonType(param1:int) : void
      {
         hasField$0 |= 1;
         petSonType$field = param1;
      }
      
      public function get petSonType() : int
      {
         return petSonType$field;
      }
      
      public function removeContractTempId() : void
      {
         hasField$0 &= 4294967293;
         contractTempId$field = new int();
      }
      
      public function get hasContractTempId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set contractTempId(param1:int) : void
      {
         hasField$0 |= 2;
         contractTempId$field = param1;
      }
      
      public function get contractTempId() : int
      {
         return contractTempId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPetSonType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,petSonType$field);
         }
         if(hasContractTempId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,contractTempId$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PetContractInfoMsg.petSonType cannot be set twice.");
                  }
                  _loc3_++;
                  petSonType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PetContractInfoMsg.contractTempId cannot be set twice.");
                  }
                  _loc4_++;
                  contractTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

