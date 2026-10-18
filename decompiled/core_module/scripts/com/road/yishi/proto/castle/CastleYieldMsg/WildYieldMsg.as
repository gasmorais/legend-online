package com.road.yishi.proto.castle.CastleYieldMsg
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class WildYieldMsg extends Message implements IExternalizable
   {
      
      private var wild_pox_name$field:String;
      
      private var wild_pox$field:String;
      
      private var wild_grade$field:int;
      
      private var hasField$0:uint = 0;
      
      private var wild_name$field:String;
      
      private var wild_yield$field:int;
      
      private var wild_refresh_time$field:int;
      
      private var map_id$field:int;
      
      private var create_time$field:String;
      
      public function WildYieldMsg()
      {
         super();
      }
      
      public function removeWildPoxName() : void
      {
         wild_pox_name$field = null;
      }
      
      public function get hasWildPoxName() : Boolean
      {
         return wild_pox_name$field != null;
      }
      
      public function set wildPoxName(param1:String) : void
      {
         wild_pox_name$field = param1;
      }
      
      public function get wildPoxName() : String
      {
         return wild_pox_name$field;
      }
      
      public function removeWildPox() : void
      {
         wild_pox$field = null;
      }
      
      public function get hasWildPox() : Boolean
      {
         return wild_pox$field != null;
      }
      
      public function set wildPox(param1:String) : void
      {
         wild_pox$field = param1;
      }
      
      public function get wildPox() : String
      {
         return wild_pox$field;
      }
      
      public function removeWildGrade() : void
      {
         hasField$0 &= 4294967294;
         wild_grade$field = new int();
      }
      
      public function get hasWildGrade() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set wildGrade(param1:int) : void
      {
         hasField$0 |= 1;
         wild_grade$field = param1;
      }
      
      public function get wildGrade() : int
      {
         return wild_grade$field;
      }
      
      public function removeWildName() : void
      {
         wild_name$field = null;
      }
      
      public function get hasWildName() : Boolean
      {
         return wild_name$field != null;
      }
      
      public function set wildName(param1:String) : void
      {
         wild_name$field = param1;
      }
      
      public function get wildName() : String
      {
         return wild_name$field;
      }
      
      public function removeWildYield() : void
      {
         hasField$0 &= 4294967293;
         wild_yield$field = new int();
      }
      
      public function get hasWildYield() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set wildYield(param1:int) : void
      {
         hasField$0 |= 2;
         wild_yield$field = param1;
      }
      
      public function get wildYield() : int
      {
         return wild_yield$field;
      }
      
      public function removeWildRefreshTime() : void
      {
         hasField$0 &= 4294967291;
         wild_refresh_time$field = new int();
      }
      
      public function get hasWildRefreshTime() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set wildRefreshTime(param1:int) : void
      {
         hasField$0 |= 4;
         wild_refresh_time$field = param1;
      }
      
      public function get wildRefreshTime() : int
      {
         return wild_refresh_time$field;
      }
      
      public function removeMapId() : void
      {
         hasField$0 &= 4294967287;
         map_id$field = new int();
      }
      
      public function get hasMapId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set mapId(param1:int) : void
      {
         hasField$0 |= 8;
         map_id$field = param1;
      }
      
      public function get mapId() : int
      {
         return map_id$field;
      }
      
      public function removeCreateTime() : void
      {
         create_time$field = null;
      }
      
      public function get hasCreateTime() : Boolean
      {
         return create_time$field != null;
      }
      
      public function set createTime(param1:String) : void
      {
         create_time$field = param1;
      }
      
      public function get createTime() : String
      {
         return create_time$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasWildPoxName)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,wild_pox_name$field);
         }
         if(hasWildPox)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,wild_pox$field);
         }
         if(hasWildGrade)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,wild_grade$field);
         }
         if(hasWildName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,wild_name$field);
         }
         if(hasWildYield)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,wild_yield$field);
         }
         if(hasWildRefreshTime)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,wild_refresh_time$field);
         }
         if(hasMapId)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,map_id$field);
         }
         if(hasCreateTime)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,create_time$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc11_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: WildYieldMsg.wildPoxName cannot be set twice.");
                  }
                  _loc8_++;
                  wildPoxName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: WildYieldMsg.wildPox cannot be set twice.");
                  }
                  _loc9_++;
                  wildPox = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: WildYieldMsg.wildGrade cannot be set twice.");
                  }
                  _loc3_++;
                  wildGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: WildYieldMsg.wildName cannot be set twice.");
                  }
                  _loc10_++;
                  wildName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: WildYieldMsg.wildYield cannot be set twice.");
                  }
                  _loc4_++;
                  wildYield = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: WildYieldMsg.wildRefreshTime cannot be set twice.");
                  }
                  _loc5_++;
                  wildRefreshTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: WildYieldMsg.mapId cannot be set twice.");
                  }
                  _loc6_++;
                  mapId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: WildYieldMsg.createTime cannot be set twice.");
                  }
                  _loc11_++;
                  createTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

