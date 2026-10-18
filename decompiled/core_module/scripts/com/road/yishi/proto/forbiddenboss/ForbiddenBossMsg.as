package com.road.yishi.proto.forbiddenboss
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ForbiddenBossMsg extends Message implements IExternalizable
   {
      
      private var bossId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var state$field:int;
      
      private var refreshTime$field:String;
      
      private var hp$field:Int64;
      
      private var maxHp$field:Int64;
      
      private var endTime$field:Int64;
      
      public function ForbiddenBossMsg()
      {
         super();
      }
      
      public function removeBossId() : void
      {
         hasField$0 &= 4294967294;
         bossId$field = new int();
      }
      
      public function get hasBossId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set bossId(param1:int) : void
      {
         hasField$0 |= 1;
         bossId$field = param1;
      }
      
      public function get bossId() : int
      {
         return bossId$field;
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
      
      public function removeRefreshTime() : void
      {
         refreshTime$field = null;
      }
      
      public function get hasRefreshTime() : Boolean
      {
         return refreshTime$field != null;
      }
      
      public function set refreshTime(param1:String) : void
      {
         refreshTime$field = param1;
      }
      
      public function get refreshTime() : String
      {
         return refreshTime$field;
      }
      
      public function removeHp() : void
      {
         hp$field = null;
      }
      
      public function get hasHp() : Boolean
      {
         return hp$field != null;
      }
      
      public function set hp(param1:Int64) : void
      {
         hp$field = param1;
      }
      
      public function get hp() : Int64
      {
         return hp$field;
      }
      
      public function removeMaxHp() : void
      {
         maxHp$field = null;
      }
      
      public function get hasMaxHp() : Boolean
      {
         return maxHp$field != null;
      }
      
      public function set maxHp(param1:Int64) : void
      {
         maxHp$field = param1;
      }
      
      public function get maxHp() : Int64
      {
         return maxHp$field;
      }
      
      public function removeEndTime() : void
      {
         endTime$field = null;
      }
      
      public function get hasEndTime() : Boolean
      {
         return endTime$field != null;
      }
      
      public function set endTime(param1:Int64) : void
      {
         endTime$field = param1;
      }
      
      public function get endTime() : Int64
      {
         return endTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasBossId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,bossId$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasRefreshTime)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,refreshTime$field);
         }
         if(hasHp)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT64(param1,hp$field);
         }
         if(hasMaxHp)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT64(param1,maxHp$field);
         }
         if(hasEndTime)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT64(param1,endTime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ForbiddenBossMsg.bossId cannot be set twice.");
                  }
                  _loc4_++;
                  bossId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ForbiddenBossMsg.state cannot be set twice.");
                  }
                  _loc5_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ForbiddenBossMsg.refreshTime cannot be set twice.");
                  }
                  _loc9_++;
                  refreshTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ForbiddenBossMsg.hp cannot be set twice.");
                  }
                  _loc6_++;
                  hp = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ForbiddenBossMsg.maxHp cannot be set twice.");
                  }
                  _loc7_++;
                  maxHp = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ForbiddenBossMsg.endTime cannot be set twice.");
                  }
                  _loc3_++;
                  endTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

