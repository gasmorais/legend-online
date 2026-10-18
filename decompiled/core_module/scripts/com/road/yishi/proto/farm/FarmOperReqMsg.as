package com.road.yishi.proto.farm
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FarmOperReqMsg extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var friend_id$field:int;
      
      private var op_type$field:int;
      
      private var pos$field:int;
      
      private var template_id$field:int;
      
      private var pay_type$field:int;
      
      private var bag_pos$field:int;
      
      public function FarmOperReqMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removeFriendId() : void
      {
         hasField$0 &= 4294967293;
         friend_id$field = new int();
      }
      
      public function get hasFriendId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set friendId(param1:int) : void
      {
         hasField$0 |= 2;
         friend_id$field = param1;
      }
      
      public function get friendId() : int
      {
         return friend_id$field;
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967291;
         op_type$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 4;
         op_type$field = param1;
      }
      
      public function get opType() : int
      {
         return op_type$field;
      }
      
      public function removePos() : void
      {
         hasField$0 &= 4294967287;
         pos$field = new int();
      }
      
      public function get hasPos() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set pos(param1:int) : void
      {
         hasField$0 |= 8;
         pos$field = param1;
      }
      
      public function get pos() : int
      {
         return pos$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967279;
         template_id$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 16;
         template_id$field = param1;
      }
      
      public function get templateId() : int
      {
         return template_id$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967263;
         pay_type$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 32;
         pay_type$field = param1;
      }
      
      public function get payType() : int
      {
         return pay_type$field;
      }
      
      public function removeBagPos() : void
      {
         hasField$0 &= 4294967231;
         bag_pos$field = new int();
      }
      
      public function get hasBagPos() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set bagPos(param1:int) : void
      {
         hasField$0 |= 64;
         bag_pos$field = param1;
      }
      
      public function get bagPos() : int
      {
         return bag_pos$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasFriendId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,friend_id$field);
         }
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,op_type$field);
         }
         if(hasPos)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,pos$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,template_id$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,pay_type$field);
         }
         if(hasBagPos)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,bag_pos$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FarmOperReqMsg.userId cannot be set twice.");
                  }
                  _loc4_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FarmOperReqMsg.friendId cannot be set twice.");
                  }
                  _loc5_++;
                  friendId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FarmOperReqMsg.opType cannot be set twice.");
                  }
                  _loc3_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FarmOperReqMsg.pos cannot be set twice.");
                  }
                  _loc6_++;
                  pos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: FarmOperReqMsg.templateId cannot be set twice.");
                  }
                  _loc8_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: FarmOperReqMsg.payType cannot be set twice.");
                  }
                  _loc10_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: FarmOperReqMsg.bagPos cannot be set twice.");
                  }
                  _loc7_++;
                  bagPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

