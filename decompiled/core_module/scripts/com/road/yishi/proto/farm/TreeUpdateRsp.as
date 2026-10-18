package com.road.yishi.proto.farm
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TreeUpdateRsp extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.farm.TreeInfoMsg")]
      public var tree:Array = [];
      
      [ArrayElementType("String")]
      public var harvestMsg:Array = [];
      
      [ArrayElementType("String")]
      public var pickMsg:Array = [];
      
      private var isUpGrade$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      public function TreeUpdateRsp()
      {
         super();
      }
      
      public function removeIsUpGrade() : void
      {
         hasField$0 &= 4294967294;
         isUpGrade$field = new Boolean();
      }
      
      public function get hasIsUpGrade() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set isUpGrade(param1:Boolean) : void
      {
         hasField$0 |= 1;
         isUpGrade$field = param1;
      }
      
      public function get isUpGrade() : Boolean
      {
         return isUpGrade$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < tree.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,tree[_loc2_]);
            _loc2_++;
         }
         _loc4_ = 0;
         while(_loc4_ < harvestMsg.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,harvestMsg[_loc4_]);
            _loc4_++;
         }
         _loc3_ = 0;
         while(_loc3_ < pickMsg.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,pickMsg[_loc3_]);
            _loc3_++;
         }
         if(hasIsUpGrade)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,isUpGrade$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc5_:TreeInfoMsg = null;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc5_ = new TreeInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  tree.push(_loc5_);
                  break;
               case 1:
                  harvestMsg.push(ReadUtils.read$TYPE_STRING(param1));
                  break;
               case 2:
                  pickMsg.push(ReadUtils.read$TYPE_STRING(param1));
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TreeUpdateRsp.isUpGrade cannot be set twice.");
                  }
                  _loc3_++;
                  isUpGrade = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

