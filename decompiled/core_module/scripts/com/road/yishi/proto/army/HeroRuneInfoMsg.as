package com.road.yishi.proto.army
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HeroRuneInfoMsg extends Message implements IExternalizable
   {
      
      private var rune_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var rune_gp$field:int;
      
      private var swallowCount$field:int;
      
      private var rune_hole$field:String;
      
      private var temp_hole$field:String;
      
      private var newSkillTempId$field:int;
      
      private var baseProperties$field:BasePropertiesMsg;
      
      public function HeroRuneInfoMsg()
      {
         super();
      }
      
      public function removeRuneId() : void
      {
         hasField$0 &= 4294967294;
         rune_id$field = new int();
      }
      
      public function get hasRuneId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set runeId(param1:int) : void
      {
         hasField$0 |= 1;
         rune_id$field = param1;
      }
      
      public function get runeId() : int
      {
         return rune_id$field;
      }
      
      public function removeRuneGp() : void
      {
         hasField$0 &= 4294967293;
         rune_gp$field = new int();
      }
      
      public function get hasRuneGp() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set runeGp(param1:int) : void
      {
         hasField$0 |= 2;
         rune_gp$field = param1;
      }
      
      public function get runeGp() : int
      {
         return rune_gp$field;
      }
      
      public function removeSwallowCount() : void
      {
         hasField$0 &= 4294967291;
         swallowCount$field = new int();
      }
      
      public function get hasSwallowCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set swallowCount(param1:int) : void
      {
         hasField$0 |= 4;
         swallowCount$field = param1;
      }
      
      public function get swallowCount() : int
      {
         return swallowCount$field;
      }
      
      public function removeRuneHole() : void
      {
         rune_hole$field = null;
      }
      
      public function get hasRuneHole() : Boolean
      {
         return rune_hole$field != null;
      }
      
      public function set runeHole(param1:String) : void
      {
         rune_hole$field = param1;
      }
      
      public function get runeHole() : String
      {
         return rune_hole$field;
      }
      
      public function removeTempHole() : void
      {
         temp_hole$field = null;
      }
      
      public function get hasTempHole() : Boolean
      {
         return temp_hole$field != null;
      }
      
      public function set tempHole(param1:String) : void
      {
         temp_hole$field = param1;
      }
      
      public function get tempHole() : String
      {
         return temp_hole$field;
      }
      
      public function removeNewSkillTempId() : void
      {
         hasField$0 &= 4294967287;
         newSkillTempId$field = new int();
      }
      
      public function get hasNewSkillTempId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set newSkillTempId(param1:int) : void
      {
         hasField$0 |= 8;
         newSkillTempId$field = param1;
      }
      
      public function get newSkillTempId() : int
      {
         return newSkillTempId$field;
      }
      
      public function removeBaseProperties() : void
      {
         baseProperties$field = null;
      }
      
      public function get hasBaseProperties() : Boolean
      {
         return baseProperties$field != null;
      }
      
      public function set baseProperties(param1:BasePropertiesMsg) : void
      {
         baseProperties$field = param1;
      }
      
      public function get baseProperties() : BasePropertiesMsg
      {
         return baseProperties$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRuneId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,rune_id$field);
         }
         if(hasRuneGp)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,rune_gp$field);
         }
         if(hasSwallowCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,swallowCount$field);
         }
         if(hasRuneHole)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,rune_hole$field);
         }
         if(hasTempHole)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,temp_hole$field);
         }
         if(hasNewSkillTempId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,newSkillTempId$field);
         }
         if(hasBaseProperties)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,baseProperties$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: HeroRuneInfoMsg.runeId cannot be set twice.");
                  }
                  _loc5_++;
                  runeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: HeroRuneInfoMsg.runeGp cannot be set twice.");
                  }
                  _loc9_++;
                  runeGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: HeroRuneInfoMsg.swallowCount cannot be set twice.");
                  }
                  _loc7_++;
                  swallowCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: HeroRuneInfoMsg.runeHole cannot be set twice.");
                  }
                  _loc3_++;
                  runeHole = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: HeroRuneInfoMsg.tempHole cannot be set twice.");
                  }
                  _loc10_++;
                  tempHole = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: HeroRuneInfoMsg.newSkillTempId cannot be set twice.");
                  }
                  _loc4_++;
                  newSkillTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: HeroRuneInfoMsg.baseProperties cannot be set twice.");
                  }
                  _loc6_++;
                  baseProperties = new BasePropertiesMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,baseProperties);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

