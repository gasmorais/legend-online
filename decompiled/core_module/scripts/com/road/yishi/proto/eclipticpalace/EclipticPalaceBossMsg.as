package com.road.yishi.proto.eclipticpalace
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class EclipticPalaceBossMsg extends Message implements IExternalizable
   {
      
      private var hero_temp_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var defeated$field:Boolean;
      
      private var hidden_event$field:Boolean;
      
      public function EclipticPalaceBossMsg()
      {
         super();
      }
      
      public function removeHeroTempId() : void
      {
         hasField$0 &= 4294967294;
         hero_temp_id$field = new int();
      }
      
      public function get hasHeroTempId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set heroTempId(param1:int) : void
      {
         hasField$0 |= 1;
         hero_temp_id$field = param1;
      }
      
      public function get heroTempId() : int
      {
         return hero_temp_id$field;
      }
      
      public function removeDefeated() : void
      {
         hasField$0 &= 4294967293;
         defeated$field = new Boolean();
      }
      
      public function get hasDefeated() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set defeated(param1:Boolean) : void
      {
         hasField$0 |= 2;
         defeated$field = param1;
      }
      
      public function get defeated() : Boolean
      {
         return defeated$field;
      }
      
      public function removeHiddenEvent() : void
      {
         hasField$0 &= 4294967291;
         hidden_event$field = new Boolean();
      }
      
      public function get hasHiddenEvent() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set hiddenEvent(param1:Boolean) : void
      {
         hasField$0 |= 4;
         hidden_event$field = param1;
      }
      
      public function get hiddenEvent() : Boolean
      {
         return hidden_event$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasHeroTempId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,hero_temp_id$field);
         }
         if(hasDefeated)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,defeated$field);
         }
         if(hasHiddenEvent)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,hidden_event$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: EclipticPalaceBossMsg.heroTempId cannot be set twice.");
                  }
                  _loc4_++;
                  heroTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: EclipticPalaceBossMsg.defeated cannot be set twice.");
                  }
                  _loc3_++;
                  defeated = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: EclipticPalaceBossMsg.hiddenEvent cannot be set twice.");
                  }
                  _loc5_++;
                  hiddenEvent = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

