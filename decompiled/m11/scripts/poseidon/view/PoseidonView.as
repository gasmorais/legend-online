package poseidon.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.SelectedIconTextButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.PlayerCurrencyManager;
   import managers.PoseidonManager;
   import mvc.module.currency.PlayerCurrencyInfo;
   import poseidon.item.PoseidonItem;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RoyaltyBossManager;
   import yishi.manager.TempleteManager;
   
   public class PoseidonView extends Sprite
   {
      
      public var _back:Bitmap;
      
      public var _numBack:Bitmap;
      
      public var _noraml:SelectedIconButton;
      
      public var _step:SelectedIconButton;
      
      public var _allNum:FilterFrameText;
      
      public var _leftSp:ScrollPanel;
      
      public var _rightSp:ScrollPanel;
      
      public var _mainPriceIcon:ScaleFrameImage;
      
      private var _leftTile:SimpleTileList;
      
      private var _rightVbox:VBox;
      
      private var _leftItemArr:Array = [];
      
      private var _rightItemArr:Array = [];
      
      private var _leftGroup:SelectedButtonGroup;
      
      private var _rightGroup:SelectedButtonGroup;
      
      private var _isFirst:Boolean;
      
      private var _currencyInfo:PlayerCurrencyInfo;
      
      private var _cyName:String = "";
      
      public function PoseidonView()
      {
         super();
         _currencyInfo = PlayerCurrencyManager.instance.currencyInfo;
         initView();
         initLeft();
         initRight();
         initEvent();
         _leftGroup.selectIndex = 0;
         _rightGroup.selectIndex = 0;
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.poseridon.back");
         _numBack = ComponentFactory.Instance.creatBitmap("asset.poseridon.numBack");
         _noraml = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.noraml");
         _step = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.step");
         _allNum = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.allNum");
         _leftSp = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.leftSp");
         _rightSp = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.rightSp");
         _mainPriceIcon = ComponentFactory.Instance.creatComponentByStylename("ui.poseidonshop.mainPriceIcon");
         _rightVbox = ComponentFactory.Instance.creatCustomObject("ui.poseidonshop.leftVbox");
         _leftTile = ComponentFactory.Instance.creatCustomObject("ui.poseidonshop.rightSimpleTitle",[2]);
         addChild(_back);
         addChild(_numBack);
         addChild(_noraml);
         addChild(_step);
         addChild(_allNum);
         addChild(_leftSp);
         addChild(_rightSp);
         addChild(_mainPriceIcon);
         _rightSp.setView(_rightVbox);
         _leftSp.setView(_leftTile);
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-19000);
         if(_loc1_)
         {
            _cyName = _loc1_.Description;
         }
         _leftGroup = new SelectedButtonGroup();
         _leftGroup.addSelectItem(_noraml);
         _leftGroup.addSelectItem(_step);
      }
      
      private function initLeft() : void
      {
         var _loc1_:PoseidonItem = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 12)
         {
            _loc1_ = new PoseidonItem();
            _leftItemArr.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function initRight() : void
      {
         var _loc1_:SelectedIconTextButton = null;
         var _loc6_:Boolean = false;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         _rightGroup = new SelectedButtonGroup();
         _rightVbox.beginChanges();
         var _loc5_:int = int(RoyaltyBossManager.instance.model.royaltyLevel);
         var _loc3_:int = int(TempleteManager.instance.royaltyTempCate.maxLv);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("poseidon.rightSelectedBtn");
            _loc2_ = int(TempleteManager.instance.royaltyTempCate.getLockLv(_loc4_ + 1));
            _loc6_ = _loc5_ < _loc2_;
            _loc1_.enable = !_loc6_;
            if(_loc6_)
            {
               _loc1_.text = LanguageMgr.GetTranslation("poseidon.shopRightLock",_loc2_);
            }
            _rightItemArr.push(_loc1_);
            _rightVbox.addChild(_loc1_);
            _rightGroup.addSelectItem(_loc1_);
            _loc4_++;
         }
         _rightVbox.commitChanges();
         _leftSp.invalidateViewport();
      }
      
      private function refreshView() : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc1_:PoseidonItem = null;
         var _loc4_:int = 0;
         var _loc5_:SelectedIconTextButton = null;
         if(_leftGroup.selectIndex != -1 && _rightGroup.selectIndex != -1)
         {
            _mainPriceIcon.setFrame(_leftGroup.selectIndex + 1);
            _mainPriceIcon.tipData = _leftGroup.selectIndex == 0 ? _cyName : null;
            ObjectUtils.removeChildAllChildrenFromStage(_leftTile);
            _loc2_ = TempleteManager.instance.poseidonShopCate.getList(_leftGroup.selectIndex + 1,_rightGroup.selectIndex + 1);
            _loc3_ = int(_loc2_ ? _loc2_.length : 0);
            if(_loc2_)
            {
               _loc2_.sortOn("Id",16);
            }
            _leftTile.beginChanges();
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc1_ = getPoseidonItem(_loc4_);
               _loc1_.info = _loc2_[_loc4_];
               _leftTile.addChild(_loc1_);
               _loc4_++;
            }
            _leftTile.commitChanges();
            _rightSp.invalidateViewport();
            _loc4_ = 0;
            while(_loc4_ < _rightItemArr.length)
            {
               _loc5_ = _rightItemArr[_loc4_];
               if(_loc5_ && _loc5_.enable)
               {
                  if(_leftGroup.selectIndex == 0)
                  {
                     _loc5_.text = LanguageMgr.GetTranslation("poseidon.shopRightBtn",_loc4_ + 1);
                  }
                  else
                  {
                     _loc5_.text = LanguageMgr.GetTranslation("poseidon.shopRightBtn2",_loc4_ + 1);
                  }
               }
               _loc4_++;
            }
            if(!_isFirst)
            {
               _isFirst = true;
               PoseidonManager.Ins.requestInfo();
            }
         }
      }
      
      private function getPoseidonItem(param1:int) : PoseidonItem
      {
         var _loc2_:PoseidonItem = null;
         if(param1 >= _leftItemArr.length)
         {
            _loc2_ = new PoseidonItem();
            _leftItemArr.push(_loc2_);
         }
         else
         {
            _loc2_ = _leftItemArr[param1];
         }
         return _loc2_;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function initEvent() : void
      {
         _leftGroup.addEventListener("change",__leftTabChangeHandler);
         _rightGroup.addEventListener("change",__rightTabChangeHandler);
         PoseidonManager.Ins.addEventListener("EVENT_POSEIDON_REFRESH",refreshHandler);
         NotificationManager.instance.addEventListener("CURRENCYREFRESH",__updatePoint);
         playerInfo.addEventListener("PLAYER_INFO_UPDATE",__playerDataUpdate);
      }
      
      private function removeEvent() : void
      {
         _leftGroup.removeEventListener("change",__leftTabChangeHandler);
         _rightGroup.removeEventListener("change",__rightTabChangeHandler);
         PoseidonManager.Ins.removeEventListener("EVENT_POSEIDON_REFRESH",refreshHandler);
         NotificationManager.instance.removeEventListener("CURRENCYREFRESH",__updatePoint);
         playerInfo.removeEventListener("PLAYER_INFO_UPDATE",__playerDataUpdate);
      }
      
      private function __playerDataUpdate(param1:PlayerEvent = null) : void
      {
         if(_leftGroup.selectIndex == 1)
         {
            _allNum.text = playerInfo.point.toString();
         }
      }
      
      private function __updatePoint(param1:NotificationEvent = null) : void
      {
         if(_leftGroup.selectIndex == 0)
         {
            if(_currencyInfo.poseidonCoin)
            {
               _allNum.text = _currencyInfo.poseidonCoin.amount.toString();
            }
         }
      }
      
      private function refreshHandler(param1:Event) : void
      {
         var _loc2_:PoseidonItem = null;
         var _loc4_:int = 0;
         var _loc3_:int = int(_leftTile.numChildren);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _leftTile.getChildAt(_loc4_) as PoseidonItem;
            if(_loc2_)
            {
               _loc2_.refreshView();
            }
            _loc4_++;
         }
      }
      
      private function __leftTabChangeHandler(param1:Event) : void
      {
         __updatePoint();
         __playerDataUpdate();
         refreshView();
      }
      
      private function __rightTabChangeHandler(param1:Event) : void
      {
         refreshView();
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_numBack);
         _numBack = null;
         ObjectUtils.disposeObject(_noraml);
         _noraml = null;
         ObjectUtils.disposeObject(_step);
         _step = null;
         ObjectUtils.disposeObject(_allNum);
         _allNum = null;
         ObjectUtils.disposeObject(_leftSp);
         _leftSp = null;
         ObjectUtils.disposeObject(_rightSp);
         _rightSp = null;
         ObjectUtils.disposeObject(_mainPriceIcon);
         _mainPriceIcon = null;
         for each(var _loc1_:PoseidonItem in _leftItemArr)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _leftItemArr = null;
         for each(var _loc2_:SelectedIconTextButton in _rightItemArr)
         {
            ObjectUtils.disposeObject(_loc2_);
         }
         _rightItemArr = null;
         ObjectUtils.disposeObject(_leftGroup);
         _leftGroup = null;
         ObjectUtils.disposeObject(_rightGroup);
         _rightGroup = null;
         ObjectUtils.disposeObject(_leftTile);
         _leftTile = null;
         ObjectUtils.disposeObject(_rightVbox);
         _rightVbox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

