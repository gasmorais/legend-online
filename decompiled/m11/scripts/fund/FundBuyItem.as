package fund
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.FundManager;
   import mvc.module.fund.ActiveParmaInfo;
   import mvc.module.fund.FundInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class FundBuyItem extends Component
   {
      
      private var _splitLine:Bitmap;
      
      private var _costImg:Bitmap;
      
      private var _getImg:Bitmap;
      
      private var _bg:ScaleFrameImage;
      
      private var _bg2:Bitmap;
      
      private var _getBtn:IconButton;
      
      private var _hbox:HBox;
      
      private var _vbox:VBox;
      
      private var _list:Array;
      
      private var _level:int = -1;
      
      private var _data:ActiveParmaInfo;
      
      private var _isNewbie:Boolean = FundManager.instance.isNewbie;
      
      private var _model:FundInfo;
      
      public function FundBuyItem()
      {
         super();
         initView();
         initEvent();
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
         _splitLine = ComponentFactory.Instance.creatBitmap("asset.fund.splitLine");
         _costImg = ComponentFactory.Instance.creatBitmap("asset.fund.cost");
         _getImg = ComponentFactory.Instance.creatBitmap("asset.fund.get");
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("fund.getBtn");
         _vbox = new VBox();
         _vbox.spacing = 3;
         _hbox = new HBox();
         _hbox.spacing = 2;
         addChild(_splitLine);
         addChild(_costImg);
         addChild(_getImg);
         addChild(_hbox);
         _hbox.x = 37;
         _hbox.y = 116;
         addChild(_vbox);
         _vbox.x = 43;
         _vbox.y = 142;
         addChild(_getBtn);
      }
      
      public function refreshData(param1:ActiveParmaInfo) : void
      {
         var _loc3_:FundItem = null;
         var _loc8_:FundItem = null;
         var _loc6_:int = 0;
         var _loc5_:FundItem = null;
         var _loc2_:int = 0;
         _data = param1;
         _level = param1.level;
         _bg2 = ComponentFactory.Instance.creatBitmap("asset.fund.iconBg");
         _bg = ComponentFactory.Instance.creatComponentByStylename("fund.LevelImg");
         _bg.setFrame(param1.level);
         addChild(_bg2);
         addChild(_bg);
         _bg.tipData = param1;
         if(param1.costDiamond > 0)
         {
            _loc3_ = new FundItem();
            _loc3_.show({
               "type":"0",
               "num":param1.costDiamond,
               "itemTempleteId":"-400"
            });
            _hbox.addChild(_loc3_);
            _list.push(_loc3_);
         }
         if(param1.costContract > 0)
         {
            _loc8_ = new FundItem();
            _loc8_.show({
               "type":"0",
               "num":param1.costContract,
               "itemTempleteId":"2125044"
            });
            _hbox.addChild(_loc8_);
            _list.push(_loc8_);
         }
         var _loc7_:Array = param1.totalGetInfo;
         var _loc4_:int = int(_loc7_.length);
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = new FundItem();
            _loc2_ = int(_loc7_[_loc6_].templateId);
            _loc5_.show({
               "type":"1",
               "num":_loc7_[_loc6_].count,
               "itemTempleteId":_loc2_
            });
            _vbox.addChild(_loc5_);
            _list.push(_loc5_);
            _loc6_++;
         }
         if(_model.depositLevel > 0)
         {
            _getBtn.enable = false;
         }
         else
         {
            _getBtn.enable = true;
         }
         resetSize();
      }
      
      private function resetSize() : void
      {
         if(_hbox.numChildren == 2)
         {
            _hbox.x = 38 + (85 - _hbox.width) / 2;
         }
         else
         {
            _hbox.x = _vbox.x + _vbox.width - _hbox.width;
         }
         _getBtn.y = _vbox.y + _vbox.height + 5;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("FUNDREFRESH",{
            "y":_getBtn.y,
            "num":_vbox.numChildren
         }));
      }
      
      private function initEvent() : void
      {
         _getBtn.addEventListener("click",__getBtnClickHandler);
         NotificationManager.instance.addEventListener("FUND_REFRESH",__fundRefreshHandler);
      }
      
      private function removeEvent() : void
      {
         _getBtn.removeEventListener("click",__getBtnClickHandler);
         NotificationManager.instance.removeEventListener("FUND_REFRESH",__fundRefreshHandler);
      }
      
      private function __fundRefreshHandler(param1:NotificationEvent) : void
      {
         if(_model.depositLevel > 0)
         {
            _getBtn.enable = false;
         }
         else
         {
            _getBtn.enable = true;
         }
      }
      
      private function payMoneyHandler(param1:Boolean, param2:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc3_:String = null;
         if(param1)
         {
            if(PlayerManager.instance.currentPlayerModel.playerInfo.point < _data.costDiamond)
            {
               RechargeAlertMannager.show();
               return;
            }
            _loc4_ = int(GoodsManager.instance.getBagCountByTempId(1,2125044));
            if(_data.costContract > _loc4_)
            {
               _loc3_ = LanguageMgr.GetTranslation("fund.FundBuyView.FundBuyItem.itemprompt");
               MessageTipManager.instance().show(_loc3_);
               return;
            }
            if(_isNewbie)
            {
               FundManager.instance.fundNewbieOperate(1,_level);
            }
            else
            {
               FundManager.instance.fundOperate(1,_level);
            }
         }
      }
      
      private function __getBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         var _loc3_:String = "";
         if(_data.costDiamond)
         {
            _loc3_ += _data.costDiamond;
            _loc3_ += LanguageMgr.GetTranslation("mainBar.WorldBossBuyBuffBar.point");
         }
         if(_data.costContract)
         {
            _loc3_ += _data.costContract;
            _loc3_ += LanguageMgr.GetTranslation("fund.FundBuyItem.contract");
         }
         if(_isNewbie)
         {
            _loc2_ = LanguageMgr.GetTranslation("fund.FundBuyItem.buyPrompt.NewbieText",_loc3_);
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("fund.FundBuyItem.buyPrompt",_loc3_);
         }
         SimpleAlertHelper.instance.data = [payMoneyHandler];
         SimpleAlertHelper.instance.popAlerFrame(LanguageMgr.GetTranslation("public.prompt"),_loc2_,LanguageMgr.GetTranslation("public.confirm"),LanguageMgr.GetTranslation("public.cancel"),true);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         ObjectUtils.disposeObject(_splitLine);
         _splitLine = null;
         ObjectUtils.disposeObject(_costImg);
         _costImg = null;
         ObjectUtils.disposeObject(_getImg);
         _bg = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_getBtn);
         _getBtn = null;
         ObjectUtils.removeChildAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

