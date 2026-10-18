package mvc.module.vip
{
   import events.VIPEvent;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import manager.LanguageMgr;
   import yishi.manager.TempleteManager;
   
   public class VIPModel extends EventDispatcher
   {
      
      public static var OPEN_GIFT_FRAME:int = 1;
      
      public static var OPEN_PRIVILEGE_FRAME:int = 2;
      
      public static var OPEN_VIPBOX_FRAME:int = 3;
      
      public static var VIP_FRIEND:int = 4;
      
      public static var VIP_HDILA:int = 7;
      
      public static var VIP_ACTIVE:int = 2;
      
      public static var VIP_COOL:int = 16;
      
      private var _one_MonthPoint:int;
      
      private var _three_MonthPoint:int;
      
      private var _six_MonthPoint:int;
      
      private var _delayTime:Number = 0;
      
      public var curOpenVipBox:Boolean;
      
      private var _vipInfo:VipInfo;
      
      private var _rouletteInfo:VipRouletteInfo;
      
      public function VIPModel(param1:IEventDispatcher = null)
      {
         super(param1);
         _vipInfo = new VipInfo();
      }
      
      public function get one_MonthPoint() : int
      {
         return _one_MonthPoint;
      }
      
      public function set one_MonthPoint(param1:int) : void
      {
         _one_MonthPoint = param1;
      }
      
      public function get three_MonthPoint() : int
      {
         return _three_MonthPoint;
      }
      
      public function set three_MonthPoint(param1:int) : void
      {
         _three_MonthPoint = param1;
      }
      
      public function get six_MonthPoint() : int
      {
         return _six_MonthPoint;
      }
      
      public function set six_MonthPoint(param1:int) : void
      {
         _six_MonthPoint = param1;
      }
      
      public function get delayTime() : Number
      {
         return _delayTime;
      }
      
      public function set delayTime(param1:Number) : void
      {
         _delayTime = param1;
      }
      
      public function get vipInfo() : VipInfo
      {
         return _vipInfo;
      }
      
      public function set vipInfo(param1:VipInfo) : void
      {
         var _loc3_:String = null;
         var _loc2_:Object = null;
         if(_vipInfo.VipGrade < param1.VipGrade && _vipInfo.VipGrade > 0)
         {
            _vipInfo = param1;
            _loc3_ = LanguageMgr.GetTranslation("tasktracetip.view.VipUpGradeTipView.TitleTxt");
            _loc2_ = {
               "type":21,
               "title":_loc3_
            };
            dispatchEvent(new VIPEvent("vip_recharge_tip",_loc2_));
         }
         else
         {
            _vipInfo = param1;
         }
         if(_vipInfo.IsTakeGift && _vipInfo.IsVipAndNoExpirt)
         {
            _loc3_ = LanguageMgr.GetTranslation("tasktracetip.view.VipGiftGetTipView.TitleTxt");
            _loc2_ = {
               "type":22,
               "title":_loc3_
            };
            dispatchEvent(new VIPEvent("vip_recharge_tip",_loc2_));
         }
         dispatchEvent(new VIPEvent("upframeview_change"));
      }
      
      public function get rouletteInfo() : VipRouletteInfo
      {
         return _rouletteInfo;
      }
      
      public function set rouletteInfo(param1:VipRouletteInfo) : void
      {
         _rouletteInfo = param1;
      }
      
      public function commitOpenBoxEvent() : void
      {
         dispatchEvent(new VIPEvent("vip_open_box"));
      }
      
      public function vipOpenTips() : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("tasktracetip.view.VipRechargeTipView.TitleTxt");
         var _loc1_:Object = {
            "type":23,
            "title":_loc2_
         };
         dispatchEvent(new VIPEvent("vip_recharge_tip",_loc1_));
      }
      
      public function get vipFriendPrivilege() : int
      {
         var _loc2_:int = 0;
         if(!_vipInfo.IsVipAndNoExpirt)
         {
            return 0;
         }
         var _loc1_:Array = TempleteManager.instance.vipPrerogativeTemplateCate.getTemplatesByType(VIPModel.VIP_FRIEND);
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            if(_vipInfo.VipGrade == _loc1_[_loc2_].grade)
            {
               if(_loc1_[_loc2_].para1 == 0)
               {
                  return 0;
               }
               return 50;
            }
            _loc2_++;
         }
         return 0;
      }
      
      public function get vipActivePrivilege() : int
      {
         var _loc2_:int = 0;
         if(!_vipInfo.IsVipAndNoExpirt)
         {
            return 0;
         }
         var _loc1_:Array = TempleteManager.instance.vipPrerogativeTemplateCate.getTemplatesByType(2);
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            if(_vipInfo.VipGrade == _loc1_[_loc2_].grade)
            {
               return _loc1_[_loc2_].para1;
            }
            _loc2_++;
         }
         return 0;
      }
      
      public function get vipCoolPrivilege() : Boolean
      {
         var _loc2_:int = 0;
         if(!_vipInfo.IsVipAndNoExpirt)
         {
            return false;
         }
         var _loc1_:Array = TempleteManager.instance.vipPrerogativeTemplateCate.getVipPrerogativeTypeTempList(VIPModel.VIP_COOL);
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            if(_vipInfo.VipGrade == _loc1_[_loc2_].grade)
            {
               if(_loc1_[_loc2_].para1 == 0)
               {
                  return false;
               }
               return true;
            }
            _loc2_++;
         }
         return false;
      }
   }
}

