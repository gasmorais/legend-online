package com.road.yishi.proto.forbiddenboss
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ForbiddenBossKillMsg extends Message implements IExternalizable
   {
      
      private var bossId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var userId$field:int;
      
      private var rankList$field:ForbiddenBossRankListMsg;
      
      private var consortiaId$field:int;
      
      private var kill$field:Boolean;
      
      public function ForbiddenBossKillMsg()
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
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967293;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 2;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeRankList() : void
      {
         rankList$field = null;
      }
      
      public function get hasRankList() : Boolean
      {
         return rankList$field != null;
      }
      
      public function set rankList(param1:ForbiddenBossRankListMsg) : void
      {
         rankList$field = param1;
      }
      
      public function get rankList() : ForbiddenBossRankListMsg
      {
         return rankList$field;
      }
      
      public function removeConsortiaId() : void
      {
         hasField$0 &= 4294967291;
         consortiaId$field = new int();
      }
      
      public function get hasConsortiaId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set consortiaId(param1:int) : void
      {
         hasField$0 |= 4;
         consortiaId$field = param1;
      }
      
      public function get consortiaId() : int
      {
         return consortiaId$field;
      }
      
      public function removeKill() : void
      {
         hasField$0 &= 4294967287;
         kill$field = new Boolean();
      }
      
      public function get hasKill() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set kill(param1:Boolean) : void
      {
         hasField$0 |= 8;
         kill$field = param1;
      }
      
      public function get kill() : Boolean
      {
         return kill$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasBossId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,bossId$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasRankList)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,rankList$field);
         }
         if(hasConsortiaId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,consortiaId$field);
         }
         if(hasKill)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_BOOL(param1,kill$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ForbiddenBossKillMsg.bossId cannot be set twice.");
                  }
                  _loc4_++;
                  bossId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ForbiddenBossKillMsg.userId cannot be set twice.");
                  }
                  _loc7_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ForbiddenBossKillMsg.rankList cannot be set twice.");
                  }
                  _loc6_++;
                  rankList = new ForbiddenBossRankListMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,rankList);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ForbiddenBossKillMsg.consortiaId cannot be set twice.");
                  }
                  _loc5_++;
                  consortiaId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ForbiddenBossKillMsg.kill cannot be set twice.");
                  }
                  _loc3_++;
                  kill = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

