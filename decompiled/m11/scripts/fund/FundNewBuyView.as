package fund
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.FundManager;
   import mvc.module.fund.FundInfo;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.DateFormatter;
   
   public class FundNewBuyView extends Component
   {
      
      public static const SPLITE_LOCATIONY:int = 143;
      
      public static const SPLITE_HEIGHT:int = 73;
      
      public static const SPLITE_LOCATIONX:int = 123;
      
      private var _actOpentime:FilterFrameText;
      
      private var _promptTxt:FilterFrameText;
      
      private var _vbox:VBox;
      
      private var _model:FundInfo;
      
      private var _spliteLine1:Bitmap;
      
      private var _spliteLine2:Bitmap;
      
      private var _spliteLine3:Bitmap;
      
      private var _spliteLine4:Bitmap;
      
      private var _spliteLine5:Bitmap;
      
      private var _hasChargeAlert:FilterFrameText;
      
      private var _hasChargePoint:FilterFrameText;
      
      private var _pointImage:Image;
      
      private var _rechargeBtn:IconButton;
      
      public function FundNewBuyView()
      {
         super();
         _model = FundManager.instance.model;
         initView();
         initData();
         addEvent();
      }
      
      private function initView() : void
      {
         _actOpentime = ComponentFactory.Instance.creatComponentByStylename("fund.newbuy.actOpenTimeTxt");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("fund.newbuyItemVBox");
         _promptTxt = ComponentFactory.Instance.creatComponentByStylename("fund.newbuy.actpromptVauleTxt");
         _spliteLine1 = ComponentFactory.Instance.creatBitmap("asset.fundnew.spliteLine");
         _spliteLine2 = ComponentFactory.Instance.creatBitmap("asset.fundnew.spliteLine");
         _spliteLine3 = ComponentFactory.Instance.creatBitmap("asset.fundnew.spliteLine");
         _spliteLine4 = ComponentFactory.Instance.creatBitmap("asset.fundnew.spliteLine");
         _spliteLine5 = ComponentFactory.Instance.creatBitmap("asset.fundnew.spliteLine");
         _hasChargeAlert = ComponentFactory.Instance.creatComponentByStylename("fund.FundNewBuyView.hasChargeAlert");
         _hasChargePoint = ComponentFactory.Instance.creatComponentByStylename("fund.FundNewBuyView.hasChargePoint");
         _pointImage = ComponentFactory.Instance.creatComponentByStylename("fund.FundNewBuyView.pointImage");
         _rechargeBtn = ComponentFactory.Instance.creatComponentByStylename("fund.recharge");
         addChild(_spliteLine1);
         addChild(_spliteLine2);
         addChild(_spliteLine3);
         addChild(_spliteLine4);
         addChild(_spliteLine5);
         addChild(_vbox);
         addChild(_actOpentime);
         addChild(_promptTxt);
         addChild(_hasChargeAlert);
         addChild(_hasChargePoint);
         addChild(_pointImage);
         addChild(_rechargeBtn);
         _spliteLine1.x = _spliteLine2.x = _spliteLine3.x = _spliteLine4.x = _spliteLine5.x = 123;
         _spliteLine1.y = 143;
         _spliteLine2.y = 143 + 73 * 1;
         _spliteLine3.y = 143 + 73 * 2;
         _spliteLine4.y = 143 + 73 * 3;
         _spliteLine5.y = 143 + 73 * 4;
         _actOpentime.text = LanguageMgr.GetTranslation("fund.FundNewBuyView.actOpentime.text",DateFormatter.transDate(_model.setStartDate),DateFormatter.transDate(_model.setEndDate));
         _promptTxt.text = LanguageMgr.GetTranslation("fund.FundNewBuyView.promptTxt.text");
         _hasChargeAlert.text = LanguageMgr.GetTranslation("fund.FundBuyView.totalEnchargeTxt.text");
         _hasChargePoint.text = _model.chargePoint.toString();
      }
      
      private function addEvent() : void
      {
         _rechargeBtn.addEventListener("click",__rechargeHandler);
      }
      
      private function removeEvent() : void
      {
         if(_rechargeBtn)
         {
            _rechargeBtn.removeEventListener("click",__rechargeHandler);
         }
      }
      
      private function __rechargeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         RechargeAlertMannager.navigateToRechargePage();
      }
      
      private function uninitView() : void
      {
         if(_vbox)
         {
            ObjectUtils.disposeObject(_vbox);
         }
         _vbox = null;
         if(_actOpentime)
         {
            ObjectUtils.disposeObject(_actOpentime);
         }
         _actOpentime = null;
         if(_promptTxt)
         {
            ObjectUtils.disposeObject(_promptTxt);
         }
         _promptTxt = null;
         if(_spliteLine1)
         {
            ObjectUtils.disposeObject(_spliteLine1);
         }
         _spliteLine1 = null;
         if(_spliteLine2)
         {
            ObjectUtils.disposeObject(_spliteLine2);
         }
         _spliteLine2 = null;
         if(_spliteLine3)
         {
            ObjectUtils.disposeObject(_spliteLine3);
         }
         _spliteLine3 = null;
         if(_spliteLine4)
         {
            ObjectUtils.disposeObject(_spliteLine4);
         }
         _spliteLine4 = null;
         if(_spliteLine5)
         {
            ObjectUtils.disposeObject(_spliteLine5);
         }
         _spliteLine5 = null;
         if(_hasChargeAlert)
         {
            ObjectUtils.disposeObject(_hasChargeAlert);
         }
         _hasChargeAlert = null;
         if(_hasChargePoint)
         {
            ObjectUtils.disposeObject(_hasChargePoint);
         }
         _hasChargePoint = null;
         if(_pointImage)
         {
            ObjectUtils.disposeObject(_pointImage);
         }
         _pointImage = null;
         if(_rechargeBtn)
         {
            ObjectUtils.disposeObject(_rechargeBtn);
         }
         _rechargeBtn = null;
      }
      
      private function initData() : void
      {
         var _loc3_:int = 0;
         var _loc1_:FundNewBuyItem = null;
         if(!_model.newActiveArr)
         {
            return;
         }
         var _loc2_:int = int(_model.newActiveArr.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = new FundNewBuyItem();
            if(_vbox)
            {
               _vbox.addChild(_loc1_);
            }
            _loc1_.data = _model.newActiveArr[_loc3_];
            _loc3_++;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         ObjectUtils.removeChildAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

