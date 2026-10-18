package com.road.yishi.proto.battle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class WaitReviveMsg extends Message implements IExternalizable
   {
      
      private var battle_id$field:String;
      
      private var living_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var sp$field:int;
      
      private var hp$field:int;
      
      public function WaitReviveMsg()
      {
         super();
      }
      
      public function removeBattleId() : void
      {
         battle_id$field = null;
      }
      
      public function get hasBattleId() : Boolean
      {
         return battle_id$field != null;
      }
      
      public function set battleId(param1:String) : void
      {
         battle_id$field = param1;
      }
      
      public function get battleId() : String
      {
         return battle_id$field;
      }
      
      public function removeLivingId() : void
      {
         hasField$0 &= 4294967294;
         living_id$field = new int();
      }
      
      public function get hasLivingId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set livingId(param1:int) : void
      {
         hasField$0 |= 1;
         living_id$field = param1;
      }
      
      public function get livingId() : int
      {
         return living_id$field;
      }
      
      public function removeSp() : void
      {
         hasField$0 &= 4294967293;
         sp$field = new int();
      }
      
      public function get hasSp() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set sp(param1:int) : void
      {
         hasField$0 |= 2;
         sp$field = param1;
      }
      
      public function get sp() : int
      {
         return sp$field;
      }
      
      public function removeHp() : void
      {
         hasField$0 &= 4294967291;
         hp$field = new int();
      }
      
      public function get hasHp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set hp(param1:int) : void
      {
         hasField$0 |= 4;
         hp$field = param1;
      }
      
      public function get hp() : int
      {
         return hp$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasBattleId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,battle_id$field);
         }
         if(hasLivingId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,living_id$field);
         }
         if(hasSp)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,sp$field);
         }
         if(hasHp)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,hp$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: WaitReviveMsg.battleId cannot be set twice.");
                  }
                  _loc5_++;
                  battleId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: WaitReviveMsg.livingId cannot be set twice.");
                  }
                  _loc6_++;
                  livingId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: WaitReviveMsg.sp cannot be set twice.");
                  }
                  _loc7_++;
                  sp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: WaitReviveMsg.hp cannot be set twice.");
                  }
                  _loc3_++;
                  hp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

