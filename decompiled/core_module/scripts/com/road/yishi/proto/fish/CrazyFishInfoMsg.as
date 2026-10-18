package com.road.yishi.proto.fish
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CrazyFishInfoMsg extends Message implements IExternalizable
   {
      
      private var fishId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var angle$field:Int64;
      
      private var frame$field:int;
      
      public function CrazyFishInfoMsg()
      {
         super();
      }
      
      public function removeFishId() : void
      {
         hasField$0 &= 4294967294;
         fishId$field = new int();
      }
      
      public function get hasFishId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set fishId(param1:int) : void
      {
         hasField$0 |= 1;
         fishId$field = param1;
      }
      
      public function get fishId() : int
      {
         return fishId$field;
      }
      
      public function removeAngle() : void
      {
         angle$field = null;
      }
      
      public function get hasAngle() : Boolean
      {
         return angle$field != null;
      }
      
      public function set angle(param1:Int64) : void
      {
         angle$field = param1;
      }
      
      public function get angle() : Int64
      {
         return angle$field;
      }
      
      public function removeFrame() : void
      {
         hasField$0 &= 4294967293;
         frame$field = new int();
      }
      
      public function get hasFrame() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set frame(param1:int) : void
      {
         hasField$0 |= 2;
         frame$field = param1;
      }
      
      public function get frame() : int
      {
         return frame$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasFishId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,fishId$field);
         }
         if(hasAngle)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT64(param1,angle$field);
         }
         if(hasFrame)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,frame$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CrazyFishInfoMsg.fishId cannot be set twice.");
                  }
                  _loc3_++;
                  fishId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CrazyFishInfoMsg.angle cannot be set twice.");
                  }
                  _loc5_++;
                  angle = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CrazyFishInfoMsg.frame cannot be set twice.");
                  }
                  _loc4_++;
                  frame = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

