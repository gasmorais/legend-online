package fund
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.FundManager;
   import mvc.module.fund.FundInfo;
   import mvc.module.fund.GetItemInfo;
   import yishi.manager.PlayerManager;
   
   public class FundNewDoubleGiftItem extends Component
   {
      
      private var _giftLable:FilterFrameText;
      
      private var _getBtn:IconButton;
      
      private var _hasGet:Bitmap;
      
      private var _data:GetItemInfo;
      
      private var _index:int = 0;
      
      private var _status:int = 0;
      
      private var _model:FundInfo;
      
      public function FundNewDoubleGiftItem(param1:int = 0)
      {
         super();
         _model = FundManager.instance.model;
         _index = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _giftLable = ComponentFactory.Instance.creatComponentByStylename("funny.doubleBagItem.giftLable01");
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("fundNewDoubleGiftItem.getBtn");
         _hasGet = ComponentFactory.Instance.creatBitmap("asset.core.ReceivedImg");
         addChild(_giftLable);
         addChild(_getBtn);
         addChild(_hasGet);
         _hasGet.x = 335;
         _hasGet.y = 0;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_getBtn);
         ObjectUtils.disposeObject(_hasGet);
         ObjectUtils.disposeObject(_giftLable);
      }
      
      private function initEvent() : void
      {
         if(_getBtn)
         {
            _getBtn.addEventListener("click",__getBtnHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_getBtn)
         {
            _getBtn.removeEventListener("click",__getBtnHandler);
         }
      }
      
      private function __getBtnHandler(param1:MouseEvent) : void
      {
         FundManager.instance.fundNewOperate(2,_data.times,_index + 1);
      }
      
      public function set data(param1:GetItemInfo) : void
      {
         if(!param1)
         {
            return;
         }
         _data = param1;
         if(_index == 0)
         {
            _status = _data.getA;
         }
         else
         {
            _status = _data.getB;
         }
         setState();
      }
      
      public function set index(param1:int) : void
      {
         _giftLable.setFrame(param1 % 2 + 1);
         if(param1 % 2 == 0)
         {
            _giftLable.text = LanguageMgr.GetTranslation("funny.view.FunnyDoubleBagItem.giftLable01");
         }
         else
         {
            _giftLable.text = LanguageMgr.GetTranslation("funny.view.FunnyDoubleBagItem.giftLable02");
         }
      }
      
      private function setState() : void
      {
         _hasGet.visible = false;
         _getBtn.visible = false;
         _getBtn.enable = false;
         if(FundManager.instance.getFlag)
         {
            if(_index + 1 == FundManager.instance.getIndex)
            {
               if(_status == 1)
               {
                  _hasGet.visible = true;
                  _getBtn.visible = false;
               }
               else if(_status == 3)
               {
                  _getBtn.visible = true;
                  _getBtn.enable = false;
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
                     _getBtn.tipData = "<font color=\'#fff6ca\'>" + LanguageMgr.GetTranslation("fund.fundRewardView.tip") + "</font>";
                  }
               }
            }
            else
            {
               _getBtn.visible = true;
               _getBtn.enable = false;
            }
         }
         else if(_status == 1)
         {
            _hasGet.visible = true;
            _getBtn.visible = false;
         }
         else if(_status == 3)
         {
            _getBtn.visible = true;
            _getBtn.enable = false;
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
               _getBtn.tipData = "<font color=\'#fff6ca\'>" + LanguageMgr.GetTranslation("fund.fundRewardView.tip") + "</font>";
            }
         }
      }
      
      private function get getBtnEnable() : Boolean
      {
         return PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond >= _model.getStartDate + _data.interval * 60;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

