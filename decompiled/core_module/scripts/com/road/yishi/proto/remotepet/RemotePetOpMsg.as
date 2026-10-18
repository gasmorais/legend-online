package com.road.yishi.proto.remotepet
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RemotePetOpMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.remotepet.PetSiteMsg")]
      public var pets:Array = [];
      
      private var pos$field:String;
      
      private var friendId$field:int;
      
      private var friendPetId$field:int;
      
      private var skillId$field:int;
      
      private var index$field:int;
      
      private var isSpecial$field:Boolean;
      
      private var sweepIndex$field:int;
      
      private var isFirst$field:Boolean;
      
      private var payType$field:int;
      
      public function RemotePetOpMsg()
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
      
      public function removePos() : void
      {
         pos$field = null;
      }
      
      public function get hasPos() : Boolean
      {
         return pos$field != null;
      }
      
      public function set pos(param1:String) : void
      {
         pos$field = param1;
      }
      
      public function get pos() : String
      {
         return pos$field;
      }
      
      public function removeFriendId() : void
      {
         hasField$0 &= 4294967293;
         friendId$field = new int();
      }
      
      public function get hasFriendId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set friendId(param1:int) : void
      {
         hasField$0 |= 2;
         friendId$field = param1;
      }
      
      public function get friendId() : int
      {
         return friendId$field;
      }
      
      public function removeFriendPetId() : void
      {
         hasField$0 &= 4294967291;
         friendPetId$field = new int();
      }
      
      public function get hasFriendPetId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set friendPetId(param1:int) : void
      {
         hasField$0 |= 4;
         friendPetId$field = param1;
      }
      
      public function get friendPetId() : int
      {
         return friendPetId$field;
      }
      
      public function removeSkillId() : void
      {
         hasField$0 &= 4294967287;
         skillId$field = new int();
      }
      
      public function get hasSkillId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set skillId(param1:int) : void
      {
         hasField$0 |= 8;
         skillId$field = param1;
      }
      
      public function get skillId() : int
      {
         return skillId$field;
      }
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294967279;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 16;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
      }
      
      public function removeIsSpecial() : void
      {
         hasField$0 &= 4294967263;
         isSpecial$field = new Boolean();
      }
      
      public function get hasIsSpecial() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set isSpecial(param1:Boolean) : void
      {
         hasField$0 |= 32;
         isSpecial$field = param1;
      }
      
      public function get isSpecial() : Boolean
      {
         return isSpecial$field;
      }
      
      public function removeSweepIndex() : void
      {
         hasField$0 &= 4294967231;
         sweepIndex$field = new int();
      }
      
      public function get hasSweepIndex() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set sweepIndex(param1:int) : void
      {
         hasField$0 |= 64;
         sweepIndex$field = param1;
      }
      
      public function get sweepIndex() : int
      {
         return sweepIndex$field;
      }
      
      public function removeIsFirst() : void
      {
         hasField$0 &= 4294967167;
         isFirst$field = new Boolean();
      }
      
      public function get hasIsFirst() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set isFirst(param1:Boolean) : void
      {
         hasField$0 |= 128;
         isFirst$field = param1;
      }
      
      public function get isFirst() : Boolean
      {
         return isFirst$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967039;
         payType$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 256;
         payType$field = param1;
      }
      
      public function get payType() : int
      {
         return payType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         _loc2_ = 0;
         while(_loc2_ < pets.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,pets[_loc2_]);
            _loc2_++;
         }
         if(hasPos)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,pos$field);
         }
         if(hasFriendId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,friendId$field);
         }
         if(hasFriendPetId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,friendPetId$field);
         }
         if(hasSkillId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,skillId$field);
         }
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
         if(hasIsSpecial)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,isSpecial$field);
         }
         if(hasSweepIndex)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,sweepIndex$field);
         }
         if(hasIsFirst)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_BOOL(param1,isFirst$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,payType$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc5_:PetSiteMsg = null;
         var _loc14_:uint = 0;
         var _loc6_:uint = 0;
         var _loc11_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc12_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: RemotePetOpMsg.op cannot be set twice.");
                  }
                  _loc14_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc5_ = new PetSiteMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  pets.push(_loc5_);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: RemotePetOpMsg.pos cannot be set twice.");
                  }
                  _loc6_++;
                  pos = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: RemotePetOpMsg.friendId cannot be set twice.");
                  }
                  _loc11_++;
                  friendId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RemotePetOpMsg.friendPetId cannot be set twice.");
                  }
                  _loc3_++;
                  friendPetId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RemotePetOpMsg.skillId cannot be set twice.");
                  }
                  _loc4_++;
                  skillId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: RemotePetOpMsg.index cannot be set twice.");
                  }
                  _loc8_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: RemotePetOpMsg.isSpecial cannot be set twice.");
                  }
                  _loc9_++;
                  isSpecial = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 8:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: RemotePetOpMsg.sweepIndex cannot be set twice.");
                  }
                  _loc12_++;
                  sweepIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: RemotePetOpMsg.isFirst cannot be set twice.");
                  }
                  _loc7_++;
                  isFirst = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 10:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: RemotePetOpMsg.payType cannot be set twice.");
                  }
                  _loc10_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

