package com.road.yishi.proto.mail
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MailInfoMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var mailType$field:int;
      
      private var sendId$field:int;
      
      private var sendNickName$field:String;
      
      private var receiveId$field:int;
      
      private var receiveNickName$field:String;
      
      private var sendDate$field:String;
      
      private var readDate$field:String;
      
      private var title$field:String;
      
      private var contents$field:String;
      
      private var removeDate$field:String;
      
      private var validityDate$field:int;
      
      private var annex1$field:int;
      
      private var annex1Name$field:int;
      
      private var annex1Count$field:int;
      
      private var isAnnex1$field:Boolean;
      
      private var annex2$field:int;
      
      private var annex2Name$field:int;
      
      private var annex2Count$field:int;
      
      private var isAnnex2$field:Boolean;
      
      private var annex3$field:int;
      
      private var annex3Name$field:int;
      
      private var annex3Count$field:int;
      
      private var isAnnex3$field:Boolean;
      
      private var annex4$field:int;
      
      private var annex4Name$field:int;
      
      private var annex4Count$field:int;
      
      private var isAnnex4$field:Boolean;
      
      private var annex5$field:int;
      
      private var annex5Name$field:int;
      
      private var annex5Count$field:int;
      
      private var isAnnex5$field:Boolean;
      
      private var isExist$field:Boolean;
      
      private var sendType$field:int;
      
      private var sendPlayerGrades$field:int;
      
      public function MailInfoMsg()
      {
         super();
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967294;
         id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 1;
         id$field = param1;
      }
      
      public function get id() : int
      {
         return id$field;
      }
      
      public function removeMailType() : void
      {
         hasField$0 &= 4294967293;
         mailType$field = new int();
      }
      
      public function get hasMailType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set mailType(param1:int) : void
      {
         hasField$0 |= 2;
         mailType$field = param1;
      }
      
      public function get mailType() : int
      {
         return mailType$field;
      }
      
      public function removeSendId() : void
      {
         hasField$0 &= 4294967291;
         sendId$field = new int();
      }
      
      public function get hasSendId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set sendId(param1:int) : void
      {
         hasField$0 |= 4;
         sendId$field = param1;
      }
      
      public function get sendId() : int
      {
         return sendId$field;
      }
      
      public function removeSendNickName() : void
      {
         sendNickName$field = null;
      }
      
      public function get hasSendNickName() : Boolean
      {
         return sendNickName$field != null;
      }
      
      public function set sendNickName(param1:String) : void
      {
         sendNickName$field = param1;
      }
      
      public function get sendNickName() : String
      {
         return sendNickName$field;
      }
      
      public function removeReceiveId() : void
      {
         hasField$0 &= 4294967287;
         receiveId$field = new int();
      }
      
      public function get hasReceiveId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set receiveId(param1:int) : void
      {
         hasField$0 |= 8;
         receiveId$field = param1;
      }
      
      public function get receiveId() : int
      {
         return receiveId$field;
      }
      
      public function removeReceiveNickName() : void
      {
         receiveNickName$field = null;
      }
      
      public function get hasReceiveNickName() : Boolean
      {
         return receiveNickName$field != null;
      }
      
      public function set receiveNickName(param1:String) : void
      {
         receiveNickName$field = param1;
      }
      
      public function get receiveNickName() : String
      {
         return receiveNickName$field;
      }
      
      public function removeSendDate() : void
      {
         sendDate$field = null;
      }
      
      public function get hasSendDate() : Boolean
      {
         return sendDate$field != null;
      }
      
      public function set sendDate(param1:String) : void
      {
         sendDate$field = param1;
      }
      
      public function get sendDate() : String
      {
         return sendDate$field;
      }
      
      public function removeReadDate() : void
      {
         readDate$field = null;
      }
      
      public function get hasReadDate() : Boolean
      {
         return readDate$field != null;
      }
      
      public function set readDate(param1:String) : void
      {
         readDate$field = param1;
      }
      
      public function get readDate() : String
      {
         return readDate$field;
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
      
      public function removeRemoveDate() : void
      {
         removeDate$field = null;
      }
      
      public function get hasRemoveDate() : Boolean
      {
         return removeDate$field != null;
      }
      
      public function set removeDate(param1:String) : void
      {
         removeDate$field = param1;
      }
      
      public function get removeDate() : String
      {
         return removeDate$field;
      }
      
      public function removeValidityDate() : void
      {
         hasField$0 &= 4294967279;
         validityDate$field = new int();
      }
      
      public function get hasValidityDate() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set validityDate(param1:int) : void
      {
         hasField$0 |= 16;
         validityDate$field = param1;
      }
      
      public function get validityDate() : int
      {
         return validityDate$field;
      }
      
      public function removeAnnex1() : void
      {
         hasField$0 &= 4294967263;
         annex1$field = new int();
      }
      
      public function get hasAnnex1() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set annex1(param1:int) : void
      {
         hasField$0 |= 32;
         annex1$field = param1;
      }
      
      public function get annex1() : int
      {
         return annex1$field;
      }
      
      public function removeAnnex1Name() : void
      {
         hasField$0 &= 4294967231;
         annex1Name$field = new int();
      }
      
      public function get hasAnnex1Name() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set annex1Name(param1:int) : void
      {
         hasField$0 |= 64;
         annex1Name$field = param1;
      }
      
      public function get annex1Name() : int
      {
         return annex1Name$field;
      }
      
      public function removeAnnex1Count() : void
      {
         hasField$0 &= 4294967167;
         annex1Count$field = new int();
      }
      
      public function get hasAnnex1Count() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set annex1Count(param1:int) : void
      {
         hasField$0 |= 128;
         annex1Count$field = param1;
      }
      
      public function get annex1Count() : int
      {
         return annex1Count$field;
      }
      
      public function removeIsAnnex1() : void
      {
         hasField$0 &= 4294967039;
         isAnnex1$field = new Boolean();
      }
      
      public function get hasIsAnnex1() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set isAnnex1(param1:Boolean) : void
      {
         hasField$0 |= 256;
         isAnnex1$field = param1;
      }
      
      public function get isAnnex1() : Boolean
      {
         return isAnnex1$field;
      }
      
      public function removeAnnex2() : void
      {
         hasField$0 &= 4294966783;
         annex2$field = new int();
      }
      
      public function get hasAnnex2() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set annex2(param1:int) : void
      {
         hasField$0 |= 512;
         annex2$field = param1;
      }
      
      public function get annex2() : int
      {
         return annex2$field;
      }
      
      public function removeAnnex2Name() : void
      {
         hasField$0 &= 4294966271;
         annex2Name$field = new int();
      }
      
      public function get hasAnnex2Name() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set annex2Name(param1:int) : void
      {
         hasField$0 |= 1024;
         annex2Name$field = param1;
      }
      
      public function get annex2Name() : int
      {
         return annex2Name$field;
      }
      
      public function removeAnnex2Count() : void
      {
         hasField$0 &= 4294965247;
         annex2Count$field = new int();
      }
      
      public function get hasAnnex2Count() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set annex2Count(param1:int) : void
      {
         hasField$0 |= 2048;
         annex2Count$field = param1;
      }
      
      public function get annex2Count() : int
      {
         return annex2Count$field;
      }
      
      public function removeIsAnnex2() : void
      {
         hasField$0 &= 4294963199;
         isAnnex2$field = new Boolean();
      }
      
      public function get hasIsAnnex2() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set isAnnex2(param1:Boolean) : void
      {
         hasField$0 |= 4096;
         isAnnex2$field = param1;
      }
      
      public function get isAnnex2() : Boolean
      {
         return isAnnex2$field;
      }
      
      public function removeAnnex3() : void
      {
         hasField$0 &= 4294959103;
         annex3$field = new int();
      }
      
      public function get hasAnnex3() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set annex3(param1:int) : void
      {
         hasField$0 |= 8192;
         annex3$field = param1;
      }
      
      public function get annex3() : int
      {
         return annex3$field;
      }
      
      public function removeAnnex3Name() : void
      {
         hasField$0 &= 4294950911;
         annex3Name$field = new int();
      }
      
      public function get hasAnnex3Name() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set annex3Name(param1:int) : void
      {
         hasField$0 |= 16384;
         annex3Name$field = param1;
      }
      
      public function get annex3Name() : int
      {
         return annex3Name$field;
      }
      
      public function removeAnnex3Count() : void
      {
         hasField$0 &= 4294934527;
         annex3Count$field = new int();
      }
      
      public function get hasAnnex3Count() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set annex3Count(param1:int) : void
      {
         hasField$0 |= 32768;
         annex3Count$field = param1;
      }
      
      public function get annex3Count() : int
      {
         return annex3Count$field;
      }
      
      public function removeIsAnnex3() : void
      {
         hasField$0 &= 4294901759;
         isAnnex3$field = new Boolean();
      }
      
      public function get hasIsAnnex3() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set isAnnex3(param1:Boolean) : void
      {
         hasField$0 |= 65536;
         isAnnex3$field = param1;
      }
      
      public function get isAnnex3() : Boolean
      {
         return isAnnex3$field;
      }
      
      public function removeAnnex4() : void
      {
         hasField$0 &= 4294836223;
         annex4$field = new int();
      }
      
      public function get hasAnnex4() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set annex4(param1:int) : void
      {
         hasField$0 |= 131072;
         annex4$field = param1;
      }
      
      public function get annex4() : int
      {
         return annex4$field;
      }
      
      public function removeAnnex4Name() : void
      {
         hasField$0 &= 4294705151;
         annex4Name$field = new int();
      }
      
      public function get hasAnnex4Name() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set annex4Name(param1:int) : void
      {
         hasField$0 |= 262144;
         annex4Name$field = param1;
      }
      
      public function get annex4Name() : int
      {
         return annex4Name$field;
      }
      
      public function removeAnnex4Count() : void
      {
         hasField$0 &= 4294443007;
         annex4Count$field = new int();
      }
      
      public function get hasAnnex4Count() : Boolean
      {
         return (hasField$0 & 0x080000) != 0;
      }
      
      public function set annex4Count(param1:int) : void
      {
         hasField$0 |= 524288;
         annex4Count$field = param1;
      }
      
      public function get annex4Count() : int
      {
         return annex4Count$field;
      }
      
      public function removeIsAnnex4() : void
      {
         hasField$0 &= 4293918719;
         isAnnex4$field = new Boolean();
      }
      
      public function get hasIsAnnex4() : Boolean
      {
         return (hasField$0 & 0x100000) != 0;
      }
      
      public function set isAnnex4(param1:Boolean) : void
      {
         hasField$0 |= 1048576;
         isAnnex4$field = param1;
      }
      
      public function get isAnnex4() : Boolean
      {
         return isAnnex4$field;
      }
      
      public function removeAnnex5() : void
      {
         hasField$0 &= 4292870143;
         annex5$field = new int();
      }
      
      public function get hasAnnex5() : Boolean
      {
         return (hasField$0 & 0x200000) != 0;
      }
      
      public function set annex5(param1:int) : void
      {
         hasField$0 |= 2097152;
         annex5$field = param1;
      }
      
      public function get annex5() : int
      {
         return annex5$field;
      }
      
      public function removeAnnex5Name() : void
      {
         hasField$0 &= 4290772991;
         annex5Name$field = new int();
      }
      
      public function get hasAnnex5Name() : Boolean
      {
         return (hasField$0 & 0x400000) != 0;
      }
      
      public function set annex5Name(param1:int) : void
      {
         hasField$0 |= 4194304;
         annex5Name$field = param1;
      }
      
      public function get annex5Name() : int
      {
         return annex5Name$field;
      }
      
      public function removeAnnex5Count() : void
      {
         hasField$0 &= 4286578687;
         annex5Count$field = new int();
      }
      
      public function get hasAnnex5Count() : Boolean
      {
         return (hasField$0 & 0x800000) != 0;
      }
      
      public function set annex5Count(param1:int) : void
      {
         hasField$0 |= 8388608;
         annex5Count$field = param1;
      }
      
      public function get annex5Count() : int
      {
         return annex5Count$field;
      }
      
      public function removeIsAnnex5() : void
      {
         hasField$0 &= 4278190079;
         isAnnex5$field = new Boolean();
      }
      
      public function get hasIsAnnex5() : Boolean
      {
         return (hasField$0 & 0x01000000) != 0;
      }
      
      public function set isAnnex5(param1:Boolean) : void
      {
         hasField$0 |= 16777216;
         isAnnex5$field = param1;
      }
      
      public function get isAnnex5() : Boolean
      {
         return isAnnex5$field;
      }
      
      public function removeIsExist() : void
      {
         hasField$0 &= 4261412863;
         isExist$field = new Boolean();
      }
      
      public function get hasIsExist() : Boolean
      {
         return (hasField$0 & 0x02000000) != 0;
      }
      
      public function set isExist(param1:Boolean) : void
      {
         hasField$0 |= 33554432;
         isExist$field = param1;
      }
      
      public function get isExist() : Boolean
      {
         return isExist$field;
      }
      
      public function removeSendType() : void
      {
         hasField$0 &= 4227858431;
         sendType$field = new int();
      }
      
      public function get hasSendType() : Boolean
      {
         return (hasField$0 & 0x04000000) != 0;
      }
      
      public function set sendType(param1:int) : void
      {
         hasField$0 |= 67108864;
         sendType$field = param1;
      }
      
      public function get sendType() : int
      {
         return sendType$field;
      }
      
      public function removeSendPlayerGrades() : void
      {
         hasField$0 &= 4160749567;
         sendPlayerGrades$field = new int();
      }
      
      public function get hasSendPlayerGrades() : Boolean
      {
         return (hasField$0 & 0x08000000) != 0;
      }
      
      public function set sendPlayerGrades(param1:int) : void
      {
         hasField$0 |= 134217728;
         sendPlayerGrades$field = param1;
      }
      
      public function get sendPlayerGrades() : int
      {
         return sendPlayerGrades$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasMailType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,mailType$field);
         }
         if(hasSendId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,sendId$field);
         }
         if(hasSendNickName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,sendNickName$field);
         }
         if(hasReceiveId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,receiveId$field);
         }
         if(hasReceiveNickName)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,receiveNickName$field);
         }
         if(hasSendDate)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,sendDate$field);
         }
         if(hasReadDate)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,readDate$field);
         }
         if(hasTitle)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,title$field);
         }
         if(hasContents)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,contents$field);
         }
         if(hasRemoveDate)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,removeDate$field);
         }
         if(hasValidityDate)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,validityDate$field);
         }
         if(hasAnnex1)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,annex1$field);
         }
         if(hasAnnex1Name)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,annex1Name$field);
         }
         if(hasAnnex1Count)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,annex1Count$field);
         }
         if(hasIsAnnex1)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_BOOL(param1,isAnnex1$field);
         }
         if(hasAnnex2)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,annex2$field);
         }
         if(hasAnnex2Name)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,annex2Name$field);
         }
         if(hasAnnex2Count)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,annex2Count$field);
         }
         if(hasIsAnnex2)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_BOOL(param1,isAnnex2$field);
         }
         if(hasAnnex3)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,annex3$field);
         }
         if(hasAnnex3Name)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_INT32(param1,annex3Name$field);
         }
         if(hasAnnex3Count)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_INT32(param1,annex3Count$field);
         }
         if(hasIsAnnex3)
         {
            WriteUtils.writeTag(param1,0,24);
            WriteUtils.write$TYPE_BOOL(param1,isAnnex3$field);
         }
         if(hasAnnex4)
         {
            WriteUtils.writeTag(param1,0,25);
            WriteUtils.write$TYPE_INT32(param1,annex4$field);
         }
         if(hasAnnex4Name)
         {
            WriteUtils.writeTag(param1,0,26);
            WriteUtils.write$TYPE_INT32(param1,annex4Name$field);
         }
         if(hasAnnex4Count)
         {
            WriteUtils.writeTag(param1,0,27);
            WriteUtils.write$TYPE_INT32(param1,annex4Count$field);
         }
         if(hasIsAnnex4)
         {
            WriteUtils.writeTag(param1,0,28);
            WriteUtils.write$TYPE_BOOL(param1,isAnnex4$field);
         }
         if(hasAnnex5)
         {
            WriteUtils.writeTag(param1,0,29);
            WriteUtils.write$TYPE_INT32(param1,annex5$field);
         }
         if(hasAnnex5Name)
         {
            WriteUtils.writeTag(param1,0,30);
            WriteUtils.write$TYPE_INT32(param1,annex5Name$field);
         }
         if(hasAnnex5Count)
         {
            WriteUtils.writeTag(param1,0,31);
            WriteUtils.write$TYPE_INT32(param1,annex5Count$field);
         }
         if(hasIsAnnex5)
         {
            WriteUtils.writeTag(param1,0,32);
            WriteUtils.write$TYPE_BOOL(param1,isAnnex5$field);
         }
         if(hasIsExist)
         {
            WriteUtils.writeTag(param1,0,33);
            WriteUtils.write$TYPE_BOOL(param1,isExist$field);
         }
         if(hasSendType)
         {
            WriteUtils.writeTag(param1,0,34);
            WriteUtils.write$TYPE_INT32(param1,sendType$field);
         }
         if(hasSendPlayerGrades)
         {
            WriteUtils.writeTag(param1,0,35);
            WriteUtils.write$TYPE_INT32(param1,sendPlayerGrades$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc15_:* = 0;
         var _loc23_:uint = 0;
         var _loc30_:uint = 0;
         var _loc20_:uint = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         var _loc27_:uint = 0;
         var _loc18_:uint = 0;
         var _loc31_:uint = 0;
         var _loc28_:uint = 0;
         var _loc33_:uint = 0;
         var _loc36_:uint = 0;
         var _loc12_:uint = 0;
         var _loc17_:uint = 0;
         var _loc4_:uint = 0;
         var _loc37_:uint = 0;
         var _loc24_:uint = 0;
         var _loc34_:uint = 0;
         var _loc19_:uint = 0;
         var _loc29_:uint = 0;
         var _loc9_:uint = 0;
         var _loc26_:uint = 0;
         var _loc6_:uint = 0;
         var _loc16_:uint = 0;
         var _loc13_:uint = 0;
         var _loc3_:uint = 0;
         var _loc25_:uint = 0;
         var _loc7_:uint = 0;
         var _loc38_:uint = 0;
         var _loc21_:uint = 0;
         var _loc35_:uint = 0;
         var _loc32_:uint = 0;
         var _loc14_:uint = 0;
         var _loc22_:uint = 0;
         var _loc11_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc15_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.id cannot be set twice.");
                  }
                  _loc23_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc30_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.mailType cannot be set twice.");
                  }
                  _loc30_++;
                  mailType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.sendId cannot be set twice.");
                  }
                  _loc20_++;
                  sendId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.sendNickName cannot be set twice.");
                  }
                  _loc5_++;
                  sendNickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.receiveId cannot be set twice.");
                  }
                  _loc10_++;
                  receiveId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc27_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.receiveNickName cannot be set twice.");
                  }
                  _loc27_++;
                  receiveNickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.sendDate cannot be set twice.");
                  }
                  _loc18_++;
                  sendDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc31_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.readDate cannot be set twice.");
                  }
                  _loc31_++;
                  readDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc28_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.title cannot be set twice.");
                  }
                  _loc28_++;
                  title = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc33_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.contents cannot be set twice.");
                  }
                  _loc33_++;
                  contents = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  if(_loc36_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.removeDate cannot be set twice.");
                  }
                  _loc36_++;
                  removeDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 12:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.validityDate cannot be set twice.");
                  }
                  _loc12_++;
                  validityDate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.annex1 cannot be set twice.");
                  }
                  _loc17_++;
                  annex1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.annex1Name cannot be set twice.");
                  }
                  _loc4_++;
                  annex1Name = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc37_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.annex1Count cannot be set twice.");
                  }
                  _loc37_++;
                  annex1Count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.isAnnex1 cannot be set twice.");
                  }
                  _loc24_++;
                  isAnnex1 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 17:
                  if(_loc34_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.annex2 cannot be set twice.");
                  }
                  _loc34_++;
                  annex2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.annex2Name cannot be set twice.");
                  }
                  _loc19_++;
                  annex2Name = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc29_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.annex2Count cannot be set twice.");
                  }
                  _loc29_++;
                  annex2Count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.isAnnex2 cannot be set twice.");
                  }
                  _loc9_++;
                  isAnnex2 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 21:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.annex3 cannot be set twice.");
                  }
                  _loc26_++;
                  annex3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 22:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.annex3Name cannot be set twice.");
                  }
                  _loc6_++;
                  annex3Name = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 23:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.annex3Count cannot be set twice.");
                  }
                  _loc16_++;
                  annex3Count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 24:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.isAnnex3 cannot be set twice.");
                  }
                  _loc13_++;
                  isAnnex3 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 25:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.annex4 cannot be set twice.");
                  }
                  _loc3_++;
                  annex4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 26:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.annex4Name cannot be set twice.");
                  }
                  _loc25_++;
                  annex4Name = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 27:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.annex4Count cannot be set twice.");
                  }
                  _loc7_++;
                  annex4Count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 28:
                  if(_loc38_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.isAnnex4 cannot be set twice.");
                  }
                  _loc38_++;
                  isAnnex4 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 29:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.annex5 cannot be set twice.");
                  }
                  _loc21_++;
                  annex5 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 30:
                  if(_loc35_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.annex5Name cannot be set twice.");
                  }
                  _loc35_++;
                  annex5Name = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 31:
                  if(_loc32_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.annex5Count cannot be set twice.");
                  }
                  _loc32_++;
                  annex5Count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 32:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.isAnnex5 cannot be set twice.");
                  }
                  _loc14_++;
                  isAnnex5 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 33:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.isExist cannot be set twice.");
                  }
                  _loc22_++;
                  isExist = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 34:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.sendType cannot be set twice.");
                  }
                  _loc11_++;
                  sendType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 35:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MailInfoMsg.sendPlayerGrades cannot be set twice.");
                  }
                  _loc8_++;
                  sendPlayerGrades = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc15_ & 7);
            }
         }
      }
   }
}

