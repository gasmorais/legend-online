package farm.view.marrytree
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import farm.FarmManager;
   import farm.data.FarmInfo;
   import farm.event.FarmEvent;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.ui.Mouse;
   import manager.LanguageMgr;
   import managers.MarryManager;
   import mvc.module.marry.MarriageGodTreeInfo;
   import mvc.module.marry.MarryModel;
   import mvc.module.marry.MarrySender;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.filter.UIFilter;
   import yishi.manager.CursorManagerII;
   import yishi.manager.DragManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   import yishi.view.tools.SimpleMovie;
   
   public class MarryTreeView extends Component
   {
      
      private var _land:BaseButton;
      
      private var _tree:ScaleFrameImage;
      
      private var _feedBtn:IconButton;
      
      private var _timeDown:MarryTreeTimeDownView;
      
      private var _info:MarriageGodTreeInfo;
      
      private var _stateList:Array;
      
      private var _hasOperEffect:MovieClip;
      
      private var _grassImg:Bitmap;
      
      private var _wormImg:Bitmap;
      
      private var _pickImg:Bitmap;
      
      private var _waterImg:Bitmap;
      
      private var _filter:UIFilter;
      
      private var _buildingFilter:SimpleBuildingFilter;
      
      private var _state:int = -1;
      
      private var _curentvalue:int;
      
      private var _totalCount:int = 2;
      
      private var _waterEffect:SimpleMovie;
      
      private var _needRefresh:Boolean;
      
      public function MarryTreeView()
      {
         super();
         setTotalTime();
         initView();
         initEvent();
      }
      
      private function setTotalTime() : void
      {
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("mar_feed_count");
         if(_loc1_ && !StringHelper.isNullOrEmpty(_loc1_.ConfigValue))
         {
            _totalCount = int(_loc1_.ConfigValue);
         }
      }
      
      private function initView() : void
      {
         _tree = ComponentFactory.Instance.creatComponentByStylename("MarryTreeView.Tree");
         _feedBtn = ComponentFactory.Instance.creatComponentByStylename("MarryTreeView.feedBtn");
         _hasOperEffect = ComponentFactory.Instance.creatCustomObject("MarryTree.HasOperEffect");
         _grassImg = ComponentFactory.Instance.creatBitmap("asset.farm.FarmLandItemGrassImg");
         _wormImg = ComponentFactory.Instance.creatBitmap("asset.farm.FarmLandItemWormImg");
         _pickImg = ComponentFactory.Instance.creatBitmap("asset.farm.FarmLandItemPickImg");
         _waterImg = ComponentFactory.Instance.creatBitmap("asset.water.WaterStateImg");
         _land = ComponentFactory.Instance.creatComponentByStylename("MarryTreeView.land");
         _land.tipData = LanguageMgr.GetTranslation("farm.view.marrytree.MarryTreeView.openAfterMarry");
         _filter = new UIFilter();
         _buildingFilter = new SimpleBuildingFilter();
         _timeDown = new MarryTreeTimeDownView();
         addChild(_tree);
         _tree.setFrame(2);
         addChild(_timeDown);
         _timeDown.visible = false;
         _hasOperEffect.mouseEnabled = _hasOperEffect.mouseChildren = false;
         tipStyle = "yishi.view.tips.OneLineTip";
         tipDirctions = "1,2,3,4,5,6,7";
         tipGapH = -270;
         isFollowMouse = false;
      }
      
      public function get feedBtn() : IconButton
      {
         return _feedBtn;
      }
      
      public function get lang() : BaseButton
      {
         return _land;
      }
      
      private function initEvent() : void
      {
         _feedBtn.addEventListener("click",__feedBtnHandler);
         FarmManager.instance.model.addEventListener("SELECTED_CHANGE",onSelectedChange);
         addEventListener("click",__clickHandler);
         addEventListener("rollOver",__onItemOver);
         addEventListener("rollOut",__onItemOut);
         MsgMan.addObserver("MarryEventType.SELF_MARRY_INFO",this,__marryInfoHandler);
         MsgMan.addObserver("MarryEventType.MARRIAGE_DATA",this,__treeUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         if(_feedBtn)
         {
            _feedBtn.removeEventListener("click",__feedBtnHandler);
         }
         FarmManager.instance.model.removeEventListener("SELECTED_CHANGE",onSelectedChange);
         removeEventListener("click",__clickHandler);
         removeEventListener("rollOver",__onItemOver);
         removeEventListener("rollOut",__onItemOut);
         MsgMan.removeObserver("MarryEventType.MARRIAGE_DATA",this,__treeUpdateHandler);
         MsgMan.removeObserver("MarryEventType.SELF_MARRY_INFO",this,__marryInfoHandler);
      }
      
      private function onSelectedChange(param1:FarmEvent) : void
      {
         var _loc2_:FarmInfo = param1.data as FarmInfo;
         info = _loc2_;
      }
      
      private function __onItemOver(param1:MouseEvent) : void
      {
         _buildingFilter.setBuildingOverFilter(_tree);
         setCursorByOper();
      }
      
      private function __onItemOut(param1:MouseEvent) : void
      {
         _buildingFilter.setBuildingOutFilter(_tree);
         if(!DragManager.getInstance().isDraging)
         {
            CursorManagerII.instance.resetCursor();
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         switch(_state)
         {
            case 0:
               if(isMine == false)
               {
                  return;
               }
               MarryManager.instance.creatTreeFosterFrame(_curentvalue);
               break;
            case 1:
            case 2:
               MarrySender.opMarryTree(1003,-1,FarmManager.instance.model.curSelectedFarmInfo.userId);
               break;
            case 3:
               MarrySender.opMarryTree(1004);
               break;
            case 4:
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("farm.view.marrytree.MarryTreeView.harvestLimit"));
         }
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         if(_info == null)
         {
            return;
         }
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(param1:int) : void
      {
         var _loc2_:DisplayObject = null;
         if(!_needRefresh && _state == param1)
         {
            return;
         }
         _state = param1;
         tipData = "";
         if(_hasOperEffect.parent)
         {
            _hasOperEffect.parent.removeChild(_hasOperEffect);
         }
         _hasOperEffect.gotoAndStop("hasOperEffect");
         _hasOperEffect["hasOperBox"].play();
         if(_grassImg.parent)
         {
            _grassImg.parent.removeChild(_grassImg);
         }
         if(_wormImg.parent)
         {
            _wormImg.parent.removeChild(_wormImg);
         }
         if(_pickImg.parent)
         {
            _pickImg.parent.removeChild(_pickImg);
         }
         if(_waterImg.parent)
         {
            _waterImg.parent.removeChild(_waterImg);
         }
         _tree.setFrame(2);
         _feedBtn.visible = false;
         _filter.setNormalFilter(_hasOperEffect["hasOperBox"]);
         switch(param1)
         {
            case 0:
               _feedBtn.visible = false;
               break;
            case 1:
               _feedBtn.visible = false;
               _loc2_ = _grassImg;
               break;
            case 2:
               _feedBtn.visible = false;
               _loc2_ = _wormImg;
               break;
            case 3:
               _feedBtn.visible = true;
               _loc2_ = _pickImg;
               _tree.setFrame(1);
               break;
            case 4:
               _loc2_ = _waterImg;
               _tree.setFrame(1);
         }
         MsgMan.notifyObserver("MarryEventType.TREE_CHANGE_CLIENT",_curentvalue);
         if(_loc2_)
         {
            _hasOperEffect.gotoAndStop("hasOperEffect");
            _hasOperEffect["hasOperBox"]["box"].addChild(_loc2_);
            addChild(_hasOperEffect);
         }
         _needRefresh = false;
         if(this.mouseX > 0 && this.mouseX < 273 && this.mouseY > 0 && this.mouseY < 290)
         {
            __onItemOver(null);
         }
      }
      
      private function checkScene() : Boolean
      {
         var _loc1_:Boolean = false;
         switch(SceneManager.instance.currentType)
         {
            case "CASTLE_SCENE":
            case "SPACE_SCENE":
               _loc1_ = true;
               break;
            default:
               _loc1_ = false;
         }
         return _loc1_;
      }
      
      private function __marryInfoHandler(param1:String, param2:Object) : void
      {
         if(MarryManager.instance.model.isSingle)
         {
            info = null;
         }
      }
      
      private function __treeUpdateHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      public function set info(param1:FarmInfo) : void
      {
         if(!param1 || model.marriangeState == 0 && isMine || !isMine && param1.userId != model.selfMarryInfo.userId)
         {
            mouseChildren = false;
            mouseEnabled = false;
            visible = false;
            if(_land)
            {
               _land.visible = true;
            }
            if(_feedBtn)
            {
               _feedBtn.visible = false;
            }
            if(_timeDown)
            {
               _timeDown.visible = false;
            }
            return;
         }
         mouseChildren = true;
         mouseEnabled = true;
         if(_land)
         {
            _land.visible = false;
         }
         visible = true;
         refreshView();
      }
      
      private function __effectComplete(param1:Event) : void
      {
         if(!_waterEffect)
         {
            return;
         }
         mouseEnabled = true;
         mouseChildren = true;
         _waterEffect.removeEventListener("complete",__effectComplete);
         _waterEffect = null;
      }
      
      private function refreshView() : void
      {
         var _loc1_:int = 0;
         if(isMine)
         {
            state = treeInfo.treeState;
            _timeDown.visible = true;
            _loc1_ = DateFormatter.parse(treeInfo.treeEarningDate,"YYYY-MM-DD hh:mm:ss").time / 1000 + 43200 - playerModel.sysCurTimeBySecond;
            _timeDown.setCount(_loc1_);
         }
         else
         {
            _timeDown.visible = false;
            state = treeInfo.mateTreeState;
         }
         _needRefresh = true;
         __timerHandler(null);
      }
      
      private function get treeInfo() : MarriageGodTreeInfo
      {
         return MarryManager.instance.model.marriageData.godTreeInfo;
      }
      
      private function get model() : MarryModel
      {
         return MarryManager.instance.model;
      }
      
      private function get isMine() : Boolean
      {
         if(FarmManager.instance.model.curSelectedFarmInfo == null)
         {
            return false;
         }
         return FarmManager.instance.model.curSelectedFarmInfo.userId == playerModel.playerInfo.userId;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function __feedBtnHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         if(isMine)
         {
            MarryManager.instance.creatTreeFosterFrame(_curentvalue);
         }
      }
      
      private function setCursorByOper() : void
      {
         if(DragManager.getInstance().isDraging || Boolean(DoubleClickManager.Instance.isClicking))
         {
            return;
         }
         CursorManagerII.instance.resetCursor();
         switch(_state - 1)
         {
            case 0:
               CursorManagerII.instance.showCursorByType("FARM_WEED_CURSOR");
               break;
            case 1:
               CursorManagerII.instance.showCursorByType("FARM_WORM_CURSOR");
               break;
            case 2:
               CursorManagerII.instance.resetCursor();
               break;
            case 3:
               CursorManagerII.instance.showCursorByType("WATER_CURSOR");
               break;
            default:
               Mouse.hide();
               Mouse.cursor = "button";
               Mouse.show();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_tree)
         {
            ObjectUtils.disposeObject(_tree);
         }
         _tree = null;
         if(_feedBtn)
         {
            ObjectUtils.disposeObject(_feedBtn);
         }
         _feedBtn = null;
         if(_timeDown)
         {
            ObjectUtils.disposeObject(_timeDown);
         }
         _timeDown = null;
         ObjectUtils.disposeObject(_grassImg);
         _grassImg = null;
         ObjectUtils.disposeObject(_wormImg);
         _wormImg = null;
         ObjectUtils.disposeObject(_pickImg);
         _pickImg = null;
         ObjectUtils.disposeObject(_waterImg);
         _waterImg = null;
         ObjectUtils.disposeViolentMc(_hasOperEffect);
         _hasOperEffect = null;
         if(_waterEffect)
         {
            _waterEffect.removeEventListener("complete",__effectComplete);
            _waterEffect = null;
         }
         _filter = null;
         _buildingFilter = null;
         super.dispose();
      }
   }
}

