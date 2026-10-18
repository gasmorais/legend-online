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
   
   public final class FishInfo extends Message implements IExternalizable
   {
      
      private var fishId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var templateId$field:int;
      
      private var point$field:Boolean;
      
      private var beginTime$field:Int64;
      
      private var channelId$field:int;
      
      private var state$field:int;
      
      private var now$field:Int64;
      
      public function FishInfo()
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
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967293;
         templateId$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 2;
         templateId$field = param1;
      }
      
      public function get templateId() : int
      {
         return templateId$field;
      }
      
      public function removePoint() : void
      {
         hasField$0 &= 4294967291;
         point$field = new Boolean();
      }
      
      public function get hasPoint() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set point(param1:Boolean) : void
      {
         hasField$0 |= 4;
         point$field = param1;
      }
      
      public function get point() : Boolean
      {
         return point$field;
      }
      
      public function removeBeginTime() : void
      {
         beginTime$field = null;
      }
      
      public function get hasBeginTime() : Boolean
      {
         return beginTime$field != null;
      }
      
      public function set beginTime(param1:Int64) : void
      {
         beginTime$field = param1;
      }
      
      public function get beginTime() : Int64
      {
         return beginTime$field;
      }
      
      public function removeChannelId() : void
      {
         hasField$0 &= 4294967287;
         channelId$field = new int();
      }
      
      public function get hasChannelId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set channelId(param1:int) : void
      {
         hasField$0 |= 8;
         channelId$field = param1;
      }
      
      public function get channelId() : int
      {
         return channelId$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967279;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 16;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeNow() : void
      {
         now$field = null;
      }
      
      public function get hasNow() : Boolean
      {
         return now$field != null;
      }
      
      public function set now(param1:Int64) : void
      {
         now$field = param1;
      }
      
      public function get now() : Int64
      {
         return now$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasFishId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,fishId$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasPoint)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,point$field);
         }
         if(hasBeginTime)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT64(param1,beginTime$field);
         }
         if(hasChannelId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,channelId$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasNow)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT64(param1,now$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FishInfo.fishId cannot be set twice.");
                  }
                  _loc3_++;
                  fishId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FishInfo.templateId cannot be set twice.");
                  }
                  _loc5_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: FishInfo.point cannot be set twice.");
                  }
                  _loc7_++;
                  point = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: FishInfo.beginTime cannot be set twice.");
                  }
                  _loc9_++;
                  beginTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: FishInfo.channelId cannot be set twice.");
                  }
                  _loc10_++;
                  channelId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FishInfo.state cannot be set twice.");
                  }
                  _loc6_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FishInfo.now cannot be set twice.");
                  }
                  _loc4_++;
                  now = ReadUtils.read$TYPE_INT64(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

