package gamehall.room
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.GameHallManager;
   import mvc.module.gamehall.GameHallModel;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.FlickerHelper;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class GameHallBuyBufferView extends Sprite
   {
      
      private var _buyBufferBtn:IconButton;
      
      private var _bufferTitleTxt:FilterFrameText;
      
      private var _bufferDescTxt:FilterFrameText;
      
      private var _bufferIconView:BaseIconView;
      
      private var _bufferText:FilterFrameText;
      
      private var _bufferSKillId:int = 9200010;
      
      private var _model:GameHallModel;
      
      private var _x3:Bitmap;
      
      public function GameHallBuyBufferView()
      {
         super();
         _model = GameHallManager.instance.model;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _buyBufferBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamEastLeftView.buyBufferBtn");
         _bufferTitleTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamEastLeftView.bufferTitleTxt");
         _bufferDescTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamEastLeftView.bufferDescTxt");
         _bufferIconView = ComponentFactory.Instance.creatCustomObject("gamehall.room.GameHallSceneEastBlessBaseItemView.baseIconView");
         _bufferText = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamEastLeftView.bufferText");
         _x3 = ComponentFactory.Instance.creatBitmap("asset.gamehall.x3flg");
         addChild(_buyBufferBtn);
         addChild(_bufferTitleTxt);
         addChild(_bufferDescTxt);
         addChild(_bufferIconView);
         _bufferIconView.x = 34;
         _bufferIconView.y = 5;
         addChild(_bufferText);
         addChild(_x3);
         _bufferTitleTxt.text = LanguageMgr.GetTranslation("gamehall.view.GameHallActiveEastView.bufferTitleTxt");
         _bufferDescTxt.text = LanguageMgr.GetTranslation("gamehall.view.GameHallActiveEastView.bufferDescTxt");
         var _loc1_:SkillTempInfo = TempleteManager.instance.getSkillTemplateInfoById(_bufferSKillId);
         if(_loc1_)
         {
            _bufferIconView.icon = IconFactory.getCommonIconPath(_loc1_.Icons);
            _bufferIconView.tipData = _loc1_;
         }
      }
      
      private function get model() : GameHallModel
      {
         return GameHallManager.instance.model;
      }
      
      private function addEvent() : void
      {
         if(_buyBufferBtn)
         {
            _buyBufferBtn.addEventListener("click",__buyBufferBtnHandler);
         }
         model.addEventListener("EVENT_FLITER_BUY",_filterBuyHandler);
      }
      
      private function removeEvent() : void
      {
         if(_buyBufferBtn)
         {
            _buyBufferBtn.removeEventListener("click",__buyBufferBtnHandler);
         }
         model.removeEventListener("EVENT_FLITER_BUY",_filterBuyHandler);
      }
      
      private function _filterBuyHandler(param1:Event) : void
      {
         if(_buyBufferBtn)
         {
            FlickerHelper.setFilcker(_buyBufferBtn);
         }
      }
      
      private function __buyBufferBtnHandler(param1:MouseEvent) : void
      {
         if(_buyBufferBtn)
         {
            FlickerHelper.clearFilcker(_buyBufferBtn);
         }
         _model.buyBuffer();
      }
      
      public function get buyBuffBtn() : BaseButton
      {
         return _buyBufferBtn;
      }
      
      public function refrehView() : void
      {
         _bufferText.text = _model.remainEffectiveNum + "/" + _model.effectiveNum;
         _buyBufferBtn.enable = _model.remainEffectiveNum > 0 ? false : true;
      }
      
      private function uninitView() : void
      {
         if(_buyBufferBtn)
         {
            FlickerHelper.clearFilcker(_buyBufferBtn);
         }
         ObjectUtils.disposeObject(_x3);
         _x3 = null;
         ObjectUtils.disposeObject(_buyBufferBtn);
         _buyBufferBtn = null;
         ObjectUtils.disposeObject(_bufferTitleTxt);
         _bufferTitleTxt = null;
         ObjectUtils.disposeObject(_bufferDescTxt);
         _bufferDescTxt = null;
         ObjectUtils.disposeObject(_bufferIconView);
         _bufferIconView = null;
         ObjectUtils.disposeObject(_bufferText);
         _bufferText = null;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

