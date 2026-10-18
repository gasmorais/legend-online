package fund
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.FundManager;
   import mvc.module.fund.FundInfo;
   import mvc.module.fund.GItemInfo;
   import mvc.module.fund.GLogInfo;
   import mvc.module.fund.GetItemInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   
   public class FundRewardItem extends Component
   {
      
      private var _icon:Bitmap;
      
      private var _getTime:FilterFrameText;
      
      private var _valueImg:Bitmap;
      
      private var _getBtn:IconButton;
      
      private var _hasGetImg:ScaleBitmapImage;
      
      private var _hbox:HBox;
      
      private var _rewardBg:Bitmap;
      
      private var _splitLine:Bitmap;
      
      private var _data:GetItemInfo;
      
      private var _tipsBtn:BaseButton;
      
      private var _list:Array;
      
      private var _isNewbie:Boolean = FundManager.instance.isNewbie;
      
      private var _model:FundInfo;
      
      public function FundRewardItem()
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
         _valueImg = ComponentFactory.Instance.creatBitmap("asset.fund.value");
         _getTime = ComponentFactory.Instance.creatComponentByStylename("fund.totalgetTxt_2");
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("fund.Item.Btn");
         _hasGetImg = ComponentFactory.Instance.creatComponentByStylename("fund.hasGetImg");
         _rewardBg = ComponentFactory.Instance.creatBitmap("asset.fund.rewardbg");
         _splitLine = ComponentFactory.Instance.creatBitmap("asset.fund.splitLine2");
         _tipsBtn = ComponentFactory.Instance.creatComponentByStylename("fund.tipBtn");
         addChild(_valueImg);
         addChild(_getTime);
         addChild(_getBtn);
         addChild(_hasGetImg);
         addChild(_rewardBg);
         addChild(_tipsBtn);
         _tipsBtn.alpha = 0;
         _hbox = new HBox();
         _hbox.x = 112;
         _hbox.y = 31;
         _hbox.spacing = 10;
         addChild(_hbox);
         addChild(_splitLine);
         if(_isNewbie)
         {
            _tipsBtn.tipData = "<font color=\'#fff6ca\'>" + LanguageMgr.GetTranslation("fund.fundRewardView.NewbieTip") + "</font>";
         }
         else
         {
            _tipsBtn.tipData = "<font color=\'#fff6ca\'>" + LanguageMgr.GetTranslation("fund.fundRewardView.tip") + "</font>";
         }
      }
      
      private function initEvent() : void
      {
         _getBtn.addEventListener("click",__getBtnClickHandler);
         NotificationManager.instance.addEventListener("FUND_REFRESH",refresh);
      }
      
      private function __getBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_isNewbie)
         {
            FundManager.instance.fundNewbieOperate(2,_data.times);
         }
         else
         {
            FundManager.instance.fundOperate(2,_data.times);
         }
      }
      
      private function removeEvent() : void
      {
         _getBtn.removeEventListener("click",__getBtnClickHandler);
         NotificationManager.instance.removeEventListener("FUND_REFRESH",refresh);
      }
      
      public function set data(param1:GetItemInfo) : void
      {
         var _loc7_:int = 0;
         var _loc4_:FundItem = null;
         var _loc6_:GItemInfo = null;
         var _loc3_:int = 0;
         _data = param1;
         refresh(null);
         if(_data == null)
         {
            return;
         }
         var _loc2_:Array = _data.itemInfos;
         _icon = ComponentFactory.Instance.creatBitmap("asset.fund.rewardIcon_" + _data.times);
         var _loc5_:int = int(_loc2_.length);
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc4_ = new FundItem();
            _loc6_ = _loc2_[_loc7_] as GItemInfo;
            _loc3_ = int(_loc6_.templateId);
            _loc4_.show({
               "type":"0",
               "num":_loc6_.count,
               "itemTempleteId":_loc3_
            });
            _hbox.addChild(_loc4_);
            _list.push(_loc4_);
            _loc7_++;
         }
         if(_isNewbie)
         {
            _getTime.text = LanguageMgr.GetTranslation("fund.FundRewardView.getTime.NewbieText",_data.interval);
         }
         else
         {
            _getTime.text = LanguageMgr.GetTranslation("fund.FundRewardView.getTime.text") + DateFormatter.transDate(_model.getStartDate + _data.interval * 60);
         }
         addChild(_icon);
      }
      
      private function resetSize() : void
      {
         _hbox.x = 125;
      }
      
      public function refresh(param1:NotificationEvent) : void
      {
         _hasGetImg.visible = false;
         _getBtn.visible = false;
         _getBtn.enable = false;
         _tipsBtn.visible = false;
         if(getIsGet(_data.times))
         {
            _hasGetImg.visible = true;
         }
         else
         {
            _getBtn.visible = true;
            if(getBtnEnable)
            {
               _getBtn.enable = true;
            }
            else
            {
               _tipsBtn.visible = true;
            }
         }
      }
      
      private function get getBtnEnable() : Boolean
      {
         if(_isNewbie)
         {
            return ArmyManager.instance.thane.grades >= _data.interval;
         }
         return PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond >= _model.getStartDate + _data.interval * 60;
      }
      
      public function getIsGet(param1:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:GLogInfo = null;
         var _loc2_:Array = _model.getLogArr;
         if(!_loc2_)
         {
            return false;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc4_];
            if(param1 == _loc3_.type)
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _data = null;
         _icon = null;
         _getTime = null;
         _valueImg = null;
         _getBtn = null;
         _hasGetImg = null;
      }
   }
}

