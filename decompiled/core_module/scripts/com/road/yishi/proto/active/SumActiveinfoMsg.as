package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SumActiveinfoMsg extends Message implements IExternalizable
   {
      
      private var active_id$field:String;
      
      private var begin_date$field:String;
      
      private var end_date$field:String;
      
      private var title$field:String;
      
      private var detail$field:String;
      
      private var condition_detail$field:String;
      
      private var getway$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.active.SumActivePackageMsg")]
      public var packages:Array = [];
      
      private var active_type$field:int;
      
      private var start_time$field:String;
      
      private var stop_time$field:String;
      
      private var order$field:int;
      
      private var appendParam$field:String;
      
      private var isInitiate$field:int;
      
      public function SumActiveinfoMsg()
      {
         super();
      }
      
      public function removeActiveId() : void
      {
         active_id$field = null;
      }
      
      public function get hasActiveId() : Boolean
      {
         return active_id$field != null;
      }
      
      public function set activeId(param1:String) : void
      {
         active_id$field = param1;
      }
      
      public function get activeId() : String
      {
         return active_id$field;
      }
      
      public function removeBeginDate() : void
      {
         begin_date$field = null;
      }
      
      public function get hasBeginDate() : Boolean
      {
         return begin_date$field != null;
      }
      
      public function set beginDate(param1:String) : void
      {
         begin_date$field = param1;
      }
      
      public function get beginDate() : String
      {
         return begin_date$field;
      }
      
      public function removeEndDate() : void
      {
         end_date$field = null;
      }
      
      public function get hasEndDate() : Boolean
      {
         return end_date$field != null;
      }
      
      public function set endDate(param1:String) : void
      {
         end_date$field = param1;
      }
      
      public function get endDate() : String
      {
         return end_date$field;
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
      
      public function removeDetail() : void
      {
         detail$field = null;
      }
      
      public function get hasDetail() : Boolean
      {
         return detail$field != null;
      }
      
      public function set detail(param1:String) : void
      {
         detail$field = param1;
      }
      
      public function get detail() : String
      {
         return detail$field;
      }
      
      public function removeConditionDetail() : void
      {
         condition_detail$field = null;
      }
      
      public function get hasConditionDetail() : Boolean
      {
         return condition_detail$field != null;
      }
      
      public function set conditionDetail(param1:String) : void
      {
         condition_detail$field = param1;
      }
      
      public function get conditionDetail() : String
      {
         return condition_detail$field;
      }
      
      public function removeGetway() : void
      {
         hasField$0 &= 4294967294;
         getway$field = new int();
      }
      
      public function get hasGetway() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set getway(param1:int) : void
      {
         hasField$0 |= 1;
         getway$field = param1;
      }
      
      public function get getway() : int
      {
         return getway$field;
      }
      
      public function removeActiveType() : void
      {
         hasField$0 &= 4294967293;
         active_type$field = new int();
      }
      
      public function get hasActiveType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set activeType(param1:int) : void
      {
         hasField$0 |= 2;
         active_type$field = param1;
      }
      
      public function get activeType() : int
      {
         return active_type$field;
      }
      
      public function removeStartTime() : void
      {
         start_time$field = null;
      }
      
      public function get hasStartTime() : Boolean
      {
         return start_time$field != null;
      }
      
      public function set startTime(param1:String) : void
      {
         start_time$field = param1;
      }
      
      public function get startTime() : String
      {
         return start_time$field;
      }
      
      public function removeStopTime() : void
      {
         stop_time$field = null;
      }
      
      public function get hasStopTime() : Boolean
      {
         return stop_time$field != null;
      }
      
      public function set stopTime(param1:String) : void
      {
         stop_time$field = param1;
      }
      
      public function get stopTime() : String
      {
         return stop_time$field;
      }
      
      public function removeOrder() : void
      {
         hasField$0 &= 4294967291;
         order$field = new int();
      }
      
      public function get hasOrder() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set order(param1:int) : void
      {
         hasField$0 |= 4;
         order$field = param1;
      }
      
      public function get order() : int
      {
         return order$field;
      }
      
      public function removeAppendParam() : void
      {
         appendParam$field = null;
      }
      
      public function get hasAppendParam() : Boolean
      {
         return appendParam$field != null;
      }
      
      public function set appendParam(param1:String) : void
      {
         appendParam$field = param1;
      }
      
      public function get appendParam() : String
      {
         return appendParam$field;
      }
      
      public function removeIsInitiate() : void
      {
         hasField$0 &= 4294967287;
         isInitiate$field = new int();
      }
      
      public function get hasIsInitiate() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isInitiate(param1:int) : void
      {
         hasField$0 |= 8;
         isInitiate$field = param1;
      }
      
      public function get isInitiate() : int
      {
         return isInitiate$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasActiveId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,active_id$field);
         }
         if(hasBeginDate)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,begin_date$field);
         }
         if(hasEndDate)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,end_date$field);
         }
         if(hasTitle)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,title$field);
         }
         if(hasDetail)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,detail$field);
         }
         if(hasConditionDetail)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,condition_detail$field);
         }
         if(hasGetway)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,getway$field);
         }
         _loc2_ = 0;
         while(_loc2_ < packages.length)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_MESSAGE(param1,packages[_loc2_]);
            _loc2_++;
         }
         if(hasActiveType)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,active_type$field);
         }
         if(hasStartTime)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,start_time$field);
         }
         if(hasStopTime)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,stop_time$field);
         }
         if(hasOrder)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,order$field);
         }
         if(hasAppendParam)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_STRING(param1,appendParam$field);
         }
         if(hasIsInitiate)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,isInitiate$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc16_:* = 0;
         var _loc11_:SumActivePackageMsg = null;
         var _loc12_:uint = 0;
         var _loc6_:uint = 0;
         var _loc17_:uint = 0;
         var _loc8_:uint = 0;
         var _loc15_:uint = 0;
         var _loc14_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         var _loc13_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc16_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: SumActiveinfoMsg.activeId cannot be set twice.");
                  }
                  _loc12_++;
                  activeId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SumActiveinfoMsg.beginDate cannot be set twice.");
                  }
                  _loc6_++;
                  beginDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: SumActiveinfoMsg.endDate cannot be set twice.");
                  }
                  _loc17_++;
                  endDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SumActiveinfoMsg.title cannot be set twice.");
                  }
                  _loc8_++;
                  title = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: SumActiveinfoMsg.detail cannot be set twice.");
                  }
                  _loc15_++;
                  detail = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: SumActiveinfoMsg.conditionDetail cannot be set twice.");
                  }
                  _loc14_++;
                  conditionDetail = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SumActiveinfoMsg.getway cannot be set twice.");
                  }
                  _loc3_++;
                  getway = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  _loc11_ = new SumActivePackageMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc11_);
                  packages.push(_loc11_);
                  break;
               case 8:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SumActiveinfoMsg.activeType cannot be set twice.");
                  }
                  _loc9_++;
                  activeType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SumActiveinfoMsg.startTime cannot be set twice.");
                  }
                  _loc5_++;
                  startTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SumActiveinfoMsg.stopTime cannot be set twice.");
                  }
                  _loc10_++;
                  stopTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: SumActiveinfoMsg.order cannot be set twice.");
                  }
                  _loc13_++;
                  order = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SumActiveinfoMsg.appendParam cannot be set twice.");
                  }
                  _loc7_++;
                  appendParam = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 13:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SumActiveinfoMsg.isInitiate cannot be set twice.");
                  }
                  _loc4_++;
                  isInitiate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc16_ & 7);
            }
         }
      }
   }
}

