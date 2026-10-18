package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DepositActiveMsg extends Message implements IExternalizable
   {
      
      private var activeId$field:String;
      
      private var title$field:String;
      
      private var contents$field:String;
      
      private var activeType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var description$field:String;
      
      private var actionTimeContent$field:Int64;
      
      private var consortia$field:int;
      
      private var grades$field:int;
      
      private var setStartDate$field:Int64;
      
      private var setEndDate$field:Int64;
      
      private var getStartDate$field:Int64;
      
      private var getEndDate$field:Int64;
      
      private var depositLevel$field:int;
      
      private var depositTime$field:Int64;
      
      private var opType$field:int;
      
      private var opParam$field:int;
      
      [ArrayElementType("com.road.yishi.proto.active.GItemInfoMsg")]
      public var harvestedInfos:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.active.ActiveParamMsg")]
      public var activeParams:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.active.GetLogMsg")]
      public var logs:Array = [];
      
      private var chargePoint$field:int;
      
      private var sort$field:int;
      
      public function DepositActiveMsg()
      {
         super();
      }
      
      public function removeActiveId() : void
      {
         activeId$field = null;
      }
      
      public function get hasActiveId() : Boolean
      {
         return activeId$field != null;
      }
      
      public function set activeId(param1:String) : void
      {
         activeId$field = param1;
      }
      
      public function get activeId() : String
      {
         return activeId$field;
      }
      
      public function removeTitle() : void
      {
         title$field = null;
      }
      
      public function get hasTitle() : Boolean
      {
         return title$field != null;
      }
      
      public function set title(param1:String) : void
      {
         title$field = param1;
      }
      
      public function get title() : String
      {
         return title$field;
      }
      
      public function removeContents() : void
      {
         contents$field = null;
      }
      
      public function get hasContents() : Boolean
      {
         return contents$field != null;
      }
      
      public function set contents(param1:String) : void
      {
         contents$field = param1;
      }
      
      public function get contents() : String
      {
         return contents$field;
      }
      
      public function removeActiveType() : void
      {
         hasField$0 &= 4294967294;
         activeType$field = new int();
      }
      
      public function get hasActiveType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set activeType(param1:int) : void
      {
         hasField$0 |= 1;
         activeType$field = param1;
      }
      
      public function get activeType() : int
      {
         return activeType$field;
      }
      
      public function removeDescription() : void
      {
         description$field = null;
      }
      
      public function get hasDescription() : Boolean
      {
         return description$field != null;
      }
      
      public function set description(param1:String) : void
      {
         description$field = param1;
      }
      
      public function get description() : String
      {
         return description$field;
      }
      
      public function removeActionTimeContent() : void
      {
         actionTimeContent$field = null;
      }
      
      public function get hasActionTimeContent() : Boolean
      {
         return actionTimeContent$field != null;
      }
      
      public function set actionTimeContent(param1:Int64) : void
      {
         actionTimeContent$field = param1;
      }
      
      public function get actionTimeContent() : Int64
      {
         return actionTimeContent$field;
      }
      
      public function removeConsortia() : void
      {
         hasField$0 &= 4294967293;
         consortia$field = new int();
      }
      
      public function get hasConsortia() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set consortia(param1:int) : void
      {
         hasField$0 |= 2;
         consortia$field = param1;
      }
      
      public function get consortia() : int
      {
         return consortia$field;
      }
      
      public function removeGrades() : void
      {
         hasField$0 &= 4294967291;
         grades$field = new int();
      }
      
      public function get hasGrades() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set grades(param1:int) : void
      {
         hasField$0 |= 4;
         grades$field = param1;
      }
      
      public function get grades() : int
      {
         return grades$field;
      }
      
      public function removeSetStartDate() : void
      {
         setStartDate$field = null;
      }
      
      public function get hasSetStartDate() : Boolean
      {
         return setStartDate$field != null;
      }
      
      public function set setStartDate(param1:Int64) : void
      {
         setStartDate$field = param1;
      }
      
      public function get setStartDate() : Int64
      {
         return setStartDate$field;
      }
      
      public function removeSetEndDate() : void
      {
         setEndDate$field = null;
      }
      
      public function get hasSetEndDate() : Boolean
      {
         return setEndDate$field != null;
      }
      
      public function set setEndDate(param1:Int64) : void
      {
         setEndDate$field = param1;
      }
      
      public function get setEndDate() : Int64
      {
         return setEndDate$field;
      }
      
      public function removeGetStartDate() : void
      {
         getStartDate$field = null;
      }
      
      public function get hasGetStartDate() : Boolean
      {
         return getStartDate$field != null;
      }
      
      public function set getStartDate(param1:Int64) : void
      {
         getStartDate$field = param1;
      }
      
      public function get getStartDate() : Int64
      {
         return getStartDate$field;
      }
      
      public function removeGetEndDate() : void
      {
         getEndDate$field = null;
      }
      
      public function get hasGetEndDate() : Boolean
      {
         return getEndDate$field != null;
      }
      
      public function set getEndDate(param1:Int64) : void
      {
         getEndDate$field = param1;
      }
      
      public function get getEndDate() : Int64
      {
         return getEndDate$field;
      }
      
      public function removeDepositLevel() : void
      {
         hasField$0 &= 4294967287;
         depositLevel$field = new int();
      }
      
      public function get hasDepositLevel() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set depositLevel(param1:int) : void
      {
         hasField$0 |= 8;
         depositLevel$field = param1;
      }
      
      public function get depositLevel() : int
      {
         return depositLevel$field;
      }
      
      public function removeDepositTime() : void
      {
         depositTime$field = null;
      }
      
      public function get hasDepositTime() : Boolean
      {
         return depositTime$field != null;
      }
      
      public function set depositTime(param1:Int64) : void
      {
         depositTime$field = param1;
      }
      
      public function get depositTime() : Int64
      {
         return depositTime$field;
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967279;
         opType$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 16;
         opType$field = param1;
      }
      
      public function get opType() : int
      {
         return opType$field;
      }
      
      public function removeOpParam() : void
      {
         hasField$0 &= 4294967263;
         opParam$field = new int();
      }
      
      public function get hasOpParam() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set opParam(param1:int) : void
      {
         hasField$0 |= 32;
         opParam$field = param1;
      }
      
      public function get opParam() : int
      {
         return opParam$field;
      }
      
      public function removeChargePoint() : void
      {
         hasField$0 &= 4294967231;
         chargePoint$field = new int();
      }
      
      public function get hasChargePoint() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set chargePoint(param1:int) : void
      {
         hasField$0 |= 64;
         chargePoint$field = param1;
      }
      
      public function get chargePoint() : int
      {
         return chargePoint$field;
      }
      
      public function removeSort() : void
      {
         hasField$0 &= 4294967167;
         sort$field = new int();
      }
      
      public function get hasSort() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set sort(param1:int) : void
      {
         hasField$0 |= 128;
         sort$field = param1;
      }
      
      public function get sort() : int
      {
         return sort$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         if(hasActiveId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,activeId$field);
         }
         if(hasTitle)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,title$field);
         }
         if(hasContents)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,contents$field);
         }
         if(hasActiveType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,activeType$field);
         }
         if(hasDescription)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,description$field);
         }
         if(hasActionTimeContent)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT64(param1,actionTimeContent$field);
         }
         if(hasConsortia)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,consortia$field);
         }
         if(hasGrades)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,grades$field);
         }
         if(hasSetStartDate)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT64(param1,setStartDate$field);
         }
         if(hasSetEndDate)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT64(param1,setEndDate$field);
         }
         if(hasGetStartDate)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT64(param1,getStartDate$field);
         }
         if(hasGetEndDate)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT64(param1,getEndDate$field);
         }
         if(hasDepositLevel)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,depositLevel$field);
         }
         if(hasDepositTime)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT64(param1,depositTime$field);
         }
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,opType$field);
         }
         if(hasOpParam)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,opParam$field);
         }
         _loc2_ = 0;
         while(_loc2_ < harvestedInfos.length)
         {
            WriteUtils.writeTag(param1,2,17);
            WriteUtils.write$TYPE_MESSAGE(param1,harvestedInfos[_loc2_]);
            _loc2_++;
         }
         _loc4_ = 0;
         while(_loc4_ < activeParams.length)
         {
            WriteUtils.writeTag(param1,2,18);
            WriteUtils.write$TYPE_MESSAGE(param1,activeParams[_loc4_]);
            _loc4_++;
         }
         _loc3_ = 0;
         while(_loc3_ < logs.length)
         {
            WriteUtils.writeTag(param1,2,19);
            WriteUtils.write$TYPE_MESSAGE(param1,logs[_loc3_]);
            _loc3_++;
         }
         if(hasChargePoint)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,chargePoint$field);
         }
         if(hasSort)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,sort$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc23_:* = 0;
         var _loc17_:GItemInfoMsg = null;
         var _loc18_:ActiveParamMsg = null;
         var _loc16_:GetLogMsg = null;
         var _loc21_:uint = 0;
         var _loc8_:uint = 0;
         var _loc13_:uint = 0;
         var _loc11_:uint = 0;
         var _loc20_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc24_:uint = 0;
         var _loc19_:uint = 0;
         var _loc4_:uint = 0;
         var _loc12_:uint = 0;
         var _loc3_:uint = 0;
         var _loc22_:uint = 0;
         var _loc6_:uint = 0;
         var _loc14_:uint = 0;
         var _loc7_:uint = 0;
         var _loc15_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc23_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: DepositActiveMsg.activeId cannot be set twice.");
                  }
                  _loc21_++;
                  activeId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: DepositActiveMsg.title cannot be set twice.");
                  }
                  _loc8_++;
                  title = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: DepositActiveMsg.contents cannot be set twice.");
                  }
                  _loc13_++;
                  contents = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: DepositActiveMsg.activeType cannot be set twice.");
                  }
                  _loc11_++;
                  activeType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: DepositActiveMsg.description cannot be set twice.");
                  }
                  _loc20_++;
                  description = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: DepositActiveMsg.actionTimeContent cannot be set twice.");
                  }
                  _loc5_++;
                  actionTimeContent = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: DepositActiveMsg.consortia cannot be set twice.");
                  }
                  _loc9_++;
                  consortia = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: DepositActiveMsg.grades cannot be set twice.");
                  }
                  _loc24_++;
                  grades = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: DepositActiveMsg.setStartDate cannot be set twice.");
                  }
                  _loc19_++;
                  setStartDate = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 10:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DepositActiveMsg.setEndDate cannot be set twice.");
                  }
                  _loc4_++;
                  setEndDate = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 11:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: DepositActiveMsg.getStartDate cannot be set twice.");
                  }
                  _loc12_++;
                  getStartDate = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 12:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DepositActiveMsg.getEndDate cannot be set twice.");
                  }
                  _loc3_++;
                  getEndDate = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 13:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: DepositActiveMsg.depositLevel cannot be set twice.");
                  }
                  _loc22_++;
                  depositLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: DepositActiveMsg.depositTime cannot be set twice.");
                  }
                  _loc6_++;
                  depositTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 15:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: DepositActiveMsg.opType cannot be set twice.");
                  }
                  _loc14_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: DepositActiveMsg.opParam cannot be set twice.");
                  }
                  _loc7_++;
                  opParam = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  _loc17_ = new GItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc17_);
                  harvestedInfos.push(_loc17_);
                  break;
               case 18:
                  _loc18_ = new ActiveParamMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc18_);
                  activeParams.push(_loc18_);
                  break;
               case 19:
                  _loc16_ = new GetLogMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc16_);
                  logs.push(_loc16_);
                  break;
               case 20:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: DepositActiveMsg.chargePoint cannot be set twice.");
                  }
                  _loc15_++;
                  chargePoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: DepositActiveMsg.sort cannot be set twice.");
                  }
                  _loc10_++;
                  sort = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc23_ & 7);
            }
         }
      }
   }
}

