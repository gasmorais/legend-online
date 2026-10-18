package com.road.yishi.proto.tattoo
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TattooEnhanceReqMsg extends Message implements IExternalizable
   {
      
      private var holeId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var wish$field:Boolean;
      
      public function TattooEnhanceReqMsg()
      {
         super();
      }
      
      public function removeHoleId() : void
      {
         hasField$0 &= 4294967294;
         holeId$field = new int();
      }
      
      public function get hasHoleId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set holeId(param1:int) : void
      {
         hasField$0 |= 1;
         holeId$field = param1;
      }
      
      public function get holeId() : int
      {
         return holeId$field;
      }
      
      public function removeWish() : void
      {
         hasField$0 &= 4294967293;
         wish$field = new Boolean();
      }
      
      public function get hasWish() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set wish(param1:Boolean) : void
      {
         hasField$0 |= 2;
         wish$field = param1;
      }
      
      public function get wish() : Boolean
      {
         return wish$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasHoleId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,holeId$field);
         }
         if(hasWish)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,wish$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TattooEnhanceReqMsg.holeId cannot be set twice.");
                  }
                  _loc5_++;
                  holeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TattooEnhanceReqMsg.wish cannot be set twice.");
                  }
                  _loc3_++;
                  wish = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

