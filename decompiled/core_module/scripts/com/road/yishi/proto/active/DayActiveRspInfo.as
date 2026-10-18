package com.road.yishi.proto.active
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DayActiveRspInfo extends Message implements IExternalizable
   {
      
      private var activeId$field:String;
      
      private var title$field:String;
      
      private var description$field:String;
      
      private var contents$field:String;
      
      private var awardContent$field:String;
      
      private var startDate$field:String;
      
      private var endDate$field:String;
      
      private var actionTimeContent$field:String;
      
      private var sort$field:int;
      
      private var hasField$0:uint = 0;
      
      public function DayActiveRspInfo()
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
      
      public function removeAwardContent() : void
      {
         awardContent$field = null;
      }
      
      public function get hasAwardContent() : Boolean
      {
         return awardContent$field != null;
      }
      
      public function set awardContent(param1:String) : void
      {
         awardContent$field = param1;
      }
      
      public function get awardContent() : String
      {
         return awardContent$field;
      }
      
      public function removeStartDate() : void
      {
         startDate$field = null;
      }
      
      public function get hasStartDate() : Boolean
      {
         return startDate$field != null;
      }
      
      public function set startDate(param1:String) : void
      {
         startDate$field = param1;
      }
      
      public function get startDate() : String
      {
         return startDate$field;
      }
      
      public function removeEndDate() : void
      {
         endDate$field = null;
      }
      
      public function get hasEndDate() : Boolean
      {
         return endDate$field != null;
      }
      
      public function set endDate(param1:String) : void
      {
         endDate$field = param1;
      }
      
      public function get endDate() : String
      {
         return endDate$field;
      }
      
      public function removeActionTimeContent() : void
      {
         actionTimeContent$field = null;
      }
      
      public function get hasActionTimeContent() : Boolean
      {
         return actionTimeContent$field != null;
      }
      
      public function set actionTimeContent(param1:String) : void
      {
         actionTimeContent$field = param1;
      }
      
      public function get actionTimeContent() : String
      {
         return actionTimeContent$field;
      }
      
      public function removeSort() : void
      {
         hasField$0 &= 4294967294;
         sort$field = new int();
      }
      
      public function get hasSort() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set sort(param1:int) : void
      {
         hasField$0 |= 1;
         sort$field = param1;
      }
      
      public function get sort() : int
      {
         return sort$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
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
         if(hasDescription)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,description$field);
         }
         if(hasContents)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,contents$field);
         }
         if(hasAwardContent)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,awardContent$field);
         }
         if(hasStartDate)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,startDate$field);
         }
         if(hasEndDate)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,endDate$field);
         }
         if(hasActionTimeContent)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,actionTimeContent$field);
         }
         if(hasSort)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,sort$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc9_:uint = 0;
         var _loc12_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc11_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: DayActiveRspInfo.activeId cannot be set twice.");
                  }
                  _loc9_++;
                  activeId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: DayActiveRspInfo.title cannot be set twice.");
                  }
                  _loc12_++;
                  title = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: DayActiveRspInfo.description cannot be set twice.");
                  }
                  _loc8_++;
                  description = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DayActiveRspInfo.contents cannot be set twice.");
                  }
                  _loc4_++;
                  contents = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: DayActiveRspInfo.awardContent cannot be set twice.");
                  }
                  _loc6_++;
                  awardContent = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: DayActiveRspInfo.startDate cannot be set twice.");
                  }
                  _loc11_++;
                  startDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: DayActiveRspInfo.endDate cannot be set twice.");
                  }
                  _loc5_++;
                  endDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: DayActiveRspInfo.actionTimeContent cannot be set twice.");
                  }
                  _loc7_++;
                  actionTimeContent = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DayActiveRspInfo.sort cannot be set twice.");
                  }
                  _loc3_++;
                  sort = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

