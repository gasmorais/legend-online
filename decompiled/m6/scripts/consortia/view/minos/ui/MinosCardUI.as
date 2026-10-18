package consortia.view.minos.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MinosManager;
   import mvc.module.minos.MinosLevelInfo;
   import mvc.module.minos.MinosModel;
   import yishi.datas.templates.MinosLevelTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class MinosCardUI extends Sprite
   {
      
      protected var _lvbg:Bitmap;
      
      protected var _lvprobar:Bitmap;
      
      protected var _lvCardTxt:FilterFrameText;
      
      protected var _lvExportBtn:IconButton;
      
      protected var _lvExportProTxt:FilterFrameText;
      
      protected var _lvunLockBtn:IconButton;
      
      protected var _bossIcon:BaseIconView;
      
      protected var _lvUnlockMc:MovieClip;
      
      protected var _cardInfoTip:FilterFrameText;
      
      protected var _cardDesBg:Bitmap;
      
      protected var _cardDot:Bitmap;
      
      protected var _lvCardTipTxt:FilterFrameText;
      
      protected var _cardNeedLv:FilterFrameText;
      
      private var _goOnTip:FilterFrameText;
      
      private var _tipSp:Sprite;
      
      private var _proMask:Shape;
      
      private var _grayContainer:Sprite;
      
      private var _gray:Array;
      
      private var _isEvent:Boolean = false;
      
      private var _temp:MinosLevelTempInfo;
      
      public function MinosCardUI()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _gray = [UIFilter.getGrayFilter()];
         _lvbg = ComponentFactory.Instance.creatBitmap("asset.minos.lvbg");
         _lvprobar = ComponentFactory.Instance.creatBitmap("asset.minos.lvprobar");
         _lvCardTxt = ComponentFactory.Instance.creatComponentByStylename("ui.minos.lvCardTxt");
         _lvExportBtn = ComponentFactory.Instance.creatComponentByStylename("ui.minos.lvExportBtn");
         _lvExportProTxt = ComponentFactory.Instance.creatComponentByStylename("ui.minos.lvExportProTxt");
         _lvunLockBtn = ComponentFactory.Instance.creatComponentByStylename("ui.minos.lvunLockBtn");
         _bossIcon = ComponentFactory.Instance.creatCustomObject("ui.minos.bossIcon");
         _lvUnlockMc = ComponentFactory.Instance.creatCustomObject("ui.minos.lvUnlockMc");
         _cardInfoTip = ComponentFactory.Instance.creatComponentByStylename("ui.minos.cardInfoTip");
         _cardDesBg = ComponentFactory.Instance.creatBitmap("asset.minos.cardDesBg");
         _cardDot = ComponentFactory.Instance.creatBitmap("asset.minos.cardDot");
         _lvCardTipTxt = ComponentFactory.Instance.creatComponentByStylename("ui.minos.lvCardTipTxt");
         _cardNeedLv = ComponentFactory.Instance.creatComponentByStylename("ui.minos.cardNeedLv");
         _goOnTip = ComponentFactory.Instance.creatComponentByStylename("ui.minos.goOnTip");
         _proMask = new Shape();
         _proMask.graphics.beginFill(16711680);
         _proMask.graphics.drawRect(0,0,0,_lvprobar.height);
         _proMask.graphics.endFill();
         _grayContainer = new Sprite();
         _tipSp = new Sprite();
         addChild(_grayContainer);
         _grayContainer.addChild(_lvbg);
         _grayContainer.addChild(_lvCardTxt);
         _grayContainer.addChild(_bossIcon);
         addChild(_lvprobar);
         addChild(_proMask);
         addChild(_lvExportBtn);
         addChild(_lvExportProTxt);
         addChild(_lvunLockBtn);
         addChild(_lvUnlockMc);
         addChild(_cardInfoTip);
         addChild(_cardNeedLv);
         addChild(_goOnTip);
         addChild(_tipSp);
         _tipSp.addChild(_cardDesBg);
         _tipSp.addChild(_cardDot);
         _tipSp.addChild(_lvCardTipTxt);
         _grayContainer.filters = _gray;
         _proMask.x = _lvprobar.x;
         _proMask.y = _lvprobar.y;
         _lvprobar.mask = _proMask;
         _lvExportBtn.enable = false;
         _lvExportBtn.visible = false;
         _lvunLockBtn.enable = false;
         _tipSp.visible = false;
         _goOnTip.visible = false;
         _cardInfoTip.text = LanguageMgr.GetTranslation("minos.cardTip");
         _lvCardTipTxt.text = LanguageMgr.GetTranslation("minos.hasRewardTip");
         _goOnTip.text = LanguageMgr.GetTranslation("minos.goOn.tip");
      }
      
      public function set temp(param1:MinosLevelTempInfo) : void
      {
         _temp = param1;
         _lvCardTxt.text = _temp.LevelName;
         _bossIcon.icon = IconFactory.getIncreasinglyBossIcon(_temp.LevelImage);
         _cardNeedLv.text = LanguageMgr.GetTranslation("minos.open.needLv",_temp.GuildLevel);
      }
      
      private function initEvent() : void
      {
         _isEvent = true;
         _lvExportBtn.addEventListener("click",explortHandler);
      }
      
      private function removeEvent() : void
      {
         _isEvent = false;
         _lvExportBtn.removeEventListener("click",explortHandler);
      }
      
      private function explortHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("minos","Map",_temp.Id);
         FrameControllerManager.instance.minousCrl.setPreFrame("minos");
      }
      
      public function updateRewardState() : void
      {
         var _loc3_:Array = null;
         var _loc1_:MinosLevelInfo = model.mapLvInfoDic[_temp.Id];
         var _loc2_:Array = model.playInfo.levelRewardGets[_temp.Id];
         if(_loc1_)
         {
            _loc3_ = _loc1_.killList;
            if(_loc3_ && _loc3_.length > 0)
            {
               if(!_loc2_ || _loc2_.length < _loc3_.length)
               {
                  _tipSp.visible = true;
               }
               else
               {
                  _tipSp.visible = false;
               }
            }
            else
            {
               _tipSp.visible = false;
            }
         }
         else
         {
            _tipSp.visible = false;
         }
      }
      
      public function updateView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:MinosLevelInfo = model.mapLvInfoDic[_temp.Id];
         if(_loc2_)
         {
            _lvExportBtn.visible = true;
            _lvExportBtn.enable = true;
            _lvunLockBtn.visible = false;
            _lvUnlockMc.visible = false;
            _cardInfoTip.visible = false;
            _cardNeedLv.visible = false;
            _loc3_ = _loc2_.progress / _loc2_.progressMax * 100;
            if(_loc3_ >= 100)
            {
               _goOnTip.visible = false;
               _loc3_ = 100;
            }
            else
            {
               _goOnTip.visible = true;
            }
            _lvExportProTxt.text = LanguageMgr.GetTranslation("minos.cardPro",_loc3_);
            _loc1_ = _loc2_.progress / _loc2_.progressMax * _lvprobar.width;
            _proMask.graphics.clear();
            _proMask.graphics.beginFill(16711680);
            _proMask.graphics.drawRect(0,0,_loc1_,_lvprobar.height);
            _proMask.graphics.endFill();
            _grayContainer.filters = null;
            if(!_isEvent)
            {
               initEvent();
            }
         }
         else
         {
            _lvExportBtn.visible = false;
            _lvExportBtn.enable = false;
            _lvunLockBtn.visible = true;
            _lvUnlockMc.visible = true;
            _cardInfoTip.visible = true;
            _cardNeedLv.visible = true;
            _goOnTip.visible = false;
            _proMask.graphics.clear();
            _proMask.graphics.beginFill(16711680);
            _proMask.graphics.drawRect(0,0,0,_lvprobar.height);
            _proMask.graphics.endFill();
            _lvExportProTxt.text = LanguageMgr.GetTranslation("minos.cardPro",0);
            _grayContainer.filters = _gray;
            removeEvent();
         }
         updateRewardState();
      }
      
      private function get model() : MinosModel
      {
         return MinosManager.ins.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_lvbg);
         _lvbg = null;
         ObjectUtils.disposeObject(_lvprobar);
         _lvprobar = null;
         ObjectUtils.disposeObject(_lvCardTxt);
         _lvCardTxt = null;
         ObjectUtils.disposeObject(_lvExportBtn);
         _lvExportBtn = null;
         ObjectUtils.disposeObject(_lvExportProTxt);
         _lvExportProTxt = null;
         ObjectUtils.disposeObject(_lvunLockBtn);
         _lvunLockBtn = null;
         ObjectUtils.disposeObject(_bossIcon);
         _bossIcon = null;
         ObjectUtils.disposeViolentMc(_lvUnlockMc);
         _lvUnlockMc = null;
         ObjectUtils.disposeObject(_cardInfoTip);
         _cardInfoTip = null;
         ObjectUtils.disposeObject(_cardDesBg);
         _cardDesBg = null;
         ObjectUtils.disposeObject(_cardDot);
         _cardDot = null;
         ObjectUtils.disposeObject(_lvCardTipTxt);
         _lvCardTipTxt = null;
         ObjectUtils.disposeObject(_cardNeedLv);
         _cardNeedLv = null;
         ObjectUtils.disposeObject(_goOnTip);
         _goOnTip = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _gray = null;
         _temp = null;
      }
   }
}

