package com.road.yishi.proto.avenger
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DarkMazeChildMsg extends Message implements IExternalizable
   {
      
      private var childId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var hp$field:int;
      
      private var maxHp$field:int;
      
      private var fightPower$field:int;
      
      public function DarkMazeChildMsg()
      {
         super();
      }
      
      public function removeChildId() : void
      {
         hasField$0 &= 4294967294;
         childId$field = new int();
      }
      
      public function get hasChildId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set childId(param1:int) : void
      {
         hasField$0 |= 1;
         childId$field = param1;
      }
      
      public function get childId() : int
      {
         return childId$field;
      }
      
      public function removeHp() : void
      {
         hasField$0 &= 4294967293;
         hp$field = new int();
      }
      
      public function get hasHp() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set hp(param1:int) : void
      {
         hasField$0 |= 2;
         hp$field = param1;
      }
      
      public function get hp() : int
      {
         return hp$field;
      }
      
      public function removeMaxHp() : void
      {
         hasField$0 &= 4294967291;
         maxHp$field = new int();
      }
      
      public function get hasMaxHp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set maxHp(param1:int) : void
      {
         hasField$0 |= 4;
         maxHp$field = param1;
      }
      
      public function get maxHp() : int
      {
         return maxHp$field;
      }
      
      public function removeFightPower() : void
      {
         hasField$0 &= 4294967287;
         fightPower$field = new int();
      }
      
      public function get hasFightPower() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set fightPower(param1:int) : void
      {
         hasField$0 |= 8;
         fightPower$field = param1;
      }
      
      public function get fightPower() : int
      {
         return fightPower$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasChildId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,childId$field);
         }
         if(hasHp)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,hp$field);
         }
         if(hasMaxHp)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,maxHp$field);
         }
         if(hasFightPower)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,fightPower$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DarkMazeChildMsg.childId cannot be set twice.");
                  }
                  _loc4_++;
                  childId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: DarkMazeChildMsg.hp cannot be set twice.");
                  }
                  _loc5_++;
                  hp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: DarkMazeChildMsg.maxHp cannot be set twice.");
                  }
                  _loc6_++;
                  maxHp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DarkMazeChildMsg.fightPower cannot be set twice.");
                  }
                  _loc3_++;
                  fightPower = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

