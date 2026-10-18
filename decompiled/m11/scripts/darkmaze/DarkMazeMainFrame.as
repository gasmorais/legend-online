package darkmaze
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mainBar.ChatBar;
   import manager.LanguageMgr;
   import managers.DarkMazeManager;
   import managers.YearActiveManager;
   import mvc.module.darkmaze.DarkMazeModel;
   import mvc.module.darkmaze.DarkMazeNodeInfo;
   import ui.maintoolbar.MainToolBar;
   import ui.toptoolbar.TopToolsBar;
   import utils.LogicUtils;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.scene.BaseSceneView;
   import yishi.scene.SceneManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class DarkMazeMainFrame extends BaseSceneView
   {
      
      private var _bg:Image;
      
      private var _layerImage:Image;
      
      private var _layerTxt:FilterFrameText;
      
      private var _nodeSprite:Sprite;
      
      private var _toReadyBtn:BaseButton;
      
      private var _buyBtn:BaseButton;
      
      private var _helpBtn:BaseButton;
      
      private var _readyBtnDescTxt:FilterFrameText;
      
      private var _buyBtnDescTxt:FilterFrameText;
      
      private var _enterNextMc:MovieClip;
      
      private var _nodeArray:Array;
      
      private var _model:DarkMazeModel;
      
      public function DarkMazeMainFrame()
      {
         super();
      }
      
      override public function enter(param1:BaseSceneView, param2:Object = null) : void
      {
         super.enter(param1,param2);
         _model = DarkMazeManager.instance.model;
         initView();
         initEvent();
         initNodeLocation();
         DarkMazeManager.instance.darkMazeOperation(1);
         TopToolsBar.instance.hide();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("darkmazeFrame.bg");
         if(YearActiveManager.ins.isOpen)
         {
            _layerImage = ComponentFactory.Instance.creatComponentByStylename("darkmazeFrame.layerImage2");
         }
         else
         {
            _layerImage = ComponentFactory.Instance.creatComponentByStylename("darkmazeFrame.layerImage");
         }
         _toReadyBtn = ComponentFactory.Instance.creatComponentByStylename("darkmazeFrame.toReadyBtn");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("darkmazeFrame.buyBtn");
         _layerTxt = ComponentFactory.Instance.creatComponentByStylename("darkmazeFrame.layerTxt");
         _enterNextMc = ComponentFactory.Instance.creatCustomObject("darkmazeFrame.enterNextMc");
         _readyBtnDescTxt = ComponentFactory.Instance.creatComponentByStylename("darkmazeFrame.readyBtnDescTxt");
         _buyBtnDescTxt = ComponentFactory.Instance.creatComponentByStylename("darkmazeFrame.buyBtnDescTxt");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("darkmazeFrame.helpBtn");
         _nodeSprite = new Sprite();
         _nodeSprite.x = 55;
         addChild(_bg);
         addChild(_layerImage);
         addChild(_nodeSprite);
         addChild(_toReadyBtn);
         addChild(_buyBtn);
         addChild(_layerTxt);
         addChild(_enterNextMc);
         addChild(_readyBtnDescTxt);
         addChild(_buyBtnDescTxt);
         addChild(_helpBtn);
         _readyBtnDescTxt.text = LanguageMgr.GetTranslation("darkmaze.darkMazeMainFrame.readyBtnDescTxt");
         _buyBtnDescTxt.text = LanguageMgr.GetTranslation("darkmaze.darkMazeMainFrame.buyBtnDescTxt");
         _helpBtn.tipData = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanElection.helpTitle");
         _enterNextMc.visible = false;
         _enterNextMc.buttonMode = true;
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_nodeSprite);
         _nodeSprite = null;
         ObjectUtils.disposeObject(_toReadyBtn);
         _toReadyBtn = null;
         ObjectUtils.disposeObject(_layerImage);
         _layerImage = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_layerTxt);
         _layerTxt = null;
         ObjectUtils.disposeViolentMc(_enterNextMc);
         _enterNextMc = null;
         ObjectUtils.disposeObject(_readyBtnDescTxt);
         _readyBtnDescTxt = null;
         ObjectUtils.disposeObject(_buyBtnDescTxt);
         _buyBtnDescTxt = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         LogicUtils.disposeDisplayCollection(_nodeArray);
         _nodeArray = null;
      }
      
      private function initEvent() : void
      {
         StageReferance.stage.addEventListener("resize",__resizeHanlder);
         if(_toReadyBtn)
         {
            _toReadyBtn.addEventListener("click",__toReadyBtnHanlder);
         }
         if(_buyBtn)
         {
            _buyBtn.addEventListener("click",__buyBtnHandler);
         }
         if(_helpBtn)
         {
            _helpBtn.addEventListener("click",__helpBtnHandler);
         }
         if(_enterNextMc)
         {
            _enterNextMc.addEventListener("click",__enterNextLayerHandler);
         }
         NotificationManager.instance.addEventListener("DARK_MAZE_MOVE",_refreshView);
         NotificationManager.instance.addEventListener("DARK_MAZE_DATA_INIT",_refreshView);
         DarkMazeManager.instance.model.addEventListener("MOVE_TO_TARGET_NODE",__updateView);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHanlder);
         if(_toReadyBtn)
         {
            _toReadyBtn.removeEventListener("click",__toReadyBtnHanlder);
         }
         if(_buyBtn)
         {
            _buyBtn.removeEventListener("click",__buyBtnHandler);
         }
         if(_enterNextMc)
         {
            _enterNextMc.removeEventListener("click",__enterNextLayerHandler);
         }
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpBtnHandler);
         }
         NotificationManager.instance.removeEventListener("DARK_MAZE_MOVE",_refreshView);
         NotificationManager.instance.removeEventListener("DARK_MAZE_DATA_INIT",_refreshView);
         DarkMazeManager.instance.model.removeEventListener("MOVE_TO_TARGET_NODE",__updateView);
      }
      
      private function _refreshView(param1:Event) : void
      {
         if(_model.currentNodeId == 22)
         {
            _enterNextMc.visible = true;
         }
         else
         {
            _enterNextMc.visible = false;
         }
         refreshNodeStatus();
      }
      
      private function __updateView(param1:Event) : void
      {
         var _loc4_:DarkMazeNodeItemView = null;
         var _loc5_:DarkMazeNodeInfo = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         _loc6_ = 1;
         while(_loc6_ <= 22)
         {
            _loc4_ = _nodeArray[_loc6_ - 1] as DarkMazeNodeItemView;
            _loc5_ = _model.nodeInfoDic[_loc6_] as DarkMazeNodeInfo;
            _loc2_ = int(_model.posIndexArray[_loc6_ - 1].x);
            _loc3_ = int(_model.posIndexArray[_loc6_ - 1].y);
            if(_loc2_ == _model.moveTargetIndexPosX)
            {
               if(_loc3_ != _model.moveTargetIndexPosY)
               {
                  _loc4_.refreshView(false);
                  _loc4_.playMc();
               }
            }
            _loc6_++;
         }
      }
      
      private function __toReadyBtnHanlder(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("darkmaze",8);
      }
      
      private function __buyBtnHandler(param1:MouseEvent) : void
      {
         SimpleAlertHelper.instance.data = [confirmBuyBack];
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("darkmaze.darkMazeMainFrame.buyTxt",_model.costDiamondCount);
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc4_,_loc3_,_loc2_,true,false,false,2,"SIMPLE_ALERT");
      }
      
      private function __enterNextLayerHandler(param1:MouseEvent) : void
      {
         DarkMazeManager.instance.enterScene();
         DarkMazeManager.instance.darkMazeOperation(3);
      }
      
      private function __helpBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("darkmaze.helpFrame");
         _loc2_.show();
      }
      
      private function confirmBuyBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(_model.childIsAllMaxHp())
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("darkmaze.DarkMazeMainFrame.buyTips"));
               return;
            }
            if(PlayerManager.instance.currentPlayerModel.playerInfo.point < _model.costDiamondCount)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("sacrifice.sacrificeFrame.pointNotEnough"));
               return;
            }
            DarkMazeManager.instance.darkMazeOperation(5);
         }
      }
      
      private function initNodeLocation() : void
      {
         var _loc1_:DarkMazeNodeItemView = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         _nodeArray = [];
         _loc2_ = 1;
         while(_loc2_ <= 22)
         {
            _loc3_ = int(_model.posIndexArray[_loc2_ - 1].x);
            _loc4_ = int(_model.posIndexArray[_loc2_ - 1].y);
            _loc1_ = ComponentFactory.Instance.creatCustomObject("DarkMazeFrame.nodeItemView" + _loc2_,[_loc2_,_loc3_,_loc4_]);
            _nodeSprite.addChild(_loc1_);
            _nodeArray.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function refreshNodeStatus() : void
      {
         var _loc1_:DarkMazeNodeItemView = null;
         var _loc2_:DarkMazeNodeInfo = null;
         var _loc4_:int = 0;
         _layerTxt.text = _model.currentLayer.toString();
         var _loc3_:Array = _model.hasWalkedNodeArray;
         _loc4_ = 1;
         while(_loc4_ <= 22)
         {
            _loc1_ = _nodeArray[_loc4_ - 1] as DarkMazeNodeItemView;
            _loc2_ = _model.nodeInfoDic[_loc4_] as DarkMazeNodeInfo;
            _loc1_.data = _loc2_;
            _loc1_.typeImageVisible = true;
            _loc1_.visible = true;
            _loc1_.setLockImgeVisible(false);
            if(_loc4_ > _model.currentNodeId)
            {
               if(_loc1_.indexPosX == _model.currentIndexPosX + 1)
               {
                  if(_model.targetNodeId > 0)
                  {
                     if(_loc4_ == _model.targetNodeId)
                     {
                        _loc1_.refreshView(true);
                     }
                     else
                     {
                        _loc1_.typeImageVisible = false;
                        _loc1_.refreshView(false);
                        _loc1_.setLockImgeVisible(true);
                     }
                  }
                  else if(_model.targetNodeId <= 0)
                  {
                     if(_loc1_.indexPosY == _model.currentIndexPosY + 1 || _loc1_.indexPosY == _model.currentIndexPosY - 1)
                     {
                        _loc1_.refreshView(true);
                     }
                     else
                     {
                        _loc1_.refreshView(false);
                     }
                  }
               }
               else if(_loc1_.indexPosX == _model.currentIndexPosX)
               {
                  _loc1_.refreshView(false);
                  _loc1_.typeImageVisible = false;
                  _loc1_.setLockImgeVisible(true);
               }
               else
               {
                  _loc1_.refreshView(false);
               }
            }
            else if(_loc4_ == _model.currentNodeId)
            {
               _loc1_.refreshView(true);
            }
            else if(_loc4_ < _model.currentNodeId)
            {
               if(find(_loc3_,_loc4_))
               {
                  _loc1_.refreshView(true);
                  _loc1_.typeImageVisible = false;
               }
               else
               {
                  _loc1_.refreshView(false);
                  _loc1_.typeImageVisible = false;
                  _loc1_.setLockImgeVisible(true);
               }
            }
            _loc4_++;
         }
      }
      
      private function find(param1:Array, param2:int) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            if(param1[_loc4_] == param2)
            {
               _loc3_ = true;
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      override public function leaving() : void
      {
         dispose();
      }
      
      override public function get SceneName() : String
      {
         return "DARK_MAZE_SCENE";
      }
      
      override public function preLoadingStart(param1:Object = null) : void
      {
         super.preLoadingStart(param1);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,6,true,false,1,0,true);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function enterOver() : void
      {
         super.enterOver();
         MainToolBar.instance.updateFriendNoticeBtnPos(false);
         MainToolBar.instance.show();
         ChatBar.instance.show();
         MainToolBar.instance.getButtnByType(10).visible = false;
         MainToolBar.instance.getButtnByType(15).visible = false;
         MainToolBar.instance.getButtnByType(16).visible = false;
         MainToolBar.instance.getButtnByType(9).enable = true;
         MainToolBar.instance.getMovieImageByType(1).visible = false;
         MainToolBar.instance.getMovieImageByType(2).visible = false;
         SceneManager.instance.isEnterFullScene = true;
         __resizeHanlder();
      }
      
      private function __resizeHanlder(param1:Event = null) : void
      {
         x = (StageReferance.gameStageWidth - width) / 2;
         y = (StageReferance.gameStageHeight - height) / 2;
      }
      
      public function dispose() : void
      {
         TopToolsBar.instance.show();
         ChatBar.instance.hide();
         SceneManager.instance.isEnterFullScene = false;
         MainToolBar.instance.buttonsStageByScene(SceneManager.instance.currentType);
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         unInitView();
         ObjectUtils.disposeAllChildren(this);
         _model = null;
      }
   }
}

