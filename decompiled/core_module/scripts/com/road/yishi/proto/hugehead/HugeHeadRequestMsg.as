package com.road.yishi.proto.hugehead
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HugeHeadRequestMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var node_id$field:int;
      
      private var side$field:int;
      
      private var notice$field:String;
      
      private var user_uid$field:String;
      
      private var battle_field_uid$field:String;
      
      public function HugeHeadRequestMsg()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeNodeId() : void
      {
         hasField$0 &= 4294967293;
         node_id$field = new int();
      }
      
      public function get hasNodeId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set nodeId(param1:int) : void
      {
         hasField$0 |= 2;
         node_id$field = param1;
      }
      
      public function get nodeId() : int
      {
         return node_id$field;
      }
      
      public function removeSide() : void
      {
         hasField$0 &= 4294967291;
         side$field = new int();
      }
      
      public function get hasSide() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set side(param1:int) : void
      {
         hasField$0 |= 4;
         side$field = param1;
      }
      
      public function get side() : int
      {
         return side$field;
      }
      
      public function removeNotice() : void
      {
         notice$field = null;
      }
      
      public function get hasNotice() : Boolean
      {
         return notice$field != null;
      }
      
      public function set notice(param1:String) : void
      {
         notice$field = param1;
      }
      
      public function get notice() : String
      {
         return notice$field;
      }
      
      public function removeUserUid() : void
      {
         user_uid$field = null;
      }
      
      public function get hasUserUid() : Boolean
      {
         return user_uid$field != null;
      }
      
      public function set userUid(param1:String) : void
      {
         user_uid$field = param1;
      }
      
      public function get userUid() : String
      {
         return user_uid$field;
      }
      
      public function removeBattleFieldUid() : void
      {
         battle_field_uid$field = null;
      }
      
      public function get hasBattleFieldUid() : Boolean
      {
         return battle_field_uid$field != null;
      }
      
      public function set battleFieldUid(param1:String) : void
      {
         battle_field_uid$field = param1;
      }
      
      public function get battleFieldUid() : String
      {
         return battle_field_uid$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasNodeId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,node_id$field);
         }
         if(hasSide)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,side$field);
         }
         if(hasNotice)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,notice$field);
         }
         if(hasUserUid)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,user_uid$field);
         }
         if(hasBattleFieldUid)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,battle_field_uid$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadRequestMsg.op cannot be set twice.");
                  }
                  _loc9_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadRequestMsg.nodeId cannot be set twice.");
                  }
                  _loc7_++;
                  nodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadRequestMsg.side cannot be set twice.");
                  }
                  _loc3_++;
                  side = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadRequestMsg.notice cannot be set twice.");
                  }
                  _loc4_++;
                  notice = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadRequestMsg.userUid cannot be set twice.");
                  }
                  _loc5_++;
                  userUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadRequestMsg.battleFieldUid cannot be set twice.");
                  }
                  _loc6_++;
                  battleFieldUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

