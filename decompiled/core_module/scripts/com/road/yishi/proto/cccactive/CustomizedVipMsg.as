package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CustomizedVipMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var freeCount$field:int;
      
      private var buyCounts$field:String;
      
      [ArrayElementType("com.road.yishi.proto.cccactive.CustomizedVipBoxMsg")]
      public var boxs:Array = [];
      
      private var boxVersion$field:int;
      
      public function CustomizedVipMsg()
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
      
      public function removeFreeCount() : void
      {
         hasField$0 &= 4294967293;
         freeCount$field = new int();
      }
      
      public function get hasFreeCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set freeCount(param1:int) : void
      {
         hasField$0 |= 2;
         freeCount$field = param1;
      }
      
      public function get freeCount() : int
      {
         return freeCount$field;
      }
      
      public function removeBuyCounts() : void
      {
         buyCounts$field = null;
      }
      
      public function get hasBuyCounts() : Boolean
      {
         return buyCounts$field != null;
      }
      
      public function set buyCounts(param1:String) : void
      {
         buyCounts$field = param1;
      }
      
      public function get buyCounts() : String
      {
         return buyCounts$field;
      }
      
      public function removeBoxVersion() : void
      {
         hasField$0 &= 4294967291;
         boxVersion$field = new int();
      }
      
      public function get hasBoxVersion() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set boxVersion(param1:int) : void
      {
         hasField$0 |= 4;
         boxVersion$field = param1;
      }
      
      public function get boxVersion() : int
      {
         return boxVersion$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasFreeCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,freeCount$field);
         }
         if(hasBuyCounts)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,buyCounts$field);
         }
         _loc2_ = 0;
         while(_loc2_ < boxs.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,boxs[_loc2_]);
            _loc2_++;
         }
         if(hasBoxVersion)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,boxVersion$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:CustomizedVipBoxMsg = null;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CustomizedVipMsg.op cannot be set twice.");
                  }
                  _loc7_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CustomizedVipMsg.freeCount cannot be set twice.");
                  }
                  _loc5_++;
                  freeCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CustomizedVipMsg.buyCounts cannot be set twice.");
                  }
                  _loc3_++;
                  buyCounts = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  _loc4_ = new CustomizedVipBoxMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  boxs.push(_loc4_);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CustomizedVipMsg.boxVersion cannot be set twice.");
                  }
                  _loc8_++;
                  boxVersion = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

