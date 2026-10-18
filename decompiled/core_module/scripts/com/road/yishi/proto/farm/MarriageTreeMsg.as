package com.road.yishi.proto.farm
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MarriageTreeMsg extends Message implements IExternalizable
   {
      
      private var userId_a$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nickName_a$field:String;
      
      private var job_a$field:int;
      
      private var userId_b$field:int;
      
      private var nickName_b$field:String;
      
      private var job_b$field:int;
      
      private var stateValue$field:int;
      
      private var feedCount$field:int;
      
      private var start_time$field:String;
      
      private var end_time$field:String;
      
      private var trainACount$field:int;
      
      private var trainBCount$field:int;
      
      private var trainAType$field:int;
      
      private var trainBType$field:int;
      
      private var isGetA$field:Boolean;
      
      private var isGetB$field:Boolean;
      
      private var tree_state$field:String;
      
      private var feed_user$field:int;
      
      public function MarriageTreeMsg()
      {
         super();
      }
      
      public function removeUserIdA() : void
      {
         hasField$0 &= 4294967294;
         userId_a$field = new int();
      }
      
      public function get hasUserIdA() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userIdA(param1:int) : void
      {
         hasField$0 |= 1;
         userId_a$field = param1;
      }
      
      public function get userIdA() : int
      {
         return userId_a$field;
      }
      
      public function removeNickNameA() : void
      {
         nickName_a$field = null;
      }
      
      public function get hasNickNameA() : Boolean
      {
         return nickName_a$field != null;
      }
      
      public function set nickNameA(param1:String) : void
      {
         nickName_a$field = param1;
      }
      
      public function get nickNameA() : String
      {
         return nickName_a$field;
      }
      
      public function removeJobA() : void
      {
         hasField$0 &= 4294967293;
         job_a$field = new int();
      }
      
      public function get hasJobA() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set jobA(param1:int) : void
      {
         hasField$0 |= 2;
         job_a$field = param1;
      }
      
      public function get jobA() : int
      {
         return job_a$field;
      }
      
      public function removeUserIdB() : void
      {
         hasField$0 &= 4294967291;
         userId_b$field = new int();
      }
      
      public function get hasUserIdB() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set userIdB(param1:int) : void
      {
         hasField$0 |= 4;
         userId_b$field = param1;
      }
      
      public function get userIdB() : int
      {
         return userId_b$field;
      }
      
      public function removeNickNameB() : void
      {
         nickName_b$field = null;
      }
      
      public function get hasNickNameB() : Boolean
      {
         return nickName_b$field != null;
      }
      
      public function set nickNameB(param1:String) : void
      {
         nickName_b$field = param1;
      }
      
      public function get nickNameB() : String
      {
         return nickName_b$field;
      }
      
      public function removeJobB() : void
      {
         hasField$0 &= 4294967287;
         job_b$field = new int();
      }
      
      public function get hasJobB() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set jobB(param1:int) : void
      {
         hasField$0 |= 8;
         job_b$field = param1;
      }
      
      public function get jobB() : int
      {
         return job_b$field;
      }
      
      public function removeStateValue() : void
      {
         hasField$0 &= 4294967279;
         stateValue$field = new int();
      }
      
      public function get hasStateValue() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set stateValue(param1:int) : void
      {
         hasField$0 |= 16;
         stateValue$field = param1;
      }
      
      public function get stateValue() : int
      {
         return stateValue$field;
      }
      
      public function removeFeedCount() : void
      {
         hasField$0 &= 4294967263;
         feedCount$field = new int();
      }
      
      public function get hasFeedCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set feedCount(param1:int) : void
      {
         hasField$0 |= 32;
         feedCount$field = param1;
      }
      
      public function get feedCount() : int
      {
         return feedCount$field;
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
      
      public function removeEndTime() : void
      {
         end_time$field = null;
      }
      
      public function get hasEndTime() : Boolean
      {
         return end_time$field != null;
      }
      
      public function set endTime(param1:String) : void
      {
         end_time$field = param1;
      }
      
      public function get endTime() : String
      {
         return end_time$field;
      }
      
      public function removeTrainACount() : void
      {
         hasField$0 &= 4294967231;
         trainACount$field = new int();
      }
      
      public function get hasTrainACount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set trainACount(param1:int) : void
      {
         hasField$0 |= 64;
         trainACount$field = param1;
      }
      
      public function get trainACount() : int
      {
         return trainACount$field;
      }
      
      public function removeTrainBCount() : void
      {
         hasField$0 &= 4294967167;
         trainBCount$field = new int();
      }
      
      public function get hasTrainBCount() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set trainBCount(param1:int) : void
      {
         hasField$0 |= 128;
         trainBCount$field = param1;
      }
      
      public function get trainBCount() : int
      {
         return trainBCount$field;
      }
      
      public function removeTrainAType() : void
      {
         hasField$0 &= 4294967039;
         trainAType$field = new int();
      }
      
      public function get hasTrainAType() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set trainAType(param1:int) : void
      {
         hasField$0 |= 256;
         trainAType$field = param1;
      }
      
      public function get trainAType() : int
      {
         return trainAType$field;
      }
      
      public function removeTrainBType() : void
      {
         hasField$0 &= 4294966783;
         trainBType$field = new int();
      }
      
      public function get hasTrainBType() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set trainBType(param1:int) : void
      {
         hasField$0 |= 512;
         trainBType$field = param1;
      }
      
      public function get trainBType() : int
      {
         return trainBType$field;
      }
      
      public function removeIsGetA() : void
      {
         hasField$0 &= 4294966271;
         isGetA$field = new Boolean();
      }
      
      public function get hasIsGetA() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set isGetA(param1:Boolean) : void
      {
         hasField$0 |= 1024;
         isGetA$field = param1;
      }
      
      public function get isGetA() : Boolean
      {
         return isGetA$field;
      }
      
      public function removeIsGetB() : void
      {
         hasField$0 &= 4294965247;
         isGetB$field = new Boolean();
      }
      
      public function get hasIsGetB() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set isGetB(param1:Boolean) : void
      {
         hasField$0 |= 2048;
         isGetB$field = param1;
      }
      
      public function get isGetB() : Boolean
      {
         return isGetB$field;
      }
      
      public function removeTreeState() : void
      {
         tree_state$field = null;
      }
      
      public function get hasTreeState() : Boolean
      {
         return tree_state$field != null;
      }
      
      public function set treeState(param1:String) : void
      {
         tree_state$field = param1;
      }
      
      public function get treeState() : String
      {
         return tree_state$field;
      }
      
      public function removeFeedUser() : void
      {
         hasField$0 &= 4294963199;
         feed_user$field = new int();
      }
      
      public function get hasFeedUser() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set feedUser(param1:int) : void
      {
         hasField$0 |= 4096;
         feed_user$field = param1;
      }
      
      public function get feedUser() : int
      {
         return feed_user$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserIdA)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId_a$field);
         }
         if(hasNickNameA)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,nickName_a$field);
         }
         if(hasJobA)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,job_a$field);
         }
         if(hasUserIdB)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,userId_b$field);
         }
         if(hasNickNameB)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,nickName_b$field);
         }
         if(hasJobB)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,job_b$field);
         }
         if(hasStateValue)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,stateValue$field);
         }
         if(hasFeedCount)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,feedCount$field);
         }
         if(hasStartTime)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,start_time$field);
         }
         if(hasEndTime)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,end_time$field);
         }
         if(hasTrainACount)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,trainACount$field);
         }
         if(hasTrainBCount)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,trainBCount$field);
         }
         if(hasTrainAType)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,trainAType$field);
         }
         if(hasTrainBType)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,trainBType$field);
         }
         if(hasIsGetA)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_BOOL(param1,isGetA$field);
         }
         if(hasIsGetB)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_BOOL(param1,isGetB$field);
         }
         if(hasTreeState)
         {
            WriteUtils.writeTag(param1,2,18);
            WriteUtils.write$TYPE_STRING(param1,tree_state$field);
         }
         if(hasFeedUser)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,feed_user$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc20_:* = 0;
         var _loc6_:uint = 0;
         var _loc18_:uint = 0;
         var _loc15_:uint = 0;
         var _loc11_:uint = 0;
         var _loc16_:uint = 0;
         var _loc12_:uint = 0;
         var _loc7_:uint = 0;
         var _loc19_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc14_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc21_:uint = 0;
         var _loc9_:uint = 0;
         var _loc13_:uint = 0;
         var _loc10_:uint = 0;
         var _loc17_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc20_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageTreeMsg.userIdA cannot be set twice.");
                  }
                  _loc6_++;
                  userIdA = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageTreeMsg.nickNameA cannot be set twice.");
                  }
                  _loc18_++;
                  nickNameA = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageTreeMsg.jobA cannot be set twice.");
                  }
                  _loc15_++;
                  jobA = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageTreeMsg.userIdB cannot be set twice.");
                  }
                  _loc11_++;
                  userIdB = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageTreeMsg.nickNameB cannot be set twice.");
                  }
                  _loc16_++;
                  nickNameB = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageTreeMsg.jobB cannot be set twice.");
                  }
                  _loc12_++;
                  jobB = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageTreeMsg.stateValue cannot be set twice.");
                  }
                  _loc7_++;
                  stateValue = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageTreeMsg.feedCount cannot be set twice.");
                  }
                  _loc19_++;
                  feedCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageTreeMsg.startTime cannot be set twice.");
                  }
                  _loc3_++;
                  startTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageTreeMsg.endTime cannot be set twice.");
                  }
                  _loc8_++;
                  endTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageTreeMsg.trainACount cannot be set twice.");
                  }
                  _loc14_++;
                  trainACount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageTreeMsg.trainBCount cannot be set twice.");
                  }
                  _loc4_++;
                  trainBCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageTreeMsg.trainAType cannot be set twice.");
                  }
                  _loc5_++;
                  trainAType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageTreeMsg.trainBType cannot be set twice.");
                  }
                  _loc21_++;
                  trainBType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageTreeMsg.isGetA cannot be set twice.");
                  }
                  _loc9_++;
                  isGetA = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 16:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageTreeMsg.isGetB cannot be set twice.");
                  }
                  _loc13_++;
                  isGetB = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 17:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageTreeMsg.treeState cannot be set twice.");
                  }
                  _loc10_++;
                  treeState = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 18:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: MarriageTreeMsg.feedUser cannot be set twice.");
                  }
                  _loc17_++;
                  feedUser = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc20_ & 7);
            }
         }
      }
   }
}

