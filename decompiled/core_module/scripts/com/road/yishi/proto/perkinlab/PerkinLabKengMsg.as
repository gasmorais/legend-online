package com.road.yishi.proto.perkinlab
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.road.yishi.proto.battle.ArmyMsg;
   import com.road.yishi.proto.simple.DetailRspMsg;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PerkinLabKengMsg extends Message implements IExternalizable
   {
      
      private var uid$field:String;
      
      private var server_name$field:String;
      
      private var index$field:int;
      
      private var hasField$0:uint = 0;
      
      private var rival_detail$field:DetailRspMsg;
      
      private var rival_battle_army$field:ArmyMsg;
      
      private var size$field:int;
      
      private var harvest_time$field:Int64;
      
      private var missing_reward$field:String;
      
      private var rob_reward$field:String;
      
      private var rob_state$field:int;
      
      public function PerkinLabKengMsg()
      {
         super();
      }
      
      public function removeUid() : void
      {
         uid$field = null;
      }
      
      public function get hasUid() : Boolean
      {
         return uid$field != null;
      }
      
      public function set uid(param1:String) : void
      {
         uid$field = param1;
      }
      
      public function get uid() : String
      {
         return uid$field;
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
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294967294;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 1;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
      }
      
      public function removeRivalDetail() : void
      {
         rival_detail$field = null;
      }
      
      public function get hasRivalDetail() : Boolean
      {
         return rival_detail$field != null;
      }
      
      public function set rivalDetail(param1:DetailRspMsg) : void
      {
         rival_detail$field = param1;
      }
      
      public function get rivalDetail() : DetailRspMsg
      {
         return rival_detail$field;
      }
      
      public function removeRivalBattleArmy() : void
      {
         rival_battle_army$field = null;
      }
      
      public function get hasRivalBattleArmy() : Boolean
      {
         return rival_battle_army$field != null;
      }
      
      public function set rivalBattleArmy(param1:ArmyMsg) : void
      {
         rival_battle_army$field = param1;
      }
      
      public function get rivalBattleArmy() : ArmyMsg
      {
         return rival_battle_army$field;
      }
      
      public function removeSize() : void
      {
         hasField$0 &= 4294967293;
         size$field = new int();
      }
      
      public function get hasSize() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set size(param1:int) : void
      {
         hasField$0 |= 2;
         size$field = param1;
      }
      
      public function get size() : int
      {
         return size$field;
      }
      
      public function removeHarvestTime() : void
      {
         harvest_time$field = null;
      }
      
      public function get hasHarvestTime() : Boolean
      {
         return harvest_time$field != null;
      }
      
      public function set harvestTime(param1:Int64) : void
      {
         harvest_time$field = param1;
      }
      
      public function get harvestTime() : Int64
      {
         return harvest_time$field;
      }
      
      public function removeMissingReward() : void
      {
         missing_reward$field = null;
      }
      
      public function get hasMissingReward() : Boolean
      {
         return missing_reward$field != null;
      }
      
      public function set missingReward(param1:String) : void
      {
         missing_reward$field = param1;
      }
      
      public function get missingReward() : String
      {
         return missing_reward$field;
      }
      
      public function removeRobReward() : void
      {
         rob_reward$field = null;
      }
      
      public function get hasRobReward() : Boolean
      {
         return rob_reward$field != null;
      }
      
      public function set robReward(param1:String) : void
      {
         rob_reward$field = param1;
      }
      
      public function get robReward() : String
      {
         return rob_reward$field;
      }
      
      public function removeRobState() : void
      {
         hasField$0 &= 4294967291;
         rob_state$field = new int();
      }
      
      public function get hasRobState() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set robState(param1:int) : void
      {
         hasField$0 |= 4;
         rob_state$field = param1;
      }
      
      public function get robState() : int
      {
         return rob_state$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,uid$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
         if(hasRivalDetail)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,rival_detail$field);
         }
         if(hasRivalBattleArmy)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,rival_battle_army$field);
         }
         if(hasSize)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,size$field);
         }
         if(hasHarvestTime)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT64(param1,harvest_time$field);
         }
         if(hasMissingReward)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,missing_reward$field);
         }
         if(hasRobReward)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,rob_reward$field);
         }
         if(hasRobState)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,rob_state$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc13_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc11_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: PerkinLabKengMsg.uid cannot be set twice.");
                  }
                  _loc13_++;
                  uid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PerkinLabKengMsg.serverName cannot be set twice.");
                  }
                  _loc6_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PerkinLabKengMsg.index cannot be set twice.");
                  }
                  _loc7_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PerkinLabKengMsg.rivalDetail cannot be set twice.");
                  }
                  _loc5_++;
                  rivalDetail = new DetailRspMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,rivalDetail);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PerkinLabKengMsg.rivalBattleArmy cannot be set twice.");
                  }
                  _loc8_++;
                  rivalBattleArmy = new ArmyMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,rivalBattleArmy);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PerkinLabKengMsg.size cannot be set twice.");
                  }
                  _loc3_++;
                  size = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PerkinLabKengMsg.harvestTime cannot be set twice.");
                  }
                  _loc9_++;
                  harvestTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 7:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PerkinLabKengMsg.missingReward cannot be set twice.");
                  }
                  _loc10_++;
                  missingReward = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PerkinLabKengMsg.robReward cannot be set twice.");
                  }
                  _loc4_++;
                  robReward = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: PerkinLabKengMsg.robState cannot be set twice.");
                  }
                  _loc11_++;
                  robState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

