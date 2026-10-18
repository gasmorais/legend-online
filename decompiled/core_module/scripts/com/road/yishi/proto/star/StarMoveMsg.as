package com.road.yishi.proto.star
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StarMoveMsg extends Message implements IExternalizable
   {
      
      private var change_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var change_pos$field:int;
      
      private var star_Info$field:StarInfoMsg;
      
      public function StarMoveMsg()
      {
         super();
      }
      
      public function removeChangeType() : void
      {
         hasField$0 &= 4294967294;
         change_type$field = new int();
      }
      
      public function get hasChangeType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set changeType(param1:int) : void
      {
         hasField$0 |= 1;
         change_type$field = param1;
      }
      
      public function get changeType() : int
      {
         return change_type$field;
      }
      
      public function removeChangePos() : void
      {
         hasField$0 &= 4294967293;
         change_pos$field = new int();
      }
      
      public function get hasChangePos() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set changePos(param1:int) : void
      {
         hasField$0 |= 2;
         change_pos$field = param1;
      }
      
      public function get changePos() : int
      {
         return change_pos$field;
      }
      
      public function removeStar_Info() : void
      {
         star_Info$field = null;
      }
      
      public function get hasStar_Info() : Boolean
      {
         return star_Info$field != null;
      }
      
      public function set star_Info(param1:StarInfoMsg) : void
      {
         star_Info$field = param1;
      }
      
      public function get star_Info() : StarInfoMsg
      {
         return star_Info$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasChangeType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,change_type$field);
         }
         if(hasChangePos)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,change_pos$field);
         }
         if(hasStar_Info)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,star_Info$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: StarMoveMsg.changeType cannot be set twice.");
                  }
                  _loc3_++;
                  changeType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: StarMoveMsg.changePos cannot be set twice.");
                  }
                  _loc5_++;
                  changePos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: StarMoveMsg.star_Info cannot be set twice.");
                  }
                  _loc6_++;
                  star_Info = new StarInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,star_Info);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

