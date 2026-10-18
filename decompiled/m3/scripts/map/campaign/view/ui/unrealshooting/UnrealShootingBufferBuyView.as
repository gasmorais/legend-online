package map.campaign.view.ui.unrealshooting
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ArmyEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.UnrealShootingModel;
   import map.campaign.event.UnrealShootingEvent;
   import mvc.controler.UnrealShootingController;
   import utils.LogicUtils;
   import yishi.manager.FrameControllerManager;
   
   public class UnrealShootingBufferBuyView extends Sprite implements Disposeable
   {
      
      private var _tipsBg:Image;
      
      private var _bg:MutipleImage;
      
      private var _switchBtn:Sprite;
      
      private var _arrowImg:Bitmap;
      
      private var _itemVBox:VBox;
      
      private var _itemList:Vector.<UnrealShootingBufferBuyItem>;
      
      private var _selfPointTipsTxt:FilterFrameText;
      
      private var _selfPointTxt:FilterFrameText;
      
      private var _controller:UnrealShootingController = FrameControllerManager.instance.unrealShootingController;
      
      private var _model:UnrealShootingModel = _controller.model;
      
      private var _selfArmy:CampaignArmy = CampaignManager.instance.mapModel.selfMemberData;
      
      private var _isShow:Boolean = false;
      
      public function UnrealShootingBufferBuyView()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _tipsBg = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingBufferBuyView.TipsBg");
         _bg = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingBufferBuyView.Bg");
         _arrowImg = ComponentFactory.Instance.creatBitmap("asset.campaign.GVGManageViewArrowImg");
         _switchBtn = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingBufferBuyView.SwitchBtn");
         _switchBtn.graphics.beginFill(16711680,0);
         _switchBtn.graphics.drawRect(0,0,28,89);
         _switchBtn.graphics.endFill();
         _switchBtn.buttonMode = true;
         _itemVBox = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingBufferBuyView.ItemVBox");
         _selfPointTipsTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingBufferBuyView.SelfPointTipsTxt");
         _selfPointTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingBufferBuyView.SelfPointTxt");
         _selfPointTipsTxt.text = LanguageMgr.GetTranslation("map.campaign.view.ui.unrealshooting.UnrealShootingBufferBuyView.selfPointTips");
         _switchBtn.addChild(_arrowImg);
         addChild(_tipsBg);
         addChild(_bg);
         addChild(_switchBtn);
         addChild(_itemVBox);
         addChild(_selfPointTipsTxt);
         addChild(_selfPointTxt);
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
         ObjectUtils.disposeObject(_selfPointTipsTxt);
         _selfPointTipsTxt = null;
         ObjectUtils.disposeObject(_selfPointTxt);
         _selfPointTxt = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function initItemListView() : void
      {
         var _loc1_:UnrealShootingBufferBuyItem = null;
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         _itemList = new Vector.<UnrealShootingBufferBuyItem>();
         var _loc5_:Array = _model.unrealShootingBuffArray;
         var _loc2_:Array = _model.unrealShootingBuffCostArray;
         var _loc4_:int = int(_loc5_.length);
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc7_ = int(_loc5_[_loc6_]);
            _loc3_ = int(_loc2_[_loc6_]);
            _loc1_ = new UnrealShootingBufferBuyItem(_loc7_,_loc3_);
            _itemList.push(_loc1_);
            _itemVBox.addChild(_loc1_);
            _loc6_++;
         }
      }
      
      private function addEvent() : void
      {
         if(_selfArmy)
         {
            _selfArmy.addEventListener("ADD_BUFF",__addBuffHandler);
            _selfArmy.addEventListener("REMOVE_BUFF",__removeBuffHandler);
            _selfArmy.addEventListener("UNREAL_MAZE_INFO_CHANGE",__onUnrealShootingInfoChangeHandler);
         }
         if(_switchBtn)
         {
            _switchBtn.addEventListener("click",__switchBtnClickHandler);
         }
         _model.addEventListener("UNREAL_SHOOTING_RANK_DETAIL_LIST_CHANGE",__rankDetailListChangeHandler);
      }
      
      private function removeEvent() : void
      {
         if(_selfArmy)
         {
            _selfArmy.removeEventListener("ADD_BUFF",__addBuffHandler);
            _selfArmy.removeEventListener("REMOVE_BUFF",__removeBuffHandler);
            _selfArmy.removeEventListener("UNREAL_MAZE_INFO_CHANGE",__onUnrealShootingInfoChangeHandler);
         }
         if(_switchBtn)
         {
            _switchBtn.removeEventListener("click",__switchBtnClickHandler);
         }
         _model.removeEventListener("UNREAL_SHOOTING_RANK_DETAIL_LIST_CHANGE",__rankDetailListChangeHandler);
      }
      
      private function __addBuffHandler(param1:ArmyEvent) : void
      {
         refreshView();
      }
      
      private function __removeBuffHandler(param1:ArmyEvent) : void
      {
         refreshView();
      }
      
      private function __onUnrealShootingInfoChangeHandler(param1:ArmyEvent) : void
      {
         refreshView();
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
         _arrowImg.scaleX = 1;
         _arrowImg.x = 2;
         _arrowImg.y = 5;
         TweenMax.killTweensOf(this);
         TweenMax.to(this,0.5,{"x":0});
      }
      
      private function doHide() : void
      {
         _arrowImg.scaleX = -1;
         _arrowImg.x = 20;
         _arrowImg.y = 5;
         TweenMax.killTweensOf(this);
         TweenMax.to(this,0.5,{"x":28 - this.width});
      }
      
      public function refreshView() : void
      {
         var _loc1_:UnrealShootingBufferBuyItem = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _itemList.length)
         {
            _loc1_ = _itemList[_loc2_];
            if(_selfArmy)
            {
               if(_selfArmy.unrealShootingBuffIdDic.hasOwnProperty(_loc1_.templateId) && _selfArmy.unrealShootingBuffIdDic[_loc1_.templateId])
               {
                  _loc1_.buyEnable = false;
               }
               else
               {
                  _loc1_.buyEnable = true;
               }
            }
            _loc2_++;
         }
         _selfPointTxt.text = _model.selfPoint.toString();
      }
      
      public function stageResizeHandler() : void
      {
         if(_isShow)
         {
            x = 0;
            doShow();
         }
         else
         {
            x = 28 - this.width;
            doHide();
         }
      }
      
      public function show() : void
      {
         stageResizeHandler();
         y = 272;
         LayerManager.Instance.addToLayer(this,4,false,false,0,3);
      }
      
      public function dispose() : void
      {
         TweenMax.killTweensOf(this);
         removeEvent();
         uninitView();
      }
   }
}

