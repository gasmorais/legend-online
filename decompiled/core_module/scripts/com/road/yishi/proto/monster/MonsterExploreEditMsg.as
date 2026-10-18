package com.road.yishi.proto.monster
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MonsterExploreEditMsg extends Message implements IExternalizable
   {
      
      private var index$field:int;
      
      private var hasField$0:uint = 0;
      
      private var monsterId$field:int;
      
      private var fightPos$field:int;
      
      private var isCaptain$field:Boolean;
      
      public function MonsterExploreEditMsg()
      {
         super();
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
      
      public function removeMonsterId() : void
      {
         hasField$0 &= 4294967293;
         monsterId$field = new int();
      }
      
      public function get hasMonsterId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set monsterId(param1:int) : void
      {
         hasField$0 |= 2;
         monsterId$field = param1;
      }
      
      public function get monsterId() : int
      {
         return monsterId$field;
      }
      
      public function removeFightPos() : void
      {
         hasField$0 &= 4294967291;
         fightPos$field = new int();
      }
      
      public function get hasFightPos() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set fightPos(param1:int) : void
      {
         hasField$0 |= 4;
         fightPos$field = param1;
      }
      
      public function get fightPos() : int
      {
         return fightPos$field;
      }
      
      public function removeIsCaptain() : void
      {
         hasField$0 &= 4294967287;
         isCaptain$field = new Boolean();
      }
      
      public function get hasIsCaptain() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isCaptain(param1:Boolean) : void
      {
         hasField$0 |= 8;
         isCaptain$field = param1;
      }
      
      public function get isCaptain() : Boolean
      {
         return isCaptain$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
         if(hasMonsterId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,monsterId$field);
         }
         if(hasFightPos)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,fightPos$field);
         }
         if(hasIsCaptain)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,isCaptain$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterExploreEditMsg.index cannot be set twice.");
                  }
                  _loc3_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterExploreEditMsg.monsterId cannot be set twice.");
                  }
                  _loc7_++;
                  monsterId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterExploreEditMsg.fightPos cannot be set twice.");
                  }
                  _loc4_++;
                  fightPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterExploreEditMsg.isCaptain cannot be set twice.");
                  }
                  _loc5_++;
                  isCaptain = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

