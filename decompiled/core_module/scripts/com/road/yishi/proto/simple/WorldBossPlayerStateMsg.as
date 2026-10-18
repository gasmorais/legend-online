package com.road.yishi.proto.simple
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class WorldBossPlayerStateMsg extends Message implements IExternalizable
   {
      
      private var army_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var state$field:int;
      
      private var left_time$field:int;
      
      private var server_name$field:String;
      
      private var res_count$field:int;
      
      private var npcNodeId$field:int;
      
      private var templateId$field:int;
      
      public function WorldBossPlayerStateMsg()
      {
         super();
      }
      
      public function removeArmyId() : void
      {
         hasField$0 &= 4294967294;
         army_id$field = new int();
      }
      
      public function get hasArmyId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set armyId(param1:int) : void
      {
         hasField$0 |= 1;
         army_id$field = param1;
      }
      
      public function get armyId() : int
      {
         return army_id$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967293;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 2;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeLeftTime() : void
      {
         hasField$0 &= 4294967291;
         left_time$field = new int();
      }
      
      public function get hasLeftTime() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set leftTime(param1:int) : void
      {
         hasField$0 |= 4;
         left_time$field = param1;
      }
      
      public function get leftTime() : int
      {
         return left_time$field;
      }
      
      public function removeServerName() : void
      {
         server_name$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return server_name$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         server_name$field = param1;
      }
      
      public function get serverName() : String
      {
         return server_name$field;
      }
      
      public function removeResCount() : void
      {
         hasField$0 &= 4294967287;
         res_count$field = new int();
      }
      
      public function get hasResCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set resCount(param1:int) : void
      {
         hasField$0 |= 8;
         res_count$field = param1;
      }
      
      public function get resCount() : int
      {
         return res_count$field;
      }
      
      public function removeNpcNodeId() : void
      {
         hasField$0 &= 4294967279;
         npcNodeId$field = new int();
      }
      
      public function get hasNpcNodeId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set npcNodeId(param1:int) : void
      {
         hasField$0 |= 16;
         npcNodeId$field = param1;
      }
      
      public function get npcNodeId() : int
      {
         return npcNodeId$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967263;
         templateId$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 32;
         templateId$field = param1;
      }
      
      public function get templateId() : int
      {
         return templateId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasArmyId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,army_id$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasLeftTime)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,left_time$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasResCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,res_count$field);
         }
         if(hasNpcNodeId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,npcNodeId$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossPlayerStateMsg.armyId cannot be set twice.");
                  }
                  _loc3_++;
                  armyId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossPlayerStateMsg.state cannot be set twice.");
                  }
                  _loc7_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossPlayerStateMsg.leftTime cannot be set twice.");
                  }
                  _loc6_++;
                  leftTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossPlayerStateMsg.serverName cannot be set twice.");
                  }
                  _loc9_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossPlayerStateMsg.resCount cannot be set twice.");
                  }
                  _loc10_++;
                  resCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossPlayerStateMsg.npcNodeId cannot be set twice.");
                  }
                  _loc4_++;
                  npcNodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: WorldBossPlayerStateMsg.templateId cannot be set twice.");
                  }
                  _loc5_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

