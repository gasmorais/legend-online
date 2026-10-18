package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaTreasureOpMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var payType$field:int;
      
      private var treasureId$field:int;
      
      private var errorID$field:int;
      
      private var teasurePageInfo$field:TreasurePageMsg;
      
      [ArrayElementType("com.road.yishi.proto.consortia.MyTreasuresMsg")]
      public var myTreasures:Array = [];
      
      private var helpList$field:HelpListPageMsg;
      
      public function ConsortiaTreasureOpMsg()
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
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967293;
         payType$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 2;
         payType$field = param1;
      }
      
      public function get payType() : int
      {
         return payType$field;
      }
      
      public function removeTreasureId() : void
      {
         hasField$0 &= 4294967291;
         treasureId$field = new int();
      }
      
      public function get hasTreasureId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set treasureId(param1:int) : void
      {
         hasField$0 |= 4;
         treasureId$field = param1;
      }
      
      public function get treasureId() : int
      {
         return treasureId$field;
      }
      
      public function removeErrorID() : void
      {
         hasField$0 &= 4294967287;
         errorID$field = new int();
      }
      
      public function get hasErrorID() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set errorID(param1:int) : void
      {
         hasField$0 |= 8;
         errorID$field = param1;
      }
      
      public function get errorID() : int
      {
         return errorID$field;
      }
      
      public function removeTeasurePageInfo() : void
      {
         teasurePageInfo$field = null;
      }
      
      public function get hasTeasurePageInfo() : Boolean
      {
         return teasurePageInfo$field != null;
      }
      
      public function set teasurePageInfo(param1:TreasurePageMsg) : void
      {
         teasurePageInfo$field = param1;
      }
      
      public function get teasurePageInfo() : TreasurePageMsg
      {
         return teasurePageInfo$field;
      }
      
      public function removeHelpList() : void
      {
         helpList$field = null;
      }
      
      public function get hasHelpList() : Boolean
      {
         return helpList$field != null;
      }
      
      public function set helpList(param1:HelpListPageMsg) : void
      {
         helpList$field = param1;
      }
      
      public function get helpList() : HelpListPageMsg
      {
         return helpList$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_ENUM(param1,op$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,payType$field);
         }
         if(hasTreasureId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,treasureId$field);
         }
         if(hasErrorID)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_ENUM(param1,errorID$field);
         }
         if(hasTeasurePageInfo)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,teasurePageInfo$field);
         }
         _loc2_ = 0;
         while(_loc2_ < myTreasures.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,myTreasures[_loc2_]);
            _loc2_++;
         }
         if(hasHelpList)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,helpList$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc5_:MyTreasuresMsg = null;
         var _loc10_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaTreasureOpMsg.op cannot be set twice.");
                  }
                  _loc10_++;
                  op = ReadUtils.read$TYPE_ENUM(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaTreasureOpMsg.payType cannot be set twice.");
                  }
                  _loc6_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaTreasureOpMsg.treasureId cannot be set twice.");
                  }
                  _loc3_++;
                  treasureId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaTreasureOpMsg.errorID cannot be set twice.");
                  }
                  _loc8_++;
                  errorID = ReadUtils.read$TYPE_ENUM(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaTreasureOpMsg.teasurePageInfo cannot be set twice.");
                  }
                  _loc7_++;
                  teasurePageInfo = new TreasurePageMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,teasurePageInfo);
                  break;
               case 5:
                  _loc5_ = new MyTreasuresMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  myTreasures.push(_loc5_);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaTreasureOpMsg.helpList cannot be set twice.");
                  }
                  _loc4_++;
                  helpList = new HelpListPageMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,helpList);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

