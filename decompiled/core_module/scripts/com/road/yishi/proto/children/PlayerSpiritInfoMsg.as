package com.road.yishi.proto.children
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlayerSpiritInfoMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var isSuccess$field:Boolean;
      
      private var gpIndex$field:int;
      
      private var resiIndex$field:int;
      
      private var results$field:String;
      
      [ArrayElementType("com.road.yishi.proto.children.SpiritInfoMsg")]
      public var spirits:Array = [];
      
      public function PlayerSpiritInfoMsg()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeIsSuccess() : void
      {
         hasField$0 &= 4294967293;
         isSuccess$field = new Boolean();
      }
      
      public function get hasIsSuccess() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isSuccess(param1:Boolean) : void
      {
         hasField$0 |= 2;
         isSuccess$field = param1;
      }
      
      public function get isSuccess() : Boolean
      {
         return isSuccess$field;
      }
      
      public function removeGpIndex() : void
      {
         hasField$0 &= 4294967291;
         gpIndex$field = new int();
      }
      
      public function get hasGpIndex() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set gpIndex(param1:int) : void
      {
         hasField$0 |= 4;
         gpIndex$field = param1;
      }
      
      public function get gpIndex() : int
      {
         return gpIndex$field;
      }
      
      public function removeResiIndex() : void
      {
         hasField$0 &= 4294967287;
         resiIndex$field = new int();
      }
      
      public function get hasResiIndex() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set resiIndex(param1:int) : void
      {
         hasField$0 |= 8;
         resiIndex$field = param1;
      }
      
      public function get resiIndex() : int
      {
         return resiIndex$field;
      }
      
      public function removeResults() : void
      {
         results$field = null;
      }
      
      public function get hasResults() : Boolean
      {
         return results$field != null;
      }
      
      public function set results(param1:String) : void
      {
         results$field = param1;
      }
      
      public function get results() : String
      {
         return results$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasIsSuccess)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,isSuccess$field);
         }
         if(hasGpIndex)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,gpIndex$field);
         }
         if(hasResiIndex)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,resiIndex$field);
         }
         if(hasResults)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,results$field);
         }
         _loc2_ = 0;
         while(_loc2_ < spirits.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,spirits[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc5_:SpiritInfoMsg = null;
         var _loc9_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerSpiritInfoMsg.op cannot be set twice.");
                  }
                  _loc9_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerSpiritInfoMsg.isSuccess cannot be set twice.");
                  }
                  _loc6_++;
                  isSuccess = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerSpiritInfoMsg.gpIndex cannot be set twice.");
                  }
                  _loc8_++;
                  gpIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerSpiritInfoMsg.resiIndex cannot be set twice.");
                  }
                  _loc3_++;
                  resiIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerSpiritInfoMsg.results cannot be set twice.");
                  }
                  _loc4_++;
                  results = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  _loc5_ = new SpiritInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  spirits.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

