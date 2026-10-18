package com.road.yishi.proto.activity
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class YearActivityMsg extends Message implements IExternalizable
   {
      
      private var opType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var checkinInfo$field:String;
      
      private var buyCheckin$field:Boolean;
      
      private var miniGameState$field:int;
      
      private var boxInfo$field:String;
      
      private var boxLevel$field:int;
      
      private var boxNext$field:Boolean;
      
      private var eggCount$field:int;
      
      private var showInfo$field:String;
      
      private var curDay$field:int;
      
      public function YearActivityMsg()
      {
         super();
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967294;
         opType$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 1;
         opType$field = param1;
      }
      
      public function get opType() : int
      {
         return opType$field;
      }
      
      public function removeCheckinInfo() : void
      {
         checkinInfo$field = null;
      }
      
      public function get hasCheckinInfo() : Boolean
      {
         return checkinInfo$field != null;
      }
      
      public function set checkinInfo(param1:String) : void
      {
         checkinInfo$field = param1;
      }
      
      public function get checkinInfo() : String
      {
         return checkinInfo$field;
      }
      
      public function removeBuyCheckin() : void
      {
         hasField$0 &= 4294967293;
         buyCheckin$field = new Boolean();
      }
      
      public function get hasBuyCheckin() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set buyCheckin(param1:Boolean) : void
      {
         hasField$0 |= 2;
         buyCheckin$field = param1;
      }
      
      public function get buyCheckin() : Boolean
      {
         return buyCheckin$field;
      }
      
      public function removeMiniGameState() : void
      {
         hasField$0 &= 4294967291;
         miniGameState$field = new int();
      }
      
      public function get hasMiniGameState() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set miniGameState(param1:int) : void
      {
         hasField$0 |= 4;
         miniGameState$field = param1;
      }
      
      public function get miniGameState() : int
      {
         return miniGameState$field;
      }
      
      public function removeBoxInfo() : void
      {
         boxInfo$field = null;
      }
      
      public function get hasBoxInfo() : Boolean
      {
         return boxInfo$field != null;
      }
      
      public function set boxInfo(param1:String) : void
      {
         boxInfo$field = param1;
      }
      
      public function get boxInfo() : String
      {
         return boxInfo$field;
      }
      
      public function removeBoxLevel() : void
      {
         hasField$0 &= 4294967287;
         boxLevel$field = new int();
      }
      
      public function get hasBoxLevel() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set boxLevel(param1:int) : void
      {
         hasField$0 |= 8;
         boxLevel$field = param1;
      }
      
      public function get boxLevel() : int
      {
         return boxLevel$field;
      }
      
      public function removeBoxNext() : void
      {
         hasField$0 &= 4294967279;
         boxNext$field = new Boolean();
      }
      
      public function get hasBoxNext() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set boxNext(param1:Boolean) : void
      {
         hasField$0 |= 16;
         boxNext$field = param1;
      }
      
      public function get boxNext() : Boolean
      {
         return boxNext$field;
      }
      
      public function removeEggCount() : void
      {
         hasField$0 &= 4294967263;
         eggCount$field = new int();
      }
      
      public function get hasEggCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set eggCount(param1:int) : void
      {
         hasField$0 |= 32;
         eggCount$field = param1;
      }
      
      public function get eggCount() : int
      {
         return eggCount$field;
      }
      
      public function removeShowInfo() : void
      {
         showInfo$field = null;
      }
      
      public function get hasShowInfo() : Boolean
      {
         return showInfo$field != null;
      }
      
      public function set showInfo(param1:String) : void
      {
         showInfo$field = param1;
      }
      
      public function get showInfo() : String
      {
         return showInfo$field;
      }
      
      public function removeCurDay() : void
      {
         hasField$0 &= 4294967231;
         curDay$field = new int();
      }
      
      public function get hasCurDay() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set curDay(param1:int) : void
      {
         hasField$0 |= 64;
         curDay$field = param1;
      }
      
      public function get curDay() : int
      {
         return curDay$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,opType$field);
         }
         if(hasCheckinInfo)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,checkinInfo$field);
         }
         if(hasBuyCheckin)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,buyCheckin$field);
         }
         if(hasMiniGameState)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,miniGameState$field);
         }
         if(hasBoxInfo)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,boxInfo$field);
         }
         if(hasBoxLevel)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,boxLevel$field);
         }
         if(hasBoxNext)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,boxNext$field);
         }
         if(hasEggCount)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,eggCount$field);
         }
         if(hasShowInfo)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,showInfo$field);
         }
         if(hasCurDay)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,curDay$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc11_:uint = 0;
         var _loc10_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc12_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: YearActivityMsg.opType cannot be set twice.");
                  }
                  _loc7_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: YearActivityMsg.checkinInfo cannot be set twice.");
                  }
                  _loc4_++;
                  checkinInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: YearActivityMsg.buyCheckin cannot be set twice.");
                  }
                  _loc5_++;
                  buyCheckin = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: YearActivityMsg.miniGameState cannot be set twice.");
                  }
                  _loc9_++;
                  miniGameState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: YearActivityMsg.boxInfo cannot be set twice.");
                  }
                  _loc11_++;
                  boxInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: YearActivityMsg.boxLevel cannot be set twice.");
                  }
                  _loc10_++;
                  boxLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: YearActivityMsg.boxNext cannot be set twice.");
                  }
                  _loc6_++;
                  boxNext = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 7:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: YearActivityMsg.eggCount cannot be set twice.");
                  }
                  _loc3_++;
                  eggCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: YearActivityMsg.showInfo cannot be set twice.");
                  }
                  _loc12_++;
                  showInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: YearActivityMsg.curDay cannot be set twice.");
                  }
                  _loc8_++;
                  curDay = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

