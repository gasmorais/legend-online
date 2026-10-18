package com.road.yishi.proto.giftparty
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GiftPartyMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var teamId$field:int;
      
      private var killUserId$field:int;
      
      private var readyState$field:int;
      
      private var fragQuality$field:int;
      
      private var fragLevel$field:int;
      
      [ArrayElementType("com.road.yishi.proto.giftparty.GiftPartyTeamInfoMsg")]
      public var teamInfo:Array = [];
      
      private var partyCount$field:int;
      
      private var pageIndex$field:int;
      
      private var totalPage$field:int;
      
      private var payType$field:int;
      
      public function GiftPartyMsg()
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
      
      public function removeTeamId() : void
      {
         hasField$0 &= 4294967293;
         teamId$field = new int();
      }
      
      public function get hasTeamId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set teamId(param1:int) : void
      {
         hasField$0 |= 2;
         teamId$field = param1;
      }
      
      public function get teamId() : int
      {
         return teamId$field;
      }
      
      public function removeKillUserId() : void
      {
         hasField$0 &= 4294967291;
         killUserId$field = new int();
      }
      
      public function get hasKillUserId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set killUserId(param1:int) : void
      {
         hasField$0 |= 4;
         killUserId$field = param1;
      }
      
      public function get killUserId() : int
      {
         return killUserId$field;
      }
      
      public function removeReadyState() : void
      {
         hasField$0 &= 4294967287;
         readyState$field = new int();
      }
      
      public function get hasReadyState() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set readyState(param1:int) : void
      {
         hasField$0 |= 8;
         readyState$field = param1;
      }
      
      public function get readyState() : int
      {
         return readyState$field;
      }
      
      public function removeFragQuality() : void
      {
         hasField$0 &= 4294967279;
         fragQuality$field = new int();
      }
      
      public function get hasFragQuality() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set fragQuality(param1:int) : void
      {
         hasField$0 |= 16;
         fragQuality$field = param1;
      }
      
      public function get fragQuality() : int
      {
         return fragQuality$field;
      }
      
      public function removeFragLevel() : void
      {
         hasField$0 &= 4294967263;
         fragLevel$field = new int();
      }
      
      public function get hasFragLevel() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set fragLevel(param1:int) : void
      {
         hasField$0 |= 32;
         fragLevel$field = param1;
      }
      
      public function get fragLevel() : int
      {
         return fragLevel$field;
      }
      
      public function removePartyCount() : void
      {
         hasField$0 &= 4294967231;
         partyCount$field = new int();
      }
      
      public function get hasPartyCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set partyCount(param1:int) : void
      {
         hasField$0 |= 64;
         partyCount$field = param1;
      }
      
      public function get partyCount() : int
      {
         return partyCount$field;
      }
      
      public function removePageIndex() : void
      {
         hasField$0 &= 4294967167;
         pageIndex$field = new int();
      }
      
      public function get hasPageIndex() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set pageIndex(param1:int) : void
      {
         hasField$0 |= 128;
         pageIndex$field = param1;
      }
      
      public function get pageIndex() : int
      {
         return pageIndex$field;
      }
      
      public function removeTotalPage() : void
      {
         hasField$0 &= 4294967039;
         totalPage$field = new int();
      }
      
      public function get hasTotalPage() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set totalPage(param1:int) : void
      {
         hasField$0 |= 256;
         totalPage$field = param1;
      }
      
      public function get totalPage() : int
      {
         return totalPage$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294966783;
         payType$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 512;
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
         if(hasTeamId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,teamId$field);
         }
         if(hasKillUserId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,killUserId$field);
         }
         if(hasReadyState)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,readyState$field);
         }
         if(hasFragQuality)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,fragQuality$field);
         }
         if(hasFragLevel)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,fragLevel$field);
         }
         _loc2_ = 0;
         while(_loc2_ < teamInfo.length)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,teamInfo[_loc2_]);
            _loc2_++;
         }
         if(hasPartyCount)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,partyCount$field);
         }
         if(hasPageIndex)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,pageIndex$field);
         }
         if(hasTotalPage)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,totalPage$field);
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
         var _loc5_:GiftPartyTeamInfoMsg = null;
         var _loc14_:uint = 0;
         var _loc6_:uint = 0;
         var _loc11_:uint = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         var _loc12_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: GiftPartyMsg.op cannot be set twice.");
                  }
                  _loc14_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GiftPartyMsg.teamId cannot be set twice.");
                  }
                  _loc6_++;
                  teamId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: GiftPartyMsg.killUserId cannot be set twice.");
                  }
                  _loc11_++;
                  killUserId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: GiftPartyMsg.readyState cannot be set twice.");
                  }
                  _loc10_++;
                  readyState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GiftPartyMsg.fragQuality cannot be set twice.");
                  }
                  _loc7_++;
                  fragQuality = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: GiftPartyMsg.fragLevel cannot be set twice.");
                  }
                  _loc12_++;
                  fragLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  _loc5_ = new GiftPartyTeamInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  teamInfo.push(_loc5_);
                  break;
               case 7:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GiftPartyMsg.partyCount cannot be set twice.");
                  }
                  _loc4_++;
                  partyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GiftPartyMsg.pageIndex cannot be set twice.");
                  }
                  _loc3_++;
                  pageIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: GiftPartyMsg.totalPage cannot be set twice.");
                  }
                  _loc9_++;
                  totalPage = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: GiftPartyMsg.payType cannot be set twice.");
                  }
                  _loc8_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

