package yishi.manager
{
   import com.road.yishi.proto.active.ActiveMsgLeaveOp;
   import manager.LanguageMgr;
   import mvc.module.birthday.BirthdayModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.utils.DateFormatter;
   import yishi.view.tips.MessageTipManager;
   
   public class BirthdayManager
   {
      
      public static const BIRTHDAY_3_TYPE:uint = 1;
      
      public static const GET_MESSAGE_TYPE:uint = 100;
      
      public static const SUBMIT_MESSAGE_TYPE:uint = 101;
      
      public static const GET_REWARD_TYPE:uint = 102;
      
      public static const GET_BUFF_TYPE:uint = 103;
      
      private static var _instance:BirthdayManager;
      
      private static var _closeFlg:Boolean = true;
      
      private var _startDate:Date;
      
      private var _endDate:Date;
      
      private var _birthdaySwitch:Boolean;
      
      private var _model:BirthdayModel;
      
      public function BirthdayManager()
      {
         super();
         if(_closeFlg)
         {
            throw new Error("BirthdayManager is a singleton!");
         }
         init();
      }
      
      public static function get instance() : BirthdayManager
      {
         if(_instance == null)
         {
            _closeFlg = false;
            _instance = new BirthdayManager();
            _closeFlg = true;
         }
         return _instance;
      }
      
      private function init() : void
      {
         _model = new BirthdayModel();
      }
      
      public function checkActiveHandler() : Boolean
      {
         var _loc1_:String = null;
         var _loc2_:Date = null;
         var _loc5_:Object = null;
         var _loc4_:Object = null;
         var _loc3_:Boolean = true;
         if(_birthdaySwitch)
         {
            _loc2_ = new Date(PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond * 1000);
            _loc5_ = DateFormatter.compareDate(_startDate,_loc2_);
            _loc4_ = DateFormatter.compareDate(_loc2_,_endDate);
            if(!_loc5_["flag"])
            {
               _loc3_ = false;
               _loc1_ = "activity.ActivityManager.command03";
            }
            else if(!_loc4_["flag"])
            {
               _loc3_ = false;
               _loc1_ = "activity.ActivityManager.command02";
            }
         }
         else
         {
            _loc3_ = false;
            _loc1_ = "activity.ActivityManager.command03";
         }
         if(_loc1_ != null)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation(_loc1_));
         }
         return _loc3_;
      }
      
      public function setup() : void
      {
         if(!SocketManager.instance.hasEventListener((4972).toString()))
         {
            SocketManager.instance.listener(4972,onReceiveDataHandler);
         }
      }
      
      private function onReceiveDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ActiveMsgLeaveOp = new ActiveMsgLeaveOp();
         _loc2_ = _loc3_.readBody(_loc2_) as ActiveMsgLeaveOp;
         _model.updateModel(_loc2_.msgList,_loc2_.count);
      }
      
      public function sendOperationToServer(param1:uint, param2:uint, param3:String = null) : void
      {
         var _loc5_:PackageOut = new PackageOut(8984);
         var _loc4_:ActiveMsgLeaveOp = new ActiveMsgLeaveOp();
         _loc4_.opType = param1;
         _loc4_.msgType = param2;
         if(param3 != null)
         {
            _loc4_.msgStr = param3;
         }
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public function get model() : BirthdayModel
      {
         return _model;
      }
      
      public function setBirthdaySwitch(param1:Boolean, param2:String, param3:String) : void
      {
         _birthdaySwitch = param1;
         if(_birthdaySwitch)
         {
            _startDate = DateFormatter.parse(param2,"YYYY-MM-DD hh:mm:ss");
            _endDate = DateFormatter.parse(param3,"YYYY-MM-DD hh:mm:ss");
         }
      }
   }
}

