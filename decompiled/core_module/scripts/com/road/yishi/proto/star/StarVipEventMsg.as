package com.road.yishi.proto.star
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StarVipEventMsg extends Message implements IExternalizable
   {
      
      private var golden$field:int;
      
      private var hasField$0:uint = 0;
      
      private var sell_max_quality$field:int;
      
      private var compose_max_quality$field:int;
      
      public function StarVipEventMsg()
      {
         super();
      }
      
      public function removeGolden() : void
      {
         hasField$0 &= 4294967294;
         golden$field = new int();
      }
      
      public function get hasGolden() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set golden(param1:int) : void
      {
         hasField$0 |= 1;
         golden$field = param1;
      }
      
      public function get golden() : int
      {
         return golden$field;
      }
      
      public function removeSellMaxQuality() : void
      {
         hasField$0 &= 4294967293;
         sell_max_quality$field = new int();
      }
      
      public function get hasSellMaxQuality() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set sellMaxQuality(param1:int) : void
      {
         hasField$0 |= 2;
         sell_max_quality$field = param1;
      }
      
      public function get sellMaxQuality() : int
      {
         return sell_max_quality$field;
      }
      
      public function removeComposeMaxQuality() : void
      {
         hasField$0 &= 4294967291;
         compose_max_quality$field = new int();
      }
      
      public function get hasComposeMaxQuality() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set composeMaxQuality(param1:int) : void
      {
         hasField$0 |= 4;
         compose_max_quality$field = param1;
      }
      
      public function get composeMaxQuality() : int
      {
         return compose_max_quality$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasGolden)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,golden$field);
         }
         if(hasSellMaxQuality)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,sell_max_quality$field);
         }
         if(hasComposeMaxQuality)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,compose_max_quality$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: StarVipEventMsg.golden cannot be set twice.");
                  }
                  _loc3_++;
                  golden = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: StarVipEventMsg.sellMaxQuality cannot be set twice.");
                  }
                  _loc4_++;
                  sellMaxQuality = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: StarVipEventMsg.composeMaxQuality cannot be set twice.");
                  }
                  _loc5_++;
                  composeMaxQuality = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

