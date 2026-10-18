package childspiritexpedition
{
   import battle.utils.Helpers;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.ComponentGroupManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import mainBar.SmallMapBar;
   import mainBar.TimeBoxView;
   import managers.SpiritExpeditionManager;
   import mvc.controler.SpiritExpeditionControl;
   import mvc.module.childspiritexpedition.SpiritExpeditionModel;
   import ui.maintoolbar.MainToolBar;
   import ui.queuebar.QueueBar;
   import ui.resourcebar.ResourcesBar;
   import ui.tasktracebar.TaskTraceBar;
   import ui.toptoolbar.TopToolsBar;
   import utils.LogicUtils;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.utils.MsgMan;
   import yishi.view.base.ProgressPanel;
   
   public class SpiritExpeditionFrame extends Frame
   {
      
      private var _sprite:Sprite;
      
      private var _viewCon:Component;
      
      private var _bg:Bitmap;
      
      private var _rewardTitle:Bitmap;
      
      private var _rewardBar:ProgressPanel;
      
      private var _rewardBox:HBox;
      
      private var _mapCon:Component;
      
      private var rewardList:Vector.<SpiritExpeditionRewardItem>;
      
      private var mapList:Vector.<SpiritExpeditionMapItem>;
      
      private var nodePosAry:Array = [[760,311],[665,0],[485,298],[397,0],[0,280],[2,-1]];
      
      private var maxStar:int;
      
      public function SpiritExpeditionFrame()
      {
         super();
         initView();
         initMapView();
         initRewardView();
         addEvent();
         SpiritExpeditionManager.instance.sendExpeditionDataRequest();
      }
      
      override public function get groups() : Array
      {
         return ["FULL_SCREEN_FRAME"];
      }
      
      private function initView() : void
      {
         ComponentGroupManager.Instance.disposeAllOpenFrame();
         _bg = ComponentFactory.Instance.creatBitmap("asset.SpiritExpeditionFrame.bg");
         _viewCon = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionFrame.viewCon");
         _rewardBox = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionFrame.rewardBox");
         _rewardTitle = ComponentFactory.Instance.creatBitmap("asset.SpiritExpeditionFrame.rewardTitle");
         _mapCon = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionFrame.mapCon");
         _rewardBar = ComponentFactory.Instance.creatCustomObject("SpiritExpeditionFrame.rewardBar");
         _rewardBar.initView("SpiritExpeditionFrame.rewardBarbg","SpiritExpeditionFrame.rewardBarColor","");
         _rewardBar.barPosxy(13,3);
         _sprite = new Sprite();
         addToContent(_sprite);
         addToContent(_viewCon);
         _viewCon.addChild(_bg);
         _viewCon.addChild(_mapCon);
         _viewCon.addChild(_rewardTitle);
         _viewCon.addChild(_rewardBar);
         _viewCon.addChild(_rewardBox);
      }
      
      private function initRewardView() : void
      {
         var _loc2_:int = 0;
         var _loc4_:String = null;
         var _loc1_:SpiritExpeditionRewardItem = null;
         rewardList = new Vector.<SpiritExpeditionRewardItem>();
         var _loc5_:Dictionary = TempleteManager.instance.spiritExpeditionStarDropTempCate.getTemplates();
         var _loc3_:Array = Helpers.getKeyList(_loc5_);
         maxStar = _loc3_[_loc3_.length - 1];
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            _loc4_ = _loc3_[_loc2_];
            _loc1_ = new SpiritExpeditionRewardItem(_loc2_);
            _loc1_.star = int(_loc4_);
            _loc1_.rewardAry = _loc5_[_loc4_];
            _rewardBox.addChild(_loc1_);
            rewardList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function initMapView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:SpiritExpeditionMapItem = null;
         mapList = new Vector.<SpiritExpeditionMapItem>();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = new SpiritExpeditionMapItem(_loc2_ + 1);
            _loc1_.x = nodePosAry[_loc2_][0];
            _loc1_.y = nodePosAry[_loc2_][1];
            mapList.push(_loc1_);
            _mapCon.addChild(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         StageReferance.stage.addEventListener("resize",__resizeHanlder);
         NotificationManager.instance.addEventListener("CLOSE_SPIRITEXPEDITION_FRAME",__closeFrameHandler);
         NotificationManager.instance.addEventListener("SWITCH_SCENE",__closeFrameHandler);
         MsgMan.addObserver("EXPEDITION_INFO_UPDATE",this,__updateExpeditionHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         StageReferance.stage.removeEventListener("resize",__resizeHanlder);
         NotificationManager.instance.removeEventListener("CLOSE_SPIRITEXPEDITION_FRAME",__closeFrameHandler);
         NotificationManager.instance.removeEventListener("SWITCH_SCENE",__closeFrameHandler);
         MsgMan.removeObserver("EXPEDITION_INFO_UPDATE",this,__updateExpeditionHandler);
      }
      
      private function __updateExpeditionHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __closeFrameHandler(param1:NotificationEvent) : void
      {
         dispose();
      }
      
      private function refreshView() : void
      {
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc3_:Number = NaN;
         _loc4_ = 0;
         while(_loc4_ < rewardList.length)
         {
            rewardList[_loc4_].refreshView();
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < mapList.length)
         {
            mapList[_loc4_].data = _loc4_ < model.areaInfoList.length ? model.areaInfoList[_loc4_] : null;
            _loc4_++;
         }
         var _loc1_:int = int(model.getTotalStar());
         var _loc8_:Dictionary = TempleteManager.instance.spiritExpeditionStarDropTempCate.getTemplates();
         var _loc6_:Array = Helpers.getKeyList(_loc8_);
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc6_.length)
         {
            if(_loc1_ <= _loc6_[_loc4_])
            {
               _loc2_ = int(_loc6_[_loc4_]);
               _loc7_ = int(_loc4_ < 1 ? 0 : _loc6_[_loc4_ - 1]);
               _loc3_ = _loc4_ / _loc6_.length;
               break;
            }
            _loc4_++;
         }
         _loc5_ = _loc3_ + (_loc1_ - _loc7_) / (_loc2_ - _loc7_) * (1 / _loc6_.length);
         _rewardBar.setPrecentValue(_loc5_);
      }
      
      private function __resizeHanlder(param1:Event) : void
      {
         var _loc2_:int = int(StageReferance.stageWidth);
         var _loc3_:int = int(StageReferance.stageHeight);
         setShape(_loc2_,_loc3_);
         x = 0;
         y = 0;
         width = _loc2_;
         height = _loc3_;
         _viewCon.x = (_loc2_ - 1422) / 2;
         _viewCon.y = (_loc3_ - 800) / 2;
         _loc3_;
      }
      
      private function setShape(param1:int, param2:int) : void
      {
         _sprite.graphics.clear();
         _sprite.graphics.beginFill(0,1);
         _sprite.graphics.drawRect(0,0,param1,param2);
         _sprite.graphics.endFill();
      }
      
      public function hideTool() : void
      {
         TopToolsBar.instance.hide();
         TaskTraceBar.instance.hide();
         QueueBar.instance.hide();
         ResourcesBar.instance.hide();
         SmallMapBar.instance.hide();
         MainToolBar.instance.getButtnByType(10).visible = false;
         MainToolBar.instance.getButtnByType(15).visible = false;
         MainToolBar.instance.getButtnByType(9).enable = true;
         MainToolBar.instance.getMovieImageByType(1).visible = false;
         MainToolBar.instance.getMovieImageByType(2).visible = false;
         TimeBoxView.instance.hide();
         NotificationManager.instance.dispatchEvent(new NotificationEvent("HIDE_FREEDOMTEAMLIST",true));
      }
      
      public function showToolView() : void
      {
         TopToolsBar.instance.show();
         TaskTraceBar.instance.show();
         QueueBar.instance.show();
         ResourcesBar.instance.show();
         SmallMapBar.instance.show();
         MainToolBar.instance.buttonsStageByScene(SceneManager.instance.currentType);
         MainToolBar.instance.recommendBtnIsExist(null);
         TimeBoxView.instance.show();
         NotificationManager.instance.dispatchEvent(new NotificationEvent("HIDE_FREEDOMTEAMLIST",false));
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         control.isInSpiritExpeditionFrame = true;
         LayerManager.Instance.addToLayer(this,6,true,true);
         KeyBoardRegister.instance.keyEnable = false;
         __resizeHanlder(null);
         hideTool();
      }
      
      private function get model() : SpiritExpeditionModel
      {
         return SpiritExpeditionManager.instance.model;
      }
      
      private function get control() : SpiritExpeditionControl
      {
         return FrameControllerManager.instance.spiritExpeditionControl;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeObject(_sprite);
         _sprite = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_mapCon);
         _mapCon = null;
         ObjectUtils.disposeObject(_rewardBar);
         _rewardBar = null;
         ObjectUtils.disposeObject(_rewardBox);
         _rewardBox = null;
         ObjectUtils.disposeObject(_viewCon);
         _viewCon = null;
         ObjectUtils.disposeObject(_rewardTitle);
         _rewardTitle = null;
         LogicUtils.disposeDisplayCollection(rewardList);
         rewardList = null;
         LogicUtils.disposeDisplayCollection(mapList);
         mapList = null;
         control.isInSpiritExpeditionFrame = false;
         showToolView();
         super.dispose();
      }
   }
}

