package fund
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.FundManager;
   import mvc.module.fund.FundInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.DateFormatter;
   
   public class FundBuyView extends Component
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _bg2:ScaleBitmapImage;
      
      private var _actOpentime:FilterFrameText;
      
      private var _actGettime:FilterFrameText;
      
      private var _actOpenTimeValue:FilterFrameText;
      
      private var _actGettimeValue:FilterFrameText;
      
      private var _promptTxt:FilterFrameText;
      
      private var _gotoPrepaidBtn:IconButton;
      
      private var _hbox:HBox;
      
      private var _list:Array;
      
      private var btnY:int;
      
      private var _isNewbie:Boolean = false;
      
      private var _model:FundInfo;
      
      private var _array1:Array = [];
      
      private var _array2:Array = [];
      
      public function FundBuyView()
      {
         super();
         _isNewbie = FundManager.instance.isNewbie;
         initView();
         initEvent();
         initHbox();
      }
      
      private function initView() : void
      {
         if(_isNewbie)
         {
            _model = FundManager.instance.newbieModel;
         }
         else
         {
            _model = FundManager.instance.model;
         }
         _list = [];
         _actOpentime = ComponentFactory.Instance.creatComponentByStylename("fund.actOpenTimeTxt");
         _actGettime = ComponentFactory.Instance.creatComponentByStylename("fund.actGetTimeTxt");
         _actOpenTimeValue = ComponentFactory.Instance.creatComponentByStylename("fund.actOpenTimeVauleTxt");
         _actGettimeValue = ComponentFactory.Instance.creatComponentByStylename("fund.actGetTimeVauleTxt");
         _promptTxt = ComponentFactory.Instance.creatComponentByStylename("fund.actpromptVauleTxt");
         _gotoPrepaidBtn = ComponentFactory.Instance.creatComponentByStylename("fund.gotoPrepaidBtn");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("fund.buyItemHBox");
         if(_isNewbie)
         {
            _actOpentime.visible = false;
            _actGettime.visible = false;
            _actOpenTimeValue.visible = false;
            _actGettimeValue.visible = false;
            _promptTxt.text = LanguageMgr.GetTranslation("fund.FundBuyView.promptTxt.NewbieText");
            _bg = ComponentFactory.Instance.creatComponentByStylename("fund.bg2");
            _bg.width = 590;
            _gotoPrepaidBtn.x = 429;
            addChild(_bg);
         }
         else
         {
            _gotoPrepaidBtn.x = 507;
            _bg2 = ComponentFactory.Instance.creatComponentByStylename("fund.bg4");
            _promptTxt.text = LanguageMgr.GetTranslation("fund.FundBuyView.promptTxt.text");
            addChild(_bg2);
         }
         addChild(_hbox);
         addChild(_actOpentime);
         _actOpentime.text = LanguageMgr.GetTranslation("fund.FundBuyView.actOpentime.text");
         addChild(_actGettime);
         _actGettime.text = LanguageMgr.GetTranslation("fund.FundBuyView.actGettime.text");
         addChild(_actOpenTimeValue);
         _actOpenTimeValue.text = DateFormatter.transDate(_model.setStartDate) + LanguageMgr.GetTranslation("fund.FundRewardView.getTime.line") + DateFormatter.transDate(_model.setEndDate);
         addChild(_actGettimeValue);
         _actGettimeValue.text = DateFormatter.transDate(_model.getStartDate) + LanguageMgr.GetTranslation("fund.FundRewardView.getTime.line") + DateFormatter.transDate(_model.getEndDate);
         addChild(_promptTxt);
         addChild(_gotoPrepaidBtn);
      }
      
      private function initHbox() : void
      {
         var _loc3_:int = 0;
         var _loc1_:FundBuyItem = null;
         var _loc2_:int = int(_model.activeArr.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = new FundBuyItem();
            _hbox.addChild(_loc1_);
            _list.push(_loc1_);
            _loc1_.refreshData(_model.activeArr[_loc3_]);
            _loc3_++;
         }
      }
      
      private function _gotoPrepaidBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         RechargeAlertMannager.navigateToRechargePage();
      }
      
      private function initEvent() : void
      {
         _gotoPrepaidBtn.addEventListener("click",_gotoPrepaidBtnHandler);
         NotificationManager.instance.addEventListener("FUNDREFRESH",refreshFundHandler);
      }
      
      private function removeEvnet() : void
      {
         _gotoPrepaidBtn.removeEventListener("click",_gotoPrepaidBtnHandler);
         NotificationManager.instance.removeEventListener("FUNDREFRESH",refreshFundHandler);
      }
      
      private function refreshFundHandler(param1:NotificationEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(btnY == int(param1.data.y))
         {
            return;
         }
         _array1.push(param1.data.y);
         var _loc2_:int = int(_array1[0]);
         _loc3_ = 0;
         while(_loc3_ < _array1.length)
         {
            if(_loc2_ < _array1[_loc3_])
            {
               _loc2_ = int(_array1[_loc3_]);
            }
            _loc3_++;
         }
         btnY = _loc2_;
         _actOpentime.y = btnY + 50 + _hbox.y;
         _actGettime.y = btnY + 70 + _hbox.y;
         _actOpenTimeValue.y = btnY + 50 + _hbox.y;
         _actGettimeValue.y = btnY + 70 + _hbox.y;
         _promptTxt.y = btnY + 90 + _hbox.y;
         _array2.push(param1.data.num);
         var _loc5_:int = int(_array2[0]);
         _loc4_ = 0;
         while(_loc4_ < _array2.length)
         {
            if(_loc5_ < _array2[_loc4_])
            {
               _loc5_ = int(_array2[_loc4_]);
            }
            _loc4_++;
         }
         if(_isNewbie)
         {
            _promptTxt.y = btnY + 50 + _hbox.y;
            _bg.height = btnY + 60;
         }
         else
         {
            _bg2.height = btnY + 60;
         }
         switch(_loc5_ - 1)
         {
            case 0:
               _gotoPrepaidBtn.y = 385;
               break;
            case 1:
               _gotoPrepaidBtn.y = 400;
               break;
            case 2:
               _gotoPrepaidBtn.y = 415;
         }
      }
      
      private function uninit() : void
      {
         var _loc1_:int = 0;
         if(_list)
         {
            while(_loc1_ < _list.length)
            {
               if(_list[_loc1_])
               {
                  ObjectUtils.disposeObject(_list[_loc1_]);
                  _list[_loc1_] = null;
               }
               _loc1_++;
            }
         }
      }
      
      override public function dispose() : void
      {
         uninit();
         _list = null;
         removeEvnet();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_actOpentime);
         _actOpentime = null;
         ObjectUtils.disposeObject(_actGettime);
         _actGettime = null;
         ObjectUtils.disposeObject(_actOpenTimeValue);
         _actOpenTimeValue = null;
         ObjectUtils.disposeObject(_actGettimeValue);
         _actGettimeValue = null;
         ObjectUtils.disposeObject(_promptTxt);
         _promptTxt = null;
         ObjectUtils.disposeObject(_gotoPrepaidBtn);
         _gotoPrepaidBtn = null;
         ObjectUtils.removeChildAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

