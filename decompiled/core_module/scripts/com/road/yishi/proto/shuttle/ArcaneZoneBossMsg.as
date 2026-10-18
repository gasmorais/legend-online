package com.road.yishi.proto.shuttle
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ArcaneZoneBossMsg extends Message implements IExternalizable
   {
      
      private var boss_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var hero_temp_id$field:int;
      
      private var name$field:String;
      
      private var escape_time$field:Int64;
      
      private var self_found$field:Boolean;
      
      private var hp_percent$field:int;
      
      public function ArcaneZoneBossMsg()
      {
         super();
      }
      
      public function removeBossId() : void
      {
         hasField$0 &= 4294967294;
         boss_id$field = new int();
      }
      
      public function get hasBossId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set bossId(param1:int) : void
      {
         hasField$0 |= 1;
         boss_id$field = param1;
      }
      
      public function get bossId() : int
      {
         return boss_id$field;
      }
      
      public function removeHeroTempId() : void
      {
         hasField$0 &= 4294967293;
         hero_temp_id$field = new int();
      }
      
      public function get hasHeroTempId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set heroTempId(param1:int) : void
      {
         hasField$0 |= 2;
         hero_temp_id$field = param1;
      }
      
      public function get heroTempId() : int
      {
         return hero_temp_id$field;
      }
      
      public function removeName() : void
      {
         name$field = null;
      }
      
      public function get hasName() : Boolean
      {
         return name$field != null;
      }
      
      public function set name(param1:String) : void
      {
         name$field = param1;
      }
      
      public function get name() : String
      {
         return name$field;
      }
      
      public function removeEscapeTime() : void
      {
         escape_time$field = null;
      }
      
      public function get hasEscapeTime() : Boolean
      {
         return escape_time$field != null;
      }
      
      public function set escapeTime(param1:Int64) : void
      {
         escape_time$field = param1;
      }
      
      public function get escapeTime() : Int64
      {
         return escape_time$field;
      }
      
      public function removeSelfFound() : void
      {
         hasField$0 &= 4294967291;
         self_found$field = new Boolean();
      }
      
      public function get hasSelfFound() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set selfFound(param1:Boolean) : void
      {
         hasField$0 |= 4;
         self_found$field = param1;
      }
      
      public function get selfFound() : Boolean
      {
         return self_found$field;
      }
      
      public function removeHpPercent() : void
      {
         hasField$0 &= 4294967287;
         hp_percent$field = new int();
      }
      
      public function get hasHpPercent() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set hpPercent(param1:int) : void
      {
         hasField$0 |= 8;
         hp_percent$field = param1;
      }
      
      public function get hpPercent() : int
      {
         return hp_percent$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasBossId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,boss_id$field);
         }
         if(hasHeroTempId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,hero_temp_id$field);
         }
         if(hasName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,name$field);
         }
         if(hasEscapeTime)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT64(param1,escape_time$field);
         }
         if(hasSelfFound)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,self_found$field);
         }
         if(hasHpPercent)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,hp_percent$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ArcaneZoneBossMsg.bossId cannot be set twice.");
                  }
                  _loc4_++;
                  bossId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ArcaneZoneBossMsg.heroTempId cannot be set twice.");
                  }
                  _loc5_++;
                  heroTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ArcaneZoneBossMsg.name cannot be set twice.");
                  }
                  _loc3_++;
                  name = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ArcaneZoneBossMsg.escapeTime cannot be set twice.");
                  }
                  _loc9_++;
                  escapeTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ArcaneZoneBossMsg.selfFound cannot be set twice.");
                  }
                  _loc7_++;
                  selfFound = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ArcaneZoneBossMsg.hpPercent cannot be set twice.");
                  }
                  _loc6_++;
                  hpPercent = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

