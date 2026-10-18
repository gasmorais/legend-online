package com.road.yishi.proto.childseal
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChildSealRewardMsg extends Message implements IExternalizable
   {
      
      private var needStar$field:int;
      
      private var hasField$0:uint = 0;
      
      private var templateId$field:int;
      
      private var count$field:int;
      
      private var isGet$field:Boolean;
      
      public function ChildSealRewardMsg()
      {
         super();
      }
      
      public function removeNeedStar() : void
      {
         hasField$0 &= 4294967294;
         needStar$field = new int();
      }
      
      public function get hasNeedStar() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set needStar(param1:int) : void
      {
         hasField$0 |= 1;
         needStar$field = param1;
      }
      
      public function get needStar() : int
      {
         return needStar$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967293;
         templateId$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 2;
         templateId$field = param1;
      }
      
      public function get templateId() : int
      {
         return templateId$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967291;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 4;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeIsGet() : void
      {
         hasField$0 &= 4294967287;
         isGet$field = new Boolean();
      }
      
      public function get hasIsGet() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isGet(param1:Boolean) : void
      {
         hasField$0 |= 8;
         isGet$field = param1;
      }
      
      public function get isGet() : Boolean
      {
         return isGet$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasNeedStar)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,needStar$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasIsGet)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,isGet$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChildSealRewardMsg.needStar cannot be set twice.");
                  }
                  _loc6_++;
                  needStar = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChildSealRewardMsg.templateId cannot be set twice.");
                  }
                  _loc5_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChildSealRewardMsg.count cannot be set twice.");
                  }
                  _loc4_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChildSealRewardMsg.isGet cannot be set twice.");
                  }
                  _loc3_++;
                  isGet = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

