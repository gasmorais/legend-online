package magicCard.view.base
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.utils.clearTimeout;
   import magicCard.MagicCardCheckFrame;
   import magicCard.view.MagicCardCell;
   import manager.LanguageMgr;
   import mvc.module.card.MagicCardInfo;
   import yishi.datas.templates.MagicCardTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.GoodsManager;
   import yishi.manager.MagicCardManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   
   public class MagicCardSlotItem extends Sprite implements Disposeable
   {
      
      protected var _bg:ScaleFrameImage;
      
      protected var _shineBg:Scale9CornerImage;
      
      protected var _cell:MagicCardCell;
      
      protected var _levelupBtn:IconButton;
      
      protected var _checkBtn:IconButton;
      
      protected var _shareBtn:IconButton;
      
      private var _cardBoardEff:MovieClip;
      
      protected var _centerEffect:MovieClip;
      
      private var _delayId:uint;
      
      protected var _cardTempInfo:MagicCardTemplateInfo;
      
      protected var _canActiveBg:MovieClip;
      
      protected var _activeBtn:IconButton;
      
      private var _type:int;
      
      private var _pos:int;
      
      private var _gardes:int;
      
      private var _activeMc:MovieClip;
      
      private var _isActive:Boolean = false;
      
      private var _hadActiveItem:Boolean = false;
      
      public function MagicCardSlotItem()
      {
         super();
         initView();
         initEvent();
      }
      
      protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("magicCard.cardSlotItem.ItemBg");
         _shineBg = ComponentFactory.Instance.creatComponentByStylename("magicCard.cardSlotItem.shineBg");
         _cell = ComponentFactory.Instance.creatCustomObject("magicCard.magicCardCell");
         _levelupBtn = ComponentFactory.Instance.creatComponentByStylename("magicCard.cardSlotItem.levelupBtn");
         _checkBtn = ComponentFactory.Instance.creatComponentByStylename("magicCard.cardSlotItem.checkBtn");
         _shareBtn = ComponentFactory.Instance.creatComponentByStylename("magicCard.cardSlotItem.shareBtn");
         _cardBoardEff = ComponentFactory.Instance.creatCustomObject("magicCard.cardBoardEffect");
         _activeMc = ComponentFactory.Instance.creatCustomObject("MagicCardSlotItem.ActiveMc");
         addChild(_bg);
         addChild(_shineBg);
         addChild(_cell);
         addChild(_cardBoardEff);
         addChild(_levelupBtn);
         addChild(_checkBtn);
         addChild(_shareBtn);
         _bg.setFrame(2);
         _shineBg.visible = false;
         _levelupBtn.visible = false;
         _checkBtn.visible = false;
         _shareBtn.visible = false;
         _cardBoardEff.visible = false;
         _cardBoardEff.gotoAndStop(_cardBoardEff.totalFrames);
         _activeMc.stop();
         _activeMc.visible = false;
         addChild(_activeMc);
         _checkBtn.tipData = LanguageMgr.GetTranslation("card.CardFrame.check");
         _shareBtn.tipData = LanguageMgr.GetTranslation("card.CardFrame.share");
      }
      
      private function initEvent() : void
      {
         addEventListener("rollOver",__overHandler);
         addEventListener("rollOut",__outHandler);
         _levelupBtn.addEventListener("mouseDown",__levelupMouseDownHandler);
         _levelupBtn.addEventListener("mouseUp",__levelupMouseUpHandler);
         _levelupBtn.addEventListener("rollOut",__levelupRollOutHandler);
         _checkBtn.addEventListener("click",__checkHandler);
         _shareBtn.addEventListener("click",__shareHandler);
         if(_activeBtn)
         {
            _activeBtn.addEventListener("click",onActiveClick);
         }
      }
      
      protected function __levelupMouseDownHandler(param1:MouseEvent) : void
      {
         MagicCardManager.Instance.updateMagicCard(1,_cardTempInfo.TemplateId);
      }
      
      protected function __levelupMouseUpHandler(param1:MouseEvent) : void
      {
         clearTimeout(_delayId);
      }
      
      protected function __levelupRollOutHandler(param1:MouseEvent) : void
      {
         clearTimeout(_delayId);
      }
      
      protected function __checkHandler(param1:MouseEvent) : void
      {
         MagicCardManager.Instance.cardModel.isSelfCheck = true;
         var _loc2_:MagicCardCheckFrame = ComponentFactory.Instance.creatComponentByStylename("magicCard.MagicCardCheckFrame");
         _loc2_.data = MagicCardManager.Instance.cardModel.getInfoByTypeAndPos(_type,_pos);
         _loc2_.show();
      }
      
      protected function __shareHandler(param1:MouseEvent) : void
      {
         var _loc2_:MagicCardInfo = MagicCardManager.Instance.cardModel.getInfoByTypeAndPos(_type,_pos);
         NotificationManager.instance.sendNotification("SEND_CARD",_loc2_);
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         if(!_isActive)
         {
            return;
         }
         _shineBg.visible = true;
         _levelupBtn.visible = true;
         _checkBtn.visible = true;
         _shareBtn.visible = true;
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         _shineBg.visible = false;
         _levelupBtn.visible = false;
         _checkBtn.visible = false;
         _shareBtn.visible = false;
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__overHandler);
         removeEventListener("rollOut",__outHandler);
         _levelupBtn.removeEventListener("mouseDown",__levelupMouseDownHandler);
         _levelupBtn.removeEventListener("mouseUp",__levelupMouseUpHandler);
         _levelupBtn.removeEventListener("rollOut",__levelupRollOutHandler);
         _checkBtn.removeEventListener("click",__checkHandler);
         _shareBtn.removeEventListener("click",__shareHandler);
         if(_activeBtn)
         {
            _activeBtn.removeEventListener("click",onActiveClick);
         }
      }
      
      private function onActiveClick(param1:MouseEvent) : void
      {
         MagicCardManager.Instance.updateMagicCard(2,_cardTempInfo.TemplateId);
      }
      
      public function get isOpen() : Boolean
      {
         if(_bg.getFrame == 1)
         {
            return false;
         }
         return true;
      }
      
      public function setTypeAndPos(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:int = 0;
         _cell.setScale = 0.36;
         _cell.setLevelupScale = 0.85;
         _cell.setTypeAndPos(param1,param2,param3);
         if(_shineBg)
         {
            _shineBg.visible = false;
         }
         if(_type != param1)
         {
            _isActive = false;
         }
         if(_activeMc)
         {
            _activeMc.visible = false;
            _activeMc.stop();
         }
         if(MagicCardManager.Instance.cardModel.activatedPosByType[param1])
         {
            if(MagicCardManager.Instance.cardModel.activatedPosByType[param1].indexOf(param2) != -1)
            {
               if(_type == param1 && _pos == param2 && _gardes == param3 && _activeMc && !_isActive)
               {
                  _activeMc.visible = true;
                  _activeMc.gotoAndPlay(1);
               }
               _isActive = true;
               _levelupBtn.tipData = MagicCardManager.Instance.cardModel.getInfoByTypeAndPos(param1,param2);
            }
         }
         _type = param1;
         _pos = param2;
         _gardes = param3;
         _cardTempInfo = TempleteManager.instance.magicCardTemplateCate.getTempInfoByTypePosGrades(param1,param2,param3);
         if(_cardTempInfo != null)
         {
            _loc4_ = GoodsManager.instance.getGoodsNumByTempId(_cardTempInfo.ActiveNeedTempId) + GoodsManager.instance.getConsoritaBagGoodsNumByTempId(_cardTempInfo.ActiveNeedTempId);
            _hadActiveItem = false;
            if(_loc4_ > 0)
            {
               _hadActiveItem = true;
            }
         }
         updateView();
         isPlayEffect(param1,param2);
      }
      
      public function updateView() : void
      {
         var _loc1_:ColorMatrixFilter = null;
         _cell.filters = [];
         if(_canActiveBg != null && this.contains(_canActiveBg))
         {
            removeChild(_canActiveBg);
         }
         if(_activeBtn != null && this.contains(_activeBtn))
         {
            removeChild(_activeBtn);
         }
         if(!_isActive)
         {
            _loc1_ = UIFilter.getBlackFilter();
            _cell.filters = [_loc1_];
            if(_hadActiveItem)
            {
               if(_canActiveBg == null)
               {
                  _canActiveBg = ComponentFactory.Instance.creatCustomObject("MagicCardSlotItem.canActiveBG");
               }
               if(_activeBtn == null)
               {
                  _activeBtn = ComponentFactory.Instance.creatComponentByStylename("magicCard.cardSlotItem.ActiveBtn");
                  _activeBtn.addEventListener("click",onActiveClick);
               }
               addChild(_canActiveBg);
               addChild(_activeBtn);
            }
         }
      }
      
      public function isPlayEffect(param1:int, param2:int) : void
      {
         var _loc3_:MagicCardInfo = MagicCardManager.Instance.cardModel.getInfoByTypeAndPos(param1,param2);
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc3_.isActive)
         {
            _cardBoardEff.visible = true;
            _cardBoardEff.gotoAndPlay(1);
            _loc3_.isActive = false;
         }
         else
         {
            _cardBoardEff.gotoAndStop(_cardBoardEff.totalFrames);
            _cardBoardEff["mcLight"].gotoAndStop(1);
         }
      }
      
      public function setFrame(param1:int) : void
      {
         _bg.setFrame(param1);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_shineBg);
         _shineBg = null;
         ObjectUtils.disposeObject(_cell);
         _cell = null;
         ObjectUtils.disposeObject(_levelupBtn);
         _levelupBtn = null;
         ObjectUtils.disposeObject(_checkBtn);
         _checkBtn = null;
         ObjectUtils.disposeObject(_shareBtn);
         _shareBtn = null;
         ObjectUtils.disposeObject(_cardBoardEff);
         _cardBoardEff = null;
         ObjectUtils.disposeObject(_centerEffect);
         _centerEffect = null;
         ObjectUtils.disposeObject(_canActiveBg);
         _canActiveBg = null;
         ObjectUtils.disposeObject(_activeBtn);
         _activeBtn = null;
         ObjectUtils.disposeObject(_activeMc);
         _activeMc = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

