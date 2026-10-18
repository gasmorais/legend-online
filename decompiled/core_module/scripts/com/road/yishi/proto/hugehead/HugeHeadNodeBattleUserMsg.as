package com.road.yishi.proto.hugehead
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HugeHeadNodeBattleUserMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var user_uid$field:String;
      
      private var pos$field:int;
      
      private var cool_down$field:int;
      
      private var side$field:int;
      
      private var in_guard$field:Boolean;
      
      private var node_battle_field_uid$field:String;
      
      public function HugeHeadNodeBattleUserMsg()
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
      
      public function removePos() : void
      {
         hasField$0 &= 4294967293;
         pos$field = new int();
      }
      
      public function get hasPos() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set pos(param1:int) : void
      {
         hasField$0 |= 2;
         pos$field = param1;
      }
      
      public function get pos() : int
      {
         return pos$field;
      }
      
      public function removeCoolDown() : void
      {
         hasField$0 &= 4294967291;
         cool_down$field = new int();
      }
      
      public function get hasCoolDown() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set coolDown(param1:int) : void
      {
         hasField$0 |= 4;
         cool_down$field = param1;
      }
      
      public function get coolDown() : int
      {
         return cool_down$field;
      }
      
      public function removeSide() : void
      {
         hasField$0 &= 4294967287;
         side$field = new int();
      }
      
      public function get hasSide() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set side(param1:int) : void
      {
         hasField$0 |= 8;
         side$field = param1;
      }
      
      public function get side() : int
      {
         return side$field;
      }
      
      public function removeInGuard() : void
      {
         hasField$0 &= 4294967279;
         in_guard$field = new Boolean();
      }
      
      public function get hasInGuard() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set inGuard(param1:Boolean) : void
      {
         hasField$0 |= 16;
         in_guard$field = param1;
      }
      
      public function get inGuard() : Boolean
      {
         return in_guard$field;
      }
      
      public function removeNodeBattleFieldUid() : void
      {
         node_battle_field_uid$field = null;
      }
      
      public function get hasNodeBattleFieldUid() : Boolean
      {
         return node_battle_field_uid$field != null;
      }
      
      public function set nodeBattleFieldUid(param1:String) : void
      {
         node_battle_field_uid$field = param1;
      }
      
      public function get nodeBattleFieldUid() : String
      {
         return node_battle_field_uid$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasUserUid)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,user_uid$field);
         }
         if(hasPos)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pos$field);
         }
         if(hasCoolDown)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,cool_down$field);
         }
         if(hasSide)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,side$field);
         }
         if(hasInGuard)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_BOOL(param1,in_guard$field);
         }
         if(hasNodeBattleFieldUid)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,node_battle_field_uid$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc10_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadNodeBattleUserMsg.op cannot be set twice.");
                  }
                  _loc10_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadNodeBattleUserMsg.userUid cannot be set twice.");
                  }
                  _loc6_++;
                  userUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadNodeBattleUserMsg.pos cannot be set twice.");
                  }
                  _loc7_++;
                  pos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadNodeBattleUserMsg.coolDown cannot be set twice.");
                  }
                  _loc9_++;
                  coolDown = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadNodeBattleUserMsg.side cannot be set twice.");
                  }
                  _loc3_++;
                  side = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadNodeBattleUserMsg.inGuard cannot be set twice.");
                  }
                  _loc5_++;
                  inGuard = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadNodeBattleUserMsg.nodeBattleFieldUid cannot be set twice.");
                  }
                  _loc4_++;
                  nodeBattleFieldUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

