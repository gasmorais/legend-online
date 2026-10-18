package com.road.yishi.proto.memorycard
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class NewMemoryCardMsg extends Message implements IExternalizable
   {
      
      private var opType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var freeStep$field:int;
      
      private var buyStep$field:int;
      
      private var buyCount$field:int;
      
      private var dropInfo$field:String;
      
      private var posInfo$field:String;
      
      private var specialInfo$field:String;
      
      private var canRefresh$field:Boolean;
      
      private var isMatch$field:Boolean;
      
      private var result$field:String;
      
      public function NewMemoryCardMsg()
      {
         super();
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967294;
         opType$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 1;
         opType$field = param1;
      }
      
      public function get opType() : int
      {
         return opType$field;
      }
      
      public function removeFreeStep() : void
      {
         hasField$0 &= 4294967293;
         freeStep$field = new int();
      }
      
      public function get hasFreeStep() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set freeStep(param1:int) : void
      {
         hasField$0 |= 2;
         freeStep$field = param1;
      }
      
      public function get freeStep() : int
      {
         return freeStep$field;
      }
      
      public function removeBuyStep() : void
      {
         hasField$0 &= 4294967291;
         buyStep$field = new int();
      }
      
      public function get hasBuyStep() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set buyStep(param1:int) : void
      {
         hasField$0 |= 4;
         buyStep$field = param1;
      }
      
      public function get buyStep() : int
      {
         return buyStep$field;
      }
      
      public function removeBuyCount() : void
      {
         hasField$0 &= 4294967287;
         buyCount$field = new int();
      }
      
      public function get hasBuyCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set buyCount(param1:int) : void
      {
         hasField$0 |= 8;
         buyCount$field = param1;
      }
      
      public function get buyCount() : int
      {
         return buyCount$field;
      }
      
      public function removeDropInfo() : void
      {
         dropInfo$field = null;
      }
      
      public function get hasDropInfo() : Boolean
      {
         return dropInfo$field != null;
      }
      
      public function set dropInfo(param1:String) : void
      {
         dropInfo$field = param1;
      }
      
      public function get dropInfo() : String
      {
         return dropInfo$field;
      }
      
      public function removePosInfo() : void
      {
         posInfo$field = null;
      }
      
      public function get hasPosInfo() : Boolean
      {
         return posInfo$field != null;
      }
      
      public function set posInfo(param1:String) : void
      {
         posInfo$field = param1;
      }
      
      public function get posInfo() : String
      {
         return posInfo$field;
      }
      
      public function removeSpecialInfo() : void
      {
         specialInfo$field = null;
      }
      
      public function get hasSpecialInfo() : Boolean
      {
         return specialInfo$field != null;
      }
      
      public function set specialInfo(param1:String) : void
      {
         specialInfo$field = param1;
      }
      
      public function get specialInfo() : String
      {
         return specialInfo$field;
      }
      
      public function removeCanRefresh() : void
      {
         hasField$0 &= 4294967279;
         canRefresh$field = new Boolean();
      }
      
      public function get hasCanRefresh() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set canRefresh(param1:Boolean) : void
      {
         hasField$0 |= 16;
         canRefresh$field = param1;
      }
      
      public function get canRefresh() : Boolean
      {
         return canRefresh$field;
      }
      
      public function removeIsMatch() : void
      {
         hasField$0 &= 4294967263;
         isMatch$field = new Boolean();
      }
      
      public function get hasIsMatch() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set isMatch(param1:Boolean) : void
      {
         hasField$0 |= 32;
         isMatch$field = param1;
      }
      
      public function get isMatch() : Boolean
      {
         return isMatch$field;
      }
      
      public function removeResult() : void
      {
         result$field = null;
      }
      
      public function get hasResult() : Boolean
      {
         return result$field != null;
      }
      
      public function set result(param1:String) : void
      {
         result$field = param1;
      }
      
      public function get result() : String
      {
         return result$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,opType$field);
         }
         if(hasFreeStep)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,freeStep$field);
         }
         if(hasBuyStep)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,buyStep$field);
         }
         if(hasBuyCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,buyCount$field);
         }
         if(hasDropInfo)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,dropInfo$field);
         }
         if(hasPosInfo)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,posInfo$field);
         }
         if(hasSpecialInfo)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,specialInfo$field);
         }
         if(hasCanRefresh)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,canRefresh$field);
         }
         if(hasIsMatch)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_BOOL(param1,isMatch$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,result$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc13_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc11_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: NewMemoryCardMsg.opType cannot be set twice.");
                  }
                  _loc8_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: NewMemoryCardMsg.freeStep cannot be set twice.");
                  }
                  _loc4_++;
                  freeStep = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: NewMemoryCardMsg.buyStep cannot be set twice.");
                  }
                  _loc9_++;
                  buyStep = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: NewMemoryCardMsg.buyCount cannot be set twice.");
                  }
                  _loc10_++;
                  buyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: NewMemoryCardMsg.dropInfo cannot be set twice.");
                  }
                  _loc3_++;
                  dropInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: NewMemoryCardMsg.posInfo cannot be set twice.");
                  }
                  _loc13_++;
                  posInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: NewMemoryCardMsg.specialInfo cannot be set twice.");
                  }
                  _loc6_++;
                  specialInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: NewMemoryCardMsg.canRefresh cannot be set twice.");
                  }
                  _loc5_++;
                  canRefresh = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 8:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: NewMemoryCardMsg.isMatch cannot be set twice.");
                  }
                  _loc11_++;
                  isMatch = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 9:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: NewMemoryCardMsg.result cannot be set twice.");
                  }
                  _loc7_++;
                  result = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

