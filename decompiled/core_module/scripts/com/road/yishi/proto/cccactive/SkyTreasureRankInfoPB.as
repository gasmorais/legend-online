package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SkyTreasureRankInfoPB extends Message implements IExternalizable
   {
      
      private var active_id$field:String;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.cccactive.ActiveRankPB")]
      public var ranks:Array = [];
      
      private var self$field:ActiveRankPB;
      
      public function SkyTreasureRankInfoPB()
      {
         super();
      }
      
      public function removeActiveId() : void
      {
         hasField$0 &= 4294967294;
         active_id$field = new String();
      }
      
      public function get hasActiveId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set activeId(param1:String) : void
      {
         hasField$0 |= 1;
         active_id$field = param1;
      }
      
      public function get activeId() : String
      {
         return active_id$field;
      }
      
      public function removeSelf() : void
      {
         hasField$0 &= 4294967293;
         self$field = null;
      }
      
      public function get hasSelf() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set self(param1:ActiveRankPB) : void
      {
         hasField$0 |= 2;
         self$field = param1;
      }
      
      public function get self() : ActiveRankPB
      {
         return self$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasActiveId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,active_id$field);
         }
         _loc2_ = 0;
         while(_loc2_ < ranks.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,ranks[_loc2_]);
            _loc2_++;
         }
         if(hasSelf)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,self$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:ActiveRankPB = null;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTreasureRankInfoPB.activeId cannot be set twice.");
                  }
                  _loc3_++;
                  activeId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  _loc4_ = new ActiveRankPB();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  ranks.push(_loc4_);
                  break;
               case 2:
                  if(hasSelf)
                  {
                     throw new IOError("Bad data format: SkyTreasureRankInfoPB.self cannot be set twice.");
                  }
                  self = new ActiveRankPB();
                  ReadUtils.read$TYPE_MESSAGE(param1,self$field);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

