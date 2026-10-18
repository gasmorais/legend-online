package com.road.yishi.proto.redemptionroad
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RedemptionRoadLayerMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var layer$field:int;
      
      private var pos$field:int;
      
      private var buff$field:int;
      
      private var debuff$field:int;
      
      private var boss$field:String;
      
      private var npc$field:String;
      
      private var reward$field:String;
      
      public function RedemptionRoadLayerMsg()
      {
         super();
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967294;
         id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 1;
         id$field = param1;
      }
      
      public function get id() : int
      {
         return id$field;
      }
      
      public function removeLayer() : void
      {
         hasField$0 &= 4294967293;
         layer$field = new int();
      }
      
      public function get hasLayer() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set layer(param1:int) : void
      {
         hasField$0 |= 2;
         layer$field = param1;
      }
      
      public function get layer() : int
      {
         return layer$field;
      }
      
      public function removePos() : void
      {
         hasField$0 &= 4294967291;
         pos$field = new int();
      }
      
      public function get hasPos() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set pos(param1:int) : void
      {
         hasField$0 |= 4;
         pos$field = param1;
      }
      
      public function get pos() : int
      {
         return pos$field;
      }
      
      public function removeBuff() : void
      {
         hasField$0 &= 4294967287;
         buff$field = new int();
      }
      
      public function get hasBuff() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set buff(param1:int) : void
      {
         hasField$0 |= 8;
         buff$field = param1;
      }
      
      public function get buff() : int
      {
         return buff$field;
      }
      
      public function removeDebuff() : void
      {
         hasField$0 &= 4294967279;
         debuff$field = new int();
      }
      
      public function get hasDebuff() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set debuff(param1:int) : void
      {
         hasField$0 |= 16;
         debuff$field = param1;
      }
      
      public function get debuff() : int
      {
         return debuff$field;
      }
      
      public function removeBoss() : void
      {
         boss$field = null;
      }
      
      public function get hasBoss() : Boolean
      {
         return boss$field != null;
      }
      
      public function set boss(param1:String) : void
      {
         boss$field = param1;
      }
      
      public function get boss() : String
      {
         return boss$field;
      }
      
      public function removeNpc() : void
      {
         npc$field = null;
      }
      
      public function get hasNpc() : Boolean
      {
         return npc$field != null;
      }
      
      public function set npc(param1:String) : void
      {
         npc$field = param1;
      }
      
      public function get npc() : String
      {
         return npc$field;
      }
      
      public function removeReward() : void
      {
         reward$field = null;
      }
      
      public function get hasReward() : Boolean
      {
         return reward$field != null;
      }
      
      public function set reward(param1:String) : void
      {
         reward$field = param1;
      }
      
      public function get reward() : String
      {
         return reward$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasLayer)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,layer$field);
         }
         if(hasPos)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pos$field);
         }
         if(hasBuff)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,buff$field);
         }
         if(hasDebuff)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,debuff$field);
         }
         if(hasBoss)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,boss$field);
         }
         if(hasNpc)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,npc$field);
         }
         if(hasReward)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,reward$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc11_:* = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc11_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: RedemptionRoadLayerMsg.id cannot be set twice.");
                  }
                  _loc5_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: RedemptionRoadLayerMsg.layer cannot be set twice.");
                  }
                  _loc6_++;
                  layer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: RedemptionRoadLayerMsg.pos cannot be set twice.");
                  }
                  _loc9_++;
                  pos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RedemptionRoadLayerMsg.buff cannot be set twice.");
                  }
                  _loc3_++;
                  buff = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RedemptionRoadLayerMsg.debuff cannot be set twice.");
                  }
                  _loc4_++;
                  debuff = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: RedemptionRoadLayerMsg.boss cannot be set twice.");
                  }
                  _loc10_++;
                  boss = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: RedemptionRoadLayerMsg.npc cannot be set twice.");
                  }
                  _loc7_++;
                  npc = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: RedemptionRoadLayerMsg.reward cannot be set twice.");
                  }
                  _loc8_++;
                  reward = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc11_ & 7);
            }
         }
      }
   }
}

