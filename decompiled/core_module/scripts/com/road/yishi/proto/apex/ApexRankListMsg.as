package com.road.yishi.proto.apex
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ApexRankListMsg extends Message implements IExternalizable
   {
      
      private var selfTeamUid$field:String;
      
      private var updateTime$field:String;
      
      [ArrayElementType("com.road.yishi.proto.apex.ApexRankMsg")]
      public var allRankList:Array = [];
      
      private var page$field:int;
      
      private var hasField$0:uint = 0;
      
      private var totalPage$field:int;
      
      private var stamp$field:int;
      
      public function ApexRankListMsg()
      {
         super();
      }
      
      public function removeSelfTeamUid() : void
      {
         selfTeamUid$field = null;
      }
      
      public function get hasSelfTeamUid() : Boolean
      {
         return selfTeamUid$field != null;
      }
      
      public function set selfTeamUid(param1:String) : void
      {
         selfTeamUid$field = param1;
      }
      
      public function get selfTeamUid() : String
      {
         return selfTeamUid$field;
      }
      
      public function removeUpdateTime() : void
      {
         updateTime$field = null;
      }
      
      public function get hasUpdateTime() : Boolean
      {
         return updateTime$field != null;
      }
      
      public function set updateTime(param1:String) : void
      {
         updateTime$field = param1;
      }
      
      public function get updateTime() : String
      {
         return updateTime$field;
      }
      
      public function removePage() : void
      {
         hasField$0 &= 4294967294;
         page$field = new int();
      }
      
      public function get hasPage() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set page(param1:int) : void
      {
         hasField$0 |= 1;
         page$field = param1;
      }
      
      public function get page() : int
      {
         return page$field;
      }
      
      public function removeTotalPage() : void
      {
         hasField$0 &= 4294967293;
         totalPage$field = new int();
      }
      
      public function get hasTotalPage() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set totalPage(param1:int) : void
      {
         hasField$0 |= 2;
         totalPage$field = param1;
      }
      
      public function get totalPage() : int
      {
         return totalPage$field;
      }
      
      public function removeStamp() : void
      {
         hasField$0 &= 4294967291;
         stamp$field = new int();
      }
      
      public function get hasStamp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set stamp(param1:int) : void
      {
         hasField$0 |= 4;
         stamp$field = param1;
      }
      
      public function get stamp() : int
      {
         return stamp$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasSelfTeamUid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,selfTeamUid$field);
         }
         if(hasUpdateTime)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,updateTime$field);
         }
         _loc2_ = 0;
         while(_loc2_ < allRankList.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,allRankList[_loc2_]);
            _loc2_++;
         }
         if(hasPage)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,page$field);
         }
         if(hasTotalPage)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,totalPage$field);
         }
         if(hasStamp)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,stamp$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc8_:ApexRankMsg = null;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ApexRankListMsg.selfTeamUid cannot be set twice.");
                  }
                  _loc4_++;
                  selfTeamUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ApexRankListMsg.updateTime cannot be set twice.");
                  }
                  _loc3_++;
                  updateTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  _loc8_ = new ApexRankMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  allRankList.push(_loc8_);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ApexRankListMsg.page cannot be set twice.");
                  }
                  _loc6_++;
                  page = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ApexRankListMsg.totalPage cannot be set twice.");
                  }
                  _loc5_++;
                  totalPage = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ApexRankListMsg.stamp cannot be set twice.");
                  }
                  _loc9_++;
                  stamp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

