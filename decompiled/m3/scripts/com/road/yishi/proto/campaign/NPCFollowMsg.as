package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class NPCFollowMsg extends Message implements IExternalizable
   {
      
      private var escort_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var follow_id$field:int;
      
      private var cur_posX$field:int;
      
      private var cur_posY$field:int;
      
      public function NPCFollowMsg()
      {
         super();
      }
      
      public function removeEscortId() : void
      {
         hasField$0 &= 4294967294;
         escort_id$field = new int();
      }
      
      public function get hasEscortId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set escortId(param1:int) : void
      {
         hasField$0 |= 1;
         escort_id$field = param1;
      }
      
      public function get escortId() : int
      {
         return escort_id$field;
      }
      
      public function removeFollowId() : void
      {
         hasField$0 &= 4294967293;
         follow_id$field = new int();
      }
      
      public function get hasFollowId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set followId(param1:int) : void
      {
         hasField$0 |= 2;
         follow_id$field = param1;
      }
      
      public function get followId() : int
      {
         return follow_id$field;
      }
      
      public function removeCurPosX() : void
      {
         hasField$0 &= 4294967291;
         cur_posX$field = new int();
      }
      
      public function get hasCurPosX() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set curPosX(param1:int) : void
      {
         hasField$0 |= 4;
         cur_posX$field = param1;
      }
      
      public function get curPosX() : int
      {
         return cur_posX$field;
      }
      
      public function removeCurPosY() : void
      {
         hasField$0 &= 4294967287;
         cur_posY$field = new int();
      }
      
      public function get hasCurPosY() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set curPosY(param1:int) : void
      {
         hasField$0 |= 8;
         cur_posY$field = param1;
      }
      
      public function get curPosY() : int
      {
         return cur_posY$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasEscortId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,escort_id$field);
         }
         if(hasFollowId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,follow_id$field);
         }
         if(hasCurPosX)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,cur_posX$field);
         }
         if(hasCurPosY)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,cur_posY$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = uint(ReadUtils.read$TYPE_UINT32(param1))) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: NPCFollowMsg.escortId cannot be set twice.");
                  }
                  _loc3_++;
                  escortId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: NPCFollowMsg.followId cannot be set twice.");
                  }
                  _loc5_++;
                  followId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: NPCFollowMsg.curPosX cannot be set twice.");
                  }
                  _loc4_++;
                  curPosX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: NPCFollowMsg.curPosY cannot be set twice.");
                  }
                  _loc6_++;
                  curPosY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

