package map.campaign.view.ui.unrealshooting
{
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.data.UnrealShootingModel;
   import map.campaign.data.UnrealShootingUserInfo;
   import map.campaign.event.UnrealShootingEvent;
   import mvc.controler.UnrealShootingController;
   import utils.LogicUtils;
   import yishi.manager.FrameControllerManager;
   
   public class UnrealShootingSortTopView extends Sprite implements Disposeable
   {
      
      private const MAX_COUNT:int = 8;
      
      private var _tipsBg:Image;
      
      private var _bg:MutipleImage;
      
      private var _switchBtn:Sprite;
      
      private var _arrowImg:Bitmap;
      
      private var _itemVBox:VBox;
      
      private var _itemList:Vector.<UnrealShootingSortTopItem>;
      
      private var _selfTeamTipsTxt:FilterFrameText;
      
      private var _selfTeamIcon:ScaleFrameImage;
      
      private var _selfScoreTipsTxt:FilterFrameText;
      
      private var _selfScoreTxt:FilterFrameText;
      
      private var _controller:UnrealShootingController = FrameControllerManager.instance.unrealShootingController;
      
      private var _model:UnrealShootingModel = _controller.model;
      
      private var _isShow:Boolean = false;
      
      public function UnrealShootingSortTopView()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _tipsBg = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingSortTopView.TipsBg");
         _bg = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingSortTopView.Bg");
         _arrowImg = ComponentFactory.Instance.creatBitmap("asset.campaign.GVGManageViewArrowImg");
         _switchBtn = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingSortTopView.SwitchBtn");
         _switchBtn.graphics.beginFill(16711680,0);
         _switchBtn.graphics.drawRect(0,0,28,89);
         _switchBtn.graphics.endFill();
         _switchBtn.buttonMode = true;
         _itemVBox = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingSortTopView.ItemVBox");
         _selfTeamTipsTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingSortTopView.SelfTeamTipsTxt");
         _selfTeamIcon = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingSortTopView.SelfTeamIcon");
         _selfScoreTipsTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingSortTopView.SelfScoreTipsTxt");
         _selfScoreTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingSortTopView.SelfScoreTxt");
         _selfTeamTipsTxt.text = LanguageMgr.GetTranslation("map.campaign.view.ui.unrealshooting.UnrealShootingSortTopView.selfTeamTips");
         _selfScoreTipsTxt.text = LanguageMgr.GetTranslation("map.campaign.view.ui.unrealshooting.UnrealShootingSortTopView.selfScoreTips");
         _selfTeamIcon.setFrame(_model.selfTeam);
         _switchBtn.addChild(_arrowImg);
         addChild(_tipsBg);
         addChild(_bg);
         addChild(_switchBtn);
         addChild(_itemVBox);
         addChild(_selfTeamTipsTxt);
         addChild(_selfTeamIcon);
         addChild(_selfScoreTipsTxt);
         addChild(_selfScoreTxt);
         _tipsBg.width = 221;
         initItemListView();
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_tipsBg);
         _tipsBg = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeAllChildren(_switchBtn);
         ObjectUtils.disposeObject(_switchBtn);
         _switchBtn = null;
         ObjectUtils.disposeObject(_itemVBox);
         _itemVBox = null;
         ObjectUtils.disposeObject(_selfTeamTipsTxt);
         _selfTeamTipsTxt = null;
         ObjectUtils.disposeObject(_selfTeamIcon);
         _selfTeamIcon = null;
         ObjectUtils.disposeObject(_selfScoreTipsTxt);
         _selfScoreTipsTxt = null;
         ObjectUtils.disposeObject(_selfScoreTxt);
         _selfScoreTxt = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function initItemListView() : void
      {
         var _loc1_:UnrealShootingSortTopItem = null;
         var _loc3_:int = 0;
         _itemList = new Vector.<UnrealShootingSortTopItem>();
         var _loc2_:int = 8;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = new UnrealShootingSortTopItem();
            _loc1_.data = null;
            _itemList.push(_loc1_);
            _itemVBox.addChild(_loc1_);
            _loc3_++;
         }
      }
      
      private function addEvent() : void
      {
         if(_switchBtn)
         {
            _switchBtn.addEventListener("click",__switchBtnClickHandler);
         }
         _model.addEventListener("UNREAL_SHOOTING_RANK_DETAIL_LIST_CHANGE",__rankDetailListChangeHandler);
      }
      
      private function removeEvent() : void
      {
         if(_switchBtn)
         {
            _switchBtn.removeEventListener("click",__switchBtnClickHandler);
         }
         _model.removeEventListener("UNREAL_SHOOTING_RANK_DETAIL_LIST_CHANGE",__rankDetailListChangeHandler);
      }
      
      private function __rankDetailListChangeHandler(param1:UnrealShootingEvent) : void
      {
         refreshView();
      }
      
      private function __switchBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _isShow = !_isShow;
         if(_isShow)
         {
            doShow();
         }
         else
         {
            doHide();
         }
      }
      
      private function doShow() : void
      {
         _arrowImg.scaleX = -1;
         _arrowImg.x = 19;
         _arrowImg.y = 5;
         TweenMax.killTweensOf(this);
         TweenMax.to(this,0.5,{"x":StageReferance.stageWidth - this.width});
      }
      
      private function doHide() : void
      {
         _arrowImg.scaleX = 1;
         _arrowImg.x = 6;
         _arrowImg.y = 5;
         TweenMax.killTweensOf(this);
         TweenMax.to(this,0.5,{"x":StageReferance.stageWidth - 28});
      }
      
      public function refreshView() : void
      {
         var _loc1_:UnrealShootingSortTopItem = null;
         var _loc4_:UnrealShootingUserInfo = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _itemList.length)
         {
            _loc2_ = _loc3_ + 1;
            _loc1_ = _itemList[_loc3_];
            if(_model.rankDetailList && _loc3_ < _model.rankDetailList.length)
            {
               _loc4_ = _model.rankDetailList[_loc3_] as UnrealShootingUserInfo;
               _loc4_.rank = _loc2_;
               _loc1_.data = _loc4_;
            }
            else
            {
               _loc1_.data = null;
            }
            switch(_loc3_)
            {
               case 0:
                  _loc1_.setFrame(2);
                  break;
               case 1:
                  _loc1_.setFrame(3);
                  break;
               case 2:
                  _loc1_.setFrame(4);
                  break;
               default:
                  _loc1_.setFrame(5);
            }
            _loc3_++;
         }
         _selfScoreTxt.text = _model.selfScore.toString();
      }
      
      public function stageResizeHandler() : void
      {
         if(_isShow)
         {
            x = StageReferance.stageWidth - this.width;
            doShow();
         }
         else
         {
            x = StageReferance.stageWidth - 28;
            doHide();
         }
      }
      
      public function show() : void
      {
         stageResizeHandler();
         y = 205;
         LayerManager.Instance.addToLayer(this,4,false,false,0,1);
      }
      
      public function dispose() : void
      {
         TweenMax.killTweensOf(this);
         removeEvent();
         uninitView();
      }
   }
}

