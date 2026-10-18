package com.road.yishi.proto.allianceregression
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ActivityDataMsg extends Message implements IExternalizable
   {
      
      private var userInfo$field:AllianceUserData;
      
      [ArrayElementType("com.road.yishi.proto.allianceregression.TaskData")]
      public var tasks:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.allianceregression.AllyData")]
      public var allys:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.allianceregression.RelationData")]
      public var applys:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.allianceregression.RelationData")]
      public var invites:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.allianceregression.ShopLimitData")]
      public var shopLimit:Array = [];
      
      public function ActivityDataMsg()
      {
         super();
      }
      
      public function removeUserInfo() : void
      {
         userInfo$field = null;
      }
      
      public function get hasUserInfo() : Boolean
      {
         return userInfo$field != null;
      }
      
      public function set userInfo(param1:AllianceUserData) : void
      {
         userInfo$field = param1;
      }
      
      public function get userInfo() : AllianceUserData
      {
         return userInfo$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc6_:* = 0;
         var _loc5_:* = 0;
         var _loc4_:* = 0;
         var _loc2_:* = 0;
         if(hasUserInfo)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,userInfo$field);
         }
         _loc3_ = 0;
         while(_loc3_ < tasks.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,tasks[_loc3_]);
            _loc3_++;
         }
         _loc6_ = 0;
         while(_loc6_ < allys.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,allys[_loc6_]);
            _loc6_++;
         }
         _loc5_ = 0;
         while(_loc5_ < applys.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,applys[_loc5_]);
            _loc5_++;
         }
         _loc4_ = 0;
         while(_loc4_ < invites.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,invites[_loc4_]);
            _loc4_++;
         }
         _loc2_ = 0;
         while(_loc2_ < shopLimit.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,shopLimit[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc9_:TaskData = null;
         var _loc6_:AllyData = null;
         var _loc8_:RelationData = null;
         var _loc3_:RelationData = null;
         var _loc4_:ShopLimitData = null;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ActivityDataMsg.userInfo cannot be set twice.");
                  }
                  _loc5_++;
                  userInfo = new AllianceUserData();
                  ReadUtils.read$TYPE_MESSAGE(param1,userInfo);
                  break;
               case 1:
                  _loc9_ = new TaskData();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc9_);
                  tasks.push(_loc9_);
                  break;
               case 2:
                  _loc6_ = new AllyData();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  allys.push(_loc6_);
                  break;
               case 3:
                  _loc8_ = new RelationData();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  applys.push(_loc8_);
                  break;
               case 4:
                  _loc3_ = new RelationData();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  invites.push(_loc3_);
                  break;
               case 5:
                  _loc4_ = new ShopLimitData();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  shopLimit.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

